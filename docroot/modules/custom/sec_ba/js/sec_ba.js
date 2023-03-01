/**
 * @file
 * Contains the definition of the behaviour sec_ba.
 */
(function ($) {
  'use strict';
  /**
   * Attaches the JS sec_ba behavior
   */
  Drupal.behaviors.secBaForm = {
    attach: function (context) {
      $('form#filter').once('add-validation').each(
        function () {
          $('#edit-last-name, #edit-first-name').keyup(
            function () {
              if (isValidSearch()) {
                $('.alert-box.error').remove();
              }
            }
          );

          $('form#filter').on(
            'submit', function (e) {
              if (isValidSearch()) {
                $('.alert-box.error').remove();
              }
              else {
                throwError();
                e.preventDefault();
                return false;
              }
            }
          );

          function isValidSearch() {
            var firstNameVal = $('#edit-first-name').val();
            var lastNameVal = $('#edit-last-name').val();
            return (lastNameVal.length > 1 && (firstNameVal.length === 0 || firstNameVal.length > 1 ));
          }

          function throwError() {
            if ($('.alert-box.error').length == 0) {
              $('form#filter').before("<div role='contentinfo' aria-label='Error message' class='alert-box error'><div role='alert'><h2 class='visually-hidden'>Error message</h2><p>For Last Name, you must enter more than one letter. If you enter a First Name, you must include more than one letter.</p></div></div>");
            }
          }
        }
      );
    }
  };
})(jQuery, Drupal);
