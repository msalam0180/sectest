/**
 * @file
 * Contains Javascript for RMD Calculator.
 */

(function ($, Drupal, drupalSettings) {

  Drupal.behaviors.rmdCalculatorResetBehavior = {
    attach: function (context, settings) {
      if ($('.messages--error').length > 0) {
        $('#rmd-calc', context).once('calculator_error').each(function () {
          $([document.documentElement, document.body]).animate({
            scrollTop: $('body').offset().top
          }, 1200);
        })
      }

      $('#rmd-calc', context).once('calculator_reset').each(function () {
        // Reset Click.
        $('.button--reset').click(function (event) {
          event.preventDefault();
          resetCalculator();
          resetValidation();
          $('#rmd-calculator-form').find('input:first').focus();
        });

        // Reset Function.
        var resetCalculator = function () {
          //get all calculator fomr inputs
          var input_select = $('.calculator__form-input :input');
          $(input_select).each(function () {
            $(this).val(''); //clear values
          });

          $('select').prop('selectedIndex', 0);
          $('#results_container').addClass('element-invisible');
          $('#results_container').html("");
          //Drupal.settings.investor_calculators = {};
        }

        // Reset Validation for inline errors.
        var resetValidation = function () {
          //remove alert message
          $('.messages.messages--error').remove();

          //remove inline error sytling
          $('div.calculator').find('input, select').removeClass('error');

          //remove inline message errors
          var errmsg = $(".form-item--error-message");
          for (var i = 0; i < errmsg.length; i++) {
            errmsg[i].style.display = "none";
          }
        }
      });
    }

  };

})(jQuery, Drupal, drupalSettings);
