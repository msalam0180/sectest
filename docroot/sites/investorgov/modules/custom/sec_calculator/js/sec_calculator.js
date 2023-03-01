/**
 * @file
 * Contains Javascript for SEC Calculators.
 */

(function ($, Drupal, drupalSettings) {

Drupal.behaviors.SecCalculatorMonetaryInputBehavior = {
  attach: function (context, settings) {

    //allow only numbers
    $('.num-input').keydown(function (e) {
      // Allow: backspace, delete, tab, escape, enter and .
      if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
          // Allow: Ctrl+A, Command+A
          (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) ||
          // Allow: home, end, left, right, down, up
          (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
              return;
            }
      // Ensure that it is a number and stop the keypress
      if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
      }
    });

    //allow only numbers
    $('.neg-input').keydown(function (e) {
      // Allow: backspace, delete, tab, escape, enter, minus/dash and .
      if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190, 109, 189]) !== -1 ||
          // Allow: Ctrl+A, Command+A
          (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) ||
          // Allow: home, end, left, right, down, up
          (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
              return;
            }
      // Ensure that it is a number and stop the keypress
      if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
      }
    });

    $('.monetary-input').focus(function (event) {
      var oldInputValue = $(this).val(),
        newInputValue;
      if ($(this).val() != '') {
        newInputValue = oldInputValue.replace(/,/g,'').replace('$','');
        $(this).val(newInputValue);
      }
    });

    $('.monetary-input').blur(function (event) {
      if ($(this).val() != '' && !isNaN($(this).val())) {
        $(this).val('$' + $(this).val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
      }
    });

    // OSSS-17219 -> Subtask OSSS-17570 Restrict Length of Time in Years from entering more than two decimal places.
    $('.fractional-num-year').on('input', function(e) {
      var num = $(e.target).val();
      if (num.indexOf(".") >= 0) {
        var rNum = num.substr(0, num.indexOf(".", 1));
        rNum = rNum === "" ? 0 : rNum;
        var lNum = num.substr($(e.target).val().indexOf(".", 1), 3);
        this.value = rNum + lNum;
      }
    });

    }
  };

})(jQuery, Drupal, drupalSettings);
