var createResultTable = function(dataOne, dataTwo, dataThree, labels) {
  //build Year Headings
  var newTable;

  var firstRow = '<tr><th>Results</th>';
  for(var i = 0; i < dataOne.length; i++) {
    firstRow += '<th scope="col"> Year ' + i + '</th>';
  }
  firstRow += '</tr>';
  newTable = firstRow;

  //build first row
  var calcOne = '<tr><td scope="row">' + labels[0] + '</td>';
  for(var j = 0; j < dataOne.length; j++) {
    calcOne += '<td> $' + dataOne[j].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</td>';
  }
  calcOne += '</tr>';
  newTable += calcOne;

  //build second row and add after first
  if(dataTwo) {
    var calcTwo = '<tr><td scope="row">' + labels[1] + '</td>';
    for(var k = 0; k < dataTwo.length; k++) {
      calcTwo += '<td> $' + dataTwo[k].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</td>';
    }
    calcTwo += '</tr>';
    newTable += calcTwo;
  }

  //build third row
  if(dataThree) {
    var calcThree = '<tr><td scope="row">' + labels[2] + '</td>';
    for(var n = 0; n < dataThree.length; n++) {
      calcThree += '<td> $' + dataThree[n].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</td>';
    }
    calcThree += '</tr>';
    newTable += calcThree;
  }

  //add rows to table
  $('#calc_results_table').append(newTable);

};


///OLD CALC
var calcType = Drupal.settings.investor_calculators.calcType;
// var dataviz;
// //data is same from these
// var calcData = Drupal.settings.investor_calculators.calcResults;
// var calcYears = Drupal.settings.investor_calculators.calcYears;

if( calcType === 'basic' ) {
  var calcDataPlus = Drupal.settings.investor_calculators.calcResultsPlus;
  var calcDataMinus = Drupal.settings.investor_calculators.calcResultsMinus;
  var calcDataBase = Drupal.settings.investor_calculators.calcResultsBase;
  var interestRateBase = Drupal.settings.investor_calculators.interestRateBase;
  var interestRatePlus = Drupal.settings.investor_calculators.interestRatePlus;
  var interestRateMinus = Drupal.settings.investor_calculators.interestRateMinus;

  if(Drupal.settings.investor_calculators.hasVar) {
    var calcLabelPlus = "Variance Above Base Interest Rate (" + (interestRatePlus * 100) + "%)";
    var calcLabelMinus = "Variance Below Base Interest Rate (" + (interestRateMinus * 100) + "%)";
  } else {
    var calcLabelMinus = "Without Compound Interest Rate";
  }
  var calcLabelBase = "Base Interest Rate (" + (interestRateBase * 100) + "%)";
  
  var compoundLabels = [ calcLabelPlus, calcLabelBase, calcLabelMinus];
  if(Drupal.settings.investor_calculators.hasVar) {
    dataviz = {
      labels: calcYears,
      datasets: [
          {
              label: calcLabelPlus,
              fillColor: "rgba(0,50,91,0.2)",
              strokeColor: "rgba(0,50,91,1)",
              pointColor: "rgba(0,50,91,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(0,50,91,1)",
              data: calcDataPlus
          },
          {
              label: calcLabelBase,
              fillColor: "rgba(191,40,13,0.2)",
              strokeColor: "rgba(191,40,13,1)",
              pointColor: "rgba(191,40,13,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(191,40,13,1)",
              data:calcData
          },
          {
              label: calcLabelMinus,
              fillColor: "rgba(38,144,146,0.2)",
              strokeColor: "rgba(38,144,146,1)",
              pointColor: "rgba(38,144,146,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(38,144,146,1)",
              data: calcDataMinus
          }
      ]
    };
  } else {
    dataviz = {
      labels: calcYears,
      datasets: [
          {
              label: calcLabelBase,
              fillColor: "rgba(191,40,13,0.2)",
              strokeColor: "rgba(191,40,13,1)",
              pointColor: "rgba(191,40,13,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(191,40,13,1)",
              data:calcData
          },
          {
              label: calcLabelMinus,
              fillColor: "rgba(38,144,146,0.2)",
              strokeColor: "rgba(38,144,146,1)",
              pointColor: "rgba(38,144,146,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(38,144,146,1)",
              data: calcDataBase
          }
      ]
    };
  }
  
createResultTable(calcDataPlus, calcData, calcDataMinus, compoundLabels);
} else if(calcType === 'monthly') {
var calcMonthly = Drupal.settings.investor_calculators.monthlyResults;
var calcBase = Drupal.settings.investor_calculators.baseResults;

var totalCompounded = "Total Savings Compounded";
var totalAdditions = "Total Monthly Additions To-Date";
var initialInvestment = "Initial Investment Compounded";
var monthlyLabels = [ totalCompounded, totalAdditions, initialInvestment];

dataviz = {
labels: calcYears,
datasets: [
    {
        label: "Total Savings Compounded",
        fillColor: "rgba(0,50,91,0.2)",
        strokeColor: "rgba(0,50,91,1)",
        pointColor: "rgba(0,50,91,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(0,50,91,1)",
        data: calcData
    },
    {
        label: "Total Monthly Additions To-Date",
        fillColor: "rgba(191,40,13,0.2)",
        strokeColor: "rgba(191,40,13,1)",
        pointColor: "rgba(191,40,13,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(191,40,13,1)",
        data:calcMonthly
    },
    {
        label: "Initial Investment Compounded",
        fillColor: "rgba(38,144,146,0.2)",
        strokeColor: "rgba(38,144,146,1)",
        pointColor: "rgba(38,144,146,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(38,144,146,1)",
        data: calcBase
    }
]
};
createResultTable(calcBase, calcMonthly, calcData, monthlyLabels);
}
var ctx;
if( calcType === 'basic' ) {
ctx = $("#calculator_results_chart").get(0).getContext("2d");
} else if(calcType === 'monthly') {
ctx = $("#rv_calculator_results_chart").get(0).getContext("2d");
}
Chart.defaults.global.scaleLabel = function (label) {
return '$' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};
Chart.defaults.global.multiTooltipTemplate = function (label) {
return label.datasetLabel + ': $' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};
calcChart = new Chart(ctx).Line(dataviz, {
responsive: true,
maintainAspectRatio: true,
scaleIntegersOnly: true,
pointHitDetectionRadius: 4,
scaleFontColor: '#000'
});
if( calcType === 'basic') {
scrollToAnchor($('#results_container'));
} else if (calcType === 'monthly') {
scrollToAnchor($('#rv_results_container'));
}
Drupal.settings.investor_calculators = {};