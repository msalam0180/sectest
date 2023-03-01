(function ($, Drupal) {
  'use strict';
  Drupal.behaviors.secCustomLibraries = {
    attach: function (context, settings) {
      var Chart = window.Chart || {};
      if (!Modernizr.canvas) {
        $.getScript(settings.sec_custom_libraries.path + '/components/scripts/excanvas.js');
      }
      var preloaderPlugin = {
        beforeInit: function (chart) {
          if (!chart.config.options.title.fontColor) { chart.config.options.title.fontColor = '#666'; }
          if (chart.config.options.hasOwnProperty('scales')) {
            _.map(chart.config.options.scales.yAxes, function (config) {
              if (config.hasOwnProperty('scaleLabel')) {
                if (!config.scaleLabel.fontColor) {
                  config.scaleLabel.fontColor = '#666';
                }
              }
            });
          }
          if (chart.config.options.scales && chart.config.options.scales.xAxes) {
            if (chart.config.options.scales.xAxes[0].stacked) {
              $.each(chart.config.data.datasets, function (key, value) {
                if (!value.hasOwnProperty('backgroundColor')) {
                  if (chart.config.data.datasets.length >= 3) {
                    chart.config.data.datasets[0].backgroundColor = '#273a56'; // 2nd stack
                    chart.config.data.datasets[1].backgroundColor = '#9acccd'; // 1st stack
                    chart.config.data.datasets[2].backgroundColor = '#ff9a66'; // 3rd stack
                  }
                  else if (chart.config.data.datasets.length === 2) {
                    chart.config.data.datasets[0].backgroundColor = '#25508E'; // 2nd stack
                    chart.config.data.datasets[1].backgroundColor = '#FFC057'; // 1st stack
                  }
                }
              });
            }
            if (chart.config.type === 'bar' && !chart.config.options.scales.stacked) {
              $.each(chart.config.data.datasets, function (key, value) {
                if (!value.hasOwnProperty('backgroundColor')) {
                  value.backgroundColor = '#273a56';
                }
                if (value.type === 'line' && !value.hasOwnProperty('borderColor')) {
                  value.borderColor = '#FFC057';
                  value.backgroundColor = '#fff';
                }
              });
            }
          }
        },
        afterInit: function () {
        // show only charts which have data loaded
          if ($('.field_script .chartjs-hidden-iframe').length > 0) {
            $('.field_script .chartjs-hidden-iframe').closest('.field_script').removeClass('fa fa-spinner fa-pulse fa-3x');
            $(this).show();
          }
        }
      };
      if (_.isEmpty(Chart)) { return false; }
      Chart.pluginService.register(preloaderPlugin);
      Chart.defaults.global.pan = {
        enabled: true,
        mode: 'x'
      };
      Chart.defaults.global.zoom = {
        enabled: true,
        mode: 'x'
      };
    }
  };
})(jQuery, Drupal);
