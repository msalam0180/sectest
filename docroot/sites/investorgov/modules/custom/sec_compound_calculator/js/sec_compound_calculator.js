/**
 * @file
 * Contains Javascript for Compound Interest Calculator.
 */

(function ($, Drupal, drupalSettings) {

  Drupal.behaviors.compoundCalculatorResetBehavior = {
    attach: function (context, settings) {
      $('#compound-interest-calc', context).once('calculator_reset').each(function () {
        // Reset Click.
        $('.button--reset').click(function (event) {
          event.preventDefault();
          resetCalculator();
          resetValidation();

          // Scroll to top.
          $([document.documentElement, document.body]).animate({
            scrollTop: $('#content').offset().top
          }, 600);
          $('#compound-calculator-form').find('input:first').focus();
        });

        // Reset Function.
        var resetCalculator = function () {
          //get all calculator form inputs
          var input_select = $('.calculator__form-input :input');
          $(input_select).each(function () {
            $(this).val(''); //clear values
          });
          $('select').prop('selectedIndex', 0);
          $('#results_container').addClass('element-invisible');
          $('#results_container').html("");
          $('#compound-calc__errors').html("");
          drupalSettings.sec_compound_calculator = {};
        }

        // Reset Validation for inline errors.
        var resetValidation = function () {
          //remove alert message
          $('.messages.messages--error').remove();

          //remove inline error sytling
          $('div.calculator').find('input').removeClass('error');

          //remove inline message errors
          var errmsg = $(".form-item--error-message");
          for (var i = 0; i < errmsg.length; i++) {
            errmsg[i].style.display = "none";
          }
        }
      });
    }
  };

  Drupal.behaviors.compound_calculator = {
    attach: function (context, settings) {
      $('#compound-interest-calc', context).once('sec_compound_calculator').each(function () {

        $(document).ajaxComplete(function (event, xhr, settings) {
          if ($(event.target.activeElement).attr("id") !== "edit-submit") {
            return;
          }

          if (!$.isEmptyObject(drupalSettings.sec_compound_calculator)) {
            var messageBox = $('.page__title').next('div');
            $('#compound-interest-calc, #savings-goal-calc').focus();
            $('#calculator_results_chart').empty();
            $('.highcharts-data-table').remove();
            var mySeries = [];
            var calcType = drupalSettings.sec_compound_calculator.calcType;
            var calcYears = drupalSettings.sec_compound_calculator.calcYears;

            switch (calcType) {
              case 'basic':
                var interestRateBase = drupalSettings.sec_compound_calculator.interestRateBase;
                var interestRatePlus = drupalSettings.sec_compound_calculator.interestRatePlus;
                var interestRateMinus = drupalSettings.sec_compound_calculator.interestRateMinus;
                var calcResults = {
                  name: 'Future Value (' + (interestRateBase * 100).toFixed(2) + '%)',
                  data: drupalSettings.sec_compound_calculator.calcResults,
                  color: 'rgba(191,40,13,1)',
                };
                if (drupalSettings.sec_compound_calculator.hasVar) {
                  var calcMinus = {
                    name: 'Variance Below (' + (interestRateMinus * 100).toFixed(2) + '%)',
                    data: drupalSettings.sec_compound_calculator.calcResultsMinus,
                    color: 'rgba(38,144,146,1)',
                  };
                  var calcPlus = {
                    name: 'Variance Above (' + (interestRatePlus * 100).toFixed(2) + '%)',
                    data: drupalSettings.sec_compound_calculator.calcResultsPlus,
                    color: 'rgba(0,50,91,1)',
                  };
                  mySeries = [calcPlus, calcResults, calcMinus];
                } else {
                  var calcDataBase = {
                    name: "Total Contributions",
                    data: drupalSettings.sec_compound_calculator.calcResultsBase,
                    color: 'rgba(38,144,146,1)',
                  };
                  mySeries = [calcResults, calcDataBase];
                }
                break;
              case 'monthly':
                var calcResults = {
                  name: "Total Savings Compounded",
                  data: drupalSettings.sec_compound_calculator.calcResults,
                  color: 'rgba(38,144,146,1)',
                };
                var calcBase = {
                  name: "Initial Investment Compounded",
                  data: drupalSettings.sec_compound_calculator.baseResults,
                  color: 'rgba(0,50,91,1)',
                };
                var calcMonthly = {
                  name: "Total Monthly Additions To-Date",
                  data: drupalSettings.sec_compound_calculator.monthlyResults,
                  color: 'rgba(191,40,13,1)',
                };

                mySeries = [calcBase, calcResults, calcMonthly];
                break;
            }
            Highcharts.setOptions({
              lang: {
                decimalPoint: '.',
                thousandsSep: ','
              }
            });

            var myChart = Highcharts.chart('calculator_results_chart', {
              chart: {
                type: 'line',
                description: "Interest rate accrued over " + (calcYears.length - 1) + " years."
              },
              tooltip: {
                shared: true,
                valuePrefix: '$',
                valueDecimals: 2,
                thousandsSep: ','
              },
              title: {
                text: 'Total Savings'
              },
              credits: {
                text: 'Investor.gov',
                href: 'https://www.investor.gov/'
              },
              xAxis: {
                categories: calcYears,
                title: {
                  text: 'Years',
                  style: {
                    visibility: 'hidden',
                  },
                },
              },
              yAxis: {
                title: {
                  text: 'US Dollars ($)',
                },
                tickInterval: 1000,
                labels: {
                  format: '${value:,.0f}'
                }
              },
              series: mySeries,
              exporting: {
                showTable: false,
                tableCaption: "Total Savings in US Dollars"
              }
            });
            drupalSettings.sec_compound_calculator = {};
          }

          var createResultTable = function (data) {
            if (data) {
              var columns = data.length;
              var rows = data[0].data.length;
              var newTable = '<div class="highcharts-data-table">';
              var highlighted = 'highlighted-value';
              newTable += '<table id="highcharts-data-table-0" summary="Table representation of chart.">';
              newTable += '<caption class="highcharts-table-caption">Total Savings in US Dollars</caption>';
              newTable += '<thead><tr>';
              newTable += '<th scope="col" class="text">Years</th>';

              for (y = 0; y < columns; y++) {
                var classNames = (data[y].name === 'Future Value' || data[y].name === 'Total Savings Compounded') ? ('text ' + highlighted) : ('text');
                newTable += '<th scope="col" class="' + classNames + '" >' + data[y].name + '</th>'
              }
              newTable += '</thead></tr>';
              newTable += '<tbody>';
              for (i = 0; i < rows; i++) {
                newTable += '<tr>';
                newTable += '<td scope="row" class="text">Year ' + i + '</td>';
                for (j = 0; j < columns; j++) {
                  var classNames = (data[j].name === 'Future Value' || data[j].name === 'Total Savings Compounded') ? ('number ' + highlighted) : ('number');
                  newTable += '<td class="' + classNames + '" >$' + data[j].data[i].toLocaleString('en-US', { style: 'decimal', minimumFractionDigits: 2, maximumFractionDigits: 2 }) + '</td>';
                }
                newTable += '</tr>'
              }
              newTable += '</tbody>';
              newTable += '</table>';
              newTable += '</div>';

              $('#calculator_results_table').append(newTable);
            }
          };

          createResultTable(mySeries);
          if (!$('#toggle_table').length) {
            $('<button id="toggle_table">Show Table</button>').insertBefore('#calculator_results_table');
          }

          // Scroll to results div.
          $([document.documentElement, document.body]).animate({
            scrollTop: $('#results_container').offset().top
          }, 1200);

          $('#toggle_table').on('click', function (event) {
            event.stopImmediatePropagation();
            event.preventDefault();
            if (!$('.highcharts-data-table').hasClass('show-table')) {
              $('.highcharts-data-table').addClass('show-table');
              $('#toggle_table').text('Hide Table');
            } else {
              $('.highcharts-data-table').removeClass('show-table');
              $('#toggle_table').text('Show Table');
            }
          });
        });
      });
    }
  };

})(jQuery, Drupal, drupalSettings);
