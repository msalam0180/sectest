jQuery(
  function ($) {
    $("#download").click(function (e) {
      e.preventDefault();
      let charts = Highcharts.charts.filter(Boolean);
      charts[0].downloadCSV();
    });

    let mapPath = "/modules/custom/sec_custom_blocks/js/oasb_raising_capital_map/";
    let dataPath = "/files/";
    let mapType;
    let countyMode = false;
    var showMetroMap = false;
    const mapTypes = ["regCF", "regA", "regD", "registered"];

    $(document).ready(async function () {
      document.getElementById("locationSelection").addEventListener("change", filterByValue);

      (function (H) {
        H.wrap(H.Chart.prototype, "getCSV", function (p, useLocalDecimalPoint) {
          // let csv = "";
          let generatedHTML = "";
          for (let map of mapTypes) {
            const stateFilters = window[`${map}_filters`];
            const countyFilters = window[`${map}_county_filters`];
            for (let filter of stateFilters) {
              let data = window[`${map}_${filter.key}`];
              //csv += generateCSV(data, `${window[`${map}_mapTitle`]}(${filter.text})`);
              generatedHTML += generateA11yTable(data, `${window[`${map}_mapTitle`]}(${filter.text})`);
            }
            if (countyFilters?.length) {
              for (let filter of countyFilters) {
                let data = window[`${map}_${filter.key}`];
                // csv += generateCSV(data, `${window[`${map}_mapTitle`]} (County ${filter.text})`, "county");
                generatedHTML += generateA11yTable(data, `${window[`${map}_mapTitle`]} (County ${filter.text})`, "county");
              }
            }
          }
          //return csv;
        });

      })(Highcharts);

      (function (H) {
        H.addEvent(H.Axis, "afterInit", function () {
          const logarithmic = this.logarithmic;
          if (logarithmic && this.options.allowNegativeLog) {
            // Avoid errors on negative numbers on a log axis
            this.positiveValuesOnly = false;
            // Override the converter functions
            logarithmic.log2lin = (num) => {
              const isNegative = num < 0;
              let adjustedNum = Math.abs(num);
              if (adjustedNum < 10) {
                adjustedNum += (10 - adjustedNum) / 10;
              }
              const result = Math.log(adjustedNum) / Math.LN10;
              return isNegative ? -result : result;
            };

            logarithmic.lin2log = (num) => {
              const isNegative = num < 0;
              let result = Math.pow(10, Math.abs(num));
              if (result < 10) {
                result = (10 * (result - 1)) / (10 - 1);
              }
              return isNegative ? -result : result;
            };
          }
        });
      })(Highcharts);
      const dataSet = await fetchDataFiles();
      createVariables(dataSet);
      createMapDropdown();
      // createA11yDataTables();
      loadMap();
      showFilter();
    });

    async function fetchDataFiles() {
      return Promise.all(
        [...mapTypes, "county"].map((fileName) => fetch(dataPath + `${fileName.toLowerCase()}.json`).then((data) => data.json()))
      );
    }

    function createVariables(dataSet) {
      for (let item of dataSet) {
        for (let [key, value] of Object.entries(item)) {
          window[key] = value;
        }
      }
    }

    function createMapDropdown() {
      const mapSelection = document.getElementById("mapSelection");
      let optionsHTML = ``;
      for (let index = 0; index < mapTypes.length; index++) {
        let map = mapTypes[index];
        if (map === "regCF") {
          optionsHTML += `<option value="${map}" selected>${window[`${map}_mapTitle`]}</option>`;
        } else {
          optionsHTML += `<option value="${map}" >${window[`${map}_mapTitle`]}</option>`;
        }
      }
      mapSelection.innerHTML = optionsHTML;
    }

    /* function createA11yDataTables() {
      let generatedHTML = "";
      for (let map of mapTypes) {
        const stateFilters = window[`${map}_filters`];
        const countyFilters = window[`${map}_county_filters`];
        for (let filter of stateFilters) {

          let data = window[`${map}_${filter.key}`];

          generatedHTML += generateA11yTable(data, `${window[`${map}_mapTitle`]} (${filter.text})`,`${map}_${filter.key}`);
        }
        if (countyFilters?.length) {
          for (let filter of countyFilters) {
            let data = window[`${map}_county_${filter.key}`];
            generatedHTML += generateA11yTable(data, `${window[`${map}_mapTitle`]} (County ${filter.text})`, `${map}_county_${filter.key}`, "county");
          }
        }
      }
      document.getElementById("a11y-data-tables").innerHTML = generatedHTML;

      clearA11yTables();

      document.getElementById("regCF_2020").style.display = "block";
    } */

    function generateA11yTable(mapData, title, tableName, type = "state") {
      let renderedHTML = `<table id="${tableName}">`;

      renderedHTML += `<caption>${title}</caption>`;

      renderedHTML += type === "state" ? `<tr><th>State</th><th>Offerings Count</th><th>USD Raised</th></tr>` : `<tr><th>State</th><th>County</th><th>Offerings Count</th><th>USD Raised</th></tr>`;
      if (type === "state") {
      let stateMap = Highcharts.geojson(Highcharts.maps["countries/us/custom/us-all-territories"]);
      for (let row of mapData) {
      let { code, offerings, usd } = row;
      const { name = code } = stateMap.find((state) => state.properties["hc-key"] === code) ?? {};
      if (name) {
      renderedHTML += `<tr><td>${name}</td><td>${offerings}</td><td>${formatNumber(usd)}</td></tr>`;
      }
      }
      } else {
      let countiesMap = Highcharts.geojson(Highcharts.maps["countries/us/us-all-all-highres"]);
      for (let row of mapData) {
      let { code, offerings, usd } = row;
      let st_name = code;
      if (st_name.startsWith("us-")) st_name = st_name.substr(3,2).toUpperCase();

      const { name = code } = countiesMap.find((county) => county.properties["hc-key"] === code) ?? {};
      if (name) {
        if (name) name2 = name;
        if (name === "us-pr-127") name2 = "San Juan";

      renderedHTML += `<tr><td>${st_name}</td><td>${name2}</td><td>${offerings}</td><td>${formatNumber(usd, true)}</td></tr>`;
      }
      }
      }
      renderedHTML += "</table>";
      return renderedHTML;
      }

    /* function clearA11yTables() {
      document.getElementById(`regCF_2019`).style.display = "none";
      document.getElementById(`regCF_2020`).style.display = "none";
      document.getElementById(`regCF_county_2019`).style.display = "none";
      document.getElementById(`regCF_county_2020`).style.display = "none";
      document.getElementById(`regA_2018_19`).style.display = "none";
      document.getElementById(`regA_2019_20`).style.display = "none";
      document.getElementById(`regD_2018_19`).style.display = "none";
      document.getElementById(`regD_2019_20`).style.display = "none";
      document.getElementById(`registered_2018_19`).style.display = "none";
      document.getElementById(`registered_2019_20`).style.display = "none";
    } */

    function generateCSV(mapData, title, type = "state") {
      let csv = `"",${title},""\r\n\r\n`;
      csv += type === "state" ? "State,Offerings Count,USD Raised\r\n" : "State Code,County,Offerings Count,USD Raised\r\n";
      if (type === "state") {
        let stateMap = Highcharts.geojson(Highcharts.maps["countries/us/custom/us-all-territories"]);
        for (let row of mapData) {
          let { code, offerings, usd } = row;
          const { name = code } = stateMap.find((state) => state.properties["hc-key"] === code) ?? {};
          if (name) {
            csv += `${name},${offerings},${formatNumber(usd)}\r\n`;
          }
        }
      } else {
        let countiesMap = Highcharts.geojson(Highcharts.maps["countries/us/us-all-all-highres"]);
        for (let row of mapData) {
          let { code, offerings, usd } = row;
          const st_name = code;
          const { name = code } = countiesMap.find((county) => county.properties["hc-key"] === code) ?? {};
          if (name) {
            csv += `${st_name},${name},${offerings},${formatNumber(usd, true)}\r\n`;
          }
        }
      }
      csv += "\r\n";
      return csv;
    }

    function hideFilter(filterId) {
      document.getElementById(filterId).style.display = "none";
    }

    function showFilter() {
      document.getElementById("stateFilter").style.display = "";
    }

    function createFilter(mapType) {
      const stateFilter = document.getElementById("selectedFilter");
      if (stateFilter) {
        stateFilter.removeEventListener("change", onFilterValueChange);
      }
      const stateFilterContainer = document.querySelector("#stateFilter .filterContainer");
      let filterHTML = ``;
      let filters = !countyMode ? window[`${mapType}_filters`] : window[`${mapType}_county_filters`];
      for (let filter of filters) {
        const { key, text } = filter;
        filterHTML += `<option value="${key}">${text}</option>`;
      }
      filterHTML = `<select required name="selectedFilter" id="selectedFilter" aria-controls="aria-controlled-content">${filterHTML}</select>`;
      stateFilterContainer.innerHTML = filterHTML;
      document.getElementById("selectedFilter").addEventListener("change", onFilterValueChange);
    }

    //function onFilterValueChange(e) {
      //let { value } = e.target;
     // if (value) {
      //  let mapData = !countyMode ? window[`${mapType}_${value}`] : window[`${mapType}_county_${value}`];
     //   loadMap(countyMode, mapData, false);
     // }
    //}

    function onFilterValueChange(e){
      let { value } = e.target;

      if (value) {
        let mapData = !countyMode ? window[`${mapType}_${value}`] : window[`${mapType}_county_${value}`];

        // clearA11yTables();

        if (!countyMode) {
          mapData = window[`${mapType}_${value}`];



          // document.getElementById(`${mapType}_${value}`).style.display = "block";
        } else {
          window[`${mapType}_county_${value}`];
          // document.getElementById(`${mapType}_county_${value}`).style.display = "block";
        }
        loadMap(countyMode, mapData, false);
      }
    }

    function filterByValue(e) {
      const { value } = e.target;
      showMetroMap = value === "metro";
      switch (value) {
        case "counties":
        case "metro":
          if (mapType == "regCF") {
            loadMap(true);
          }
          break;
        case "states":
          loadMap();
          break;
        default:
          console.log(value);
      }
    }

    //map dropdown
    document.getElementById("mapSelection").addEventListener("change", (e) => {
      loadMap();
    });

    document.getElementById("stateFilter").addEventListener("submit", (event) => {
      event.preventDefault();
      let { selectedFilter } = event.target;
      if (selectedFilter?.value) {
        // clearA11yTables();
        document.getElementById(`${mapType}_${selectedFilter.value}`).style.display = "block";
        loadMap(false, window[`${mapType}_${selectedFilter.value}`], false);
      }
    });

    document.getElementById("stateFilter").addEventListener("reset", (event) => {
      loadMap(false);
    });

    function loadMap(county, mapData, initializeFilter = true) {
      hideFilter("stateFilter");

      mapType = document.getElementById("mapSelection").value;

      if (county) {
        countyMode = true;
        document.querySelector(".countiesHolder").style.display = "flex";
      } else {
        const locationFilter = document.getElementById("locationSelection");
        locationFilter.value = "states";
        countyMode = showMetroMap = false;
        document.querySelector(".countiesHolder").style.display = "none";
      }

      if (initializeFilter) {
        createFilter(mapType);
      }

      showFilter();
      if (!mapData) {
        // load the data as per the selected filter
        const selectedFilter = document.querySelector("#stateFilter #selectedFilter");

        // get the name of the data obj (also name of a11y data table in html)
        let dataNameStr = !countyMode
          ? `${mapType}_${selectedFilter?.value}`
          : `${mapType}_county_${selectedFilter?.value}`;

        mapData = window[dataNameStr];
        // clearA11yTables();
        // document.getElementById(dataNameStr).style.display = "block";
      }
      let colors = window[`${mapType}_colorPalette`];

      let countiesElement = document.querySelector("section[type=where] option[value='counties']");
      countiesElement.style.display = "none";

      createLegend(mapType, colors);
      setMethodology(mapType, countyMode);
      const mapTitle = window[`${mapType}_mapTitle`];
      switch (mapType) {
        case "regCF":
          initializeMap(mapData, mapTitle, colors, county);
          countiesElement.style.display = "";
          break;
        case "regA":
          initializeMap(mapData, mapTitle, colors, county);
          break;
        case "regD":
          initializeMap(mapData, mapTitle, colors, county);
          break;
        case "registered":
          initializeMap(mapData, mapTitle, colors, county);
          break;
      }
    }

    function setMethodology(mapType) {
      const methodologyText = !countyMode ? window[`${mapType}_methodology`] : window[`${mapType}_county_methodology`];
      document.getElementById("methodology-description").innerText = methodologyText;
    }

    function createLegend(mapType, colors) {
      let container = document.querySelector(".colorQuantity-container");
      let innerHTML = `<div class="colorQuantity-item">
            <span class="color" style="background-color: #f7f7f7"></span>
            <span class="price">None</span>
          </div>`;
      let legend = !countyMode ? window[`${mapType}_legend`] : window[`${mapType}_county_legend`];

      for (let index = 0; index < legend.length; index++) {
        innerHTML += `<div class="colorQuantity-item">
            <span class="color" style="background-color: ${colors[index]}"></span>
            <span class="price">${legend[index]}</span>
          </div>`;
      }
      container.innerHTML = innerHTML;
    }



    const formatNumber = (num, convertToMillions = false) => {
      num = Number(num);
      const oneB = 1000000000;
      const oneM = 1000000;
      const oneK = 1000;
      if (num > 0) {
        // convert to thousand
        if (convertToMillions) {
          num = num / oneM;
        }
        num = num * oneK;
        if (num >= oneM) {
          return Highcharts.numberFormat(num / oneM, 2) + "B";
        } else if (num >= oneK) {
          return Highcharts.numberFormat(num / oneK, 2) + "M";
        } else {
          return Highcharts.numberFormat(num, 2) + "K";
        }
      } else {
        return num;
      }
    };

    // Instantiate the map
    async function initializeMap(mapType, mapName, colorPalette, county = false) {
      let config = {
        chart: {
          map: "countries/us/custom/us-all-territories",
          height: 575,
        },
        accessibility: {
          point: {
            descriptionFormatter: function (e) {
              return e.name + ": " + e.offerings;
            },
          },
        },
        title: { text: mapName },
        credits: { enabled: false },
        exporting: {
          csv: { itemDelimiter: ";" },
          sourceWidth: 600,
          sourceHeight: 500,
          filename: "Exported CSV",
          enabled: false,
        },

        legend: {
          layout: "horizontal",
          borderWidth: 0,
          backgroundColor: "rgba(255,255,255,0.85)",
          floating: true,
          verticalAlign: "bottom",
          enabled: false,
          y: 25,
        },
        mapNavigation: { enabled: true },
        colorAxis: {
          dataClasses: [
            { from: 0, to: 0, color: "#f7f7f7" },
            { from: 1, to: 1, color: colorPalette[0] },
            { from: 2, to: 2, color: colorPalette[1] },
            { from: 3, to: 3, color: colorPalette[2] },
            { from: 4, to: 6, color: colorPalette[3] },
          ],
        },
        series: [
          {
            states: {
              hover: {
                color: "#757575",
              },
            },
            cursor: "pointer",
            data: mapType,
            colorKey: "color_code",
            joinBy: ["hc-key", "code"],
            dataLabels: {
              enabled: true,
              formatter: function (options) {
                const point = this.point;
                if (this.point.code) {
                  const properties = this.series.mapMap[point.code].properties;

                  if (!(properties["hc-key"] !== "vi-6398" && properties["hc-key"] !== "vi-6399")) return null;

                  if (properties.type === "State") return `${properties["postal-code"]}<br>${point.offerings}`;

                  if (properties.type === "Federal District") return `${properties["hasc"].split(".")[1]}<br>${point.offerings}`;

                  return `${properties["hasc"].split(".")[0]}<br>${point.offerings}`;




                  //return properties["hc-key"] !== "vi-6398" && properties["hc-key"] !== "vi-6399"
                   // ? `${properties.type === "State" ? properties["postal-code"] : properties["hasc"].split(".")[0]}<br>${
                     //   point.offerings
                     // }`
                   // : null;
                }
              },
            },
            name: "Information",
            tooltip: {
              pointFormatter: function () {
                const point = this;
                return `<strong>${this.properties.name}</strong>  <br/> <strong>Offerings Count:</strong> ${
                  point.offerings
                } <br/> <strong>USD Raised:</strong> $${formatNumber(point.usd)}`;
              },
            },
          },
        ],
      };

      // for county related
      if (county) {
        var countiesMap = Highcharts.geojson(Highcharts.maps["countries/us/us-all-all-highres"]),
          // Extract the line paths from the GeoJSON
          lines = Highcharts.geojson(Highcharts.maps["countries/us/us-all-all-highres"], "mapline"),
          // Filter out the state borders and separator lines, we want these
          // in separate series
          borderLines = lines.filter((l) => l.properties["hc-group"] === "__border_lines__"),
          separatorLines = lines.filter((l) => l.properties["hc-group"] === "__separator_lines__");

        // Add state acronym for tooltip
        countiesMap.forEach(function (mapPoint) {
          mapPoint.name = mapPoint.name + ", " + mapPoint.properties["hc-key"].substr(3, 2);
        });

        config.plotOptions = {
          mapline: {
            showInLegend: false,
            enableMouseTracking: false,
          },
        };
        config.chart = { height: 575, marginRight: 20 }; // for the legend
        config.legend = {
          layout: "vertical",
          align: "right",
          floating: true,
          backgroundColor:
            // theme
            (Highcharts.defaultOptions &&
              Highcharts.defaultOptions.legend &&
              Highcharts.defaultOptions.legend.backgroundColor) ||
            "rgba(255, 255, 255, 0.85)",
        };
        config.series = [
          {
            mapData: countiesMap,
            data: mapType,
            joinBy: ["hc-key", "code"],
            name: "County",
            borderWidth: 0.5,

            states: {
              hover: {
                color: "#a4edba",
              },
            },
            shadow: false,
            colorKey: "color_code",
            tooltip: {
              pointFormatter: function () {
                const point = this;
                const [county, state] = this.series.mapMap[point.code].name.split(",");
                return `<strong>${county},${state.toUpperCase()}</strong> <br/> <strong>Offerings Count:</strong> ${
                  point.offerings
                } <br/> <strong>USD Raised:</strong> $${formatNumber(point.usd, true)}`;
              },
            },
          },
          {
            type: "mapline",
            name: "State borders",
            data: borderLines,
            color: "darkgray",
            shadow: false,
          },
        ];
        Highcharts.getJSON(mapPath + "pr-municipalities.json", function (geojson) {
          // Initiate the chart
          let prConfig = { ...config, title: "Puerto Rico" };

          let mapData = mapType.find((item) => item?.code?.includes("us-pr-"));
          let clonedMapData = mapData ? { ...mapData } : null;
          if (clonedMapData) {
            clonedMapData.code = clonedMapData.code.replace("us-pr-", "");
          }
          prConfig.chart = {
            map: geojson,
            height: 135,
            width: 135,
          };
          prConfig.mapNavigation = { enabled: true };
          prConfig.series = [
            {
              data: [clonedMapData],
              joinBy: ["COUNTY", "code"],
              name: "County",
              colorKey: "color_code",
              states: {
                hover: {
                  color: "#a4edba",
                },
              },
              dataLabels: {
                enabled: true,
              },
              mapNavigation: { enabled: true },
              tooltip: {
                pointFormatter: function () {
                  const point = this;
                  const [county, state] = [point.name, "PR"];
                  return `<strong>${county}, ${state.toUpperCase()}</strong> <br/> <strong>Offerings Count:</strong> ${
                    point.offerings
                  } <br/> <strong>USD Raised:</strong> $${formatNumber(point.usd, true)}`;
                },
              },
            },
          ];
          // prConfig.chart.map = geojson;
          Highcharts.mapChart("countyContainer", prConfig);
        });
        Highcharts.getJSON(mapPath + "guam.json", function (geojson) {
          // Initiate the chart
          let guamConfig = { ...config, title: "Guam" };

          let mapData = mapType.find((item) => item?.code?.includes("us-pr-"));
          let clonedMapData = mapData ? { ...mapData } : null;
          if (clonedMapData) {
            clonedMapData.code = clonedMapData.code.replace("us-pr-", "");
          }
          guamConfig.chart = {
            map: geojson,
            height: 50,
            width: 50,
          };
          guamConfig.series = [
            {
              name: "Guam",
              states: {
                hover: {
                  color: "#a4edba",
                },
              },
              dataLabels: {
                enabled: true,
              },
            },
          ];
          // guamConfig.chart.map = geojson;
          Highcharts.mapChart("guam-countyContainer", guamConfig);
        });
        Highcharts.getJSON(mapPath + "virgin-islands.json", function (geojson) {
          // Initiate the chart
          let viConfig = { ...config, title: "Virgin Islands" };

          let mapData = mapType.find((item) => item?.code?.includes("us-pr-"));
          let clonedMapData = mapData ? { ...mapData } : null;
          if (clonedMapData) {
            clonedMapData.code = clonedMapData.code.replace("us-pr-", "");
          }
          viConfig.chart = {
            map: geojson,
            height: 50,
            width: 50,
          };
          viConfig.series = [
            {
              name: "VI",
              states: {
                hover: {
                  color: "#a4edba",
                },
              },
              dataLabels: {
                enabled: true,
              },
            },
          ];
          // viConfig.chart.map = geojson;
          Highcharts.mapChart("vi-countyContainer", viConfig);
        });
      }
      config.legend = {
        enabled: false,
      };

      setTimeout(() => {
        Highcharts.mapChart("container", config);
      }, 0);
    }
}
);
