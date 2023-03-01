/**
* @file
* Defines Javascript behaviors for the confirmDialog.
*/
(function ($, Drupal) {
  'use strict';

  Drupal.behaviors.confirmDialog = {
    attach: function (context) {
      var $context = $(context);
      $context.find('.node-form input[type="submit"]').once('secWorkflow').on(
        'click', function () {
          var $submitbtn = $(this);

          // add a data attr based on the button that was clicked
          if (($submitbtn.closest('.publish').length > 0) || ($submitbtn.closest('.moderation-state-published').length > 0) ) {
            $('.node-form').attr('data-submit-button', 'publishingNode');
          }
          else {
            $('.node-form').attr('data-submit-button', 'notPublishingNode');
          }
        }
      );

      $('.node-form').once('secWorkflow').submit(
        function () {
          var $formDataAtr = $('.node-form').attr('data-submit-button');

          if ($formDataAtr === 'publishingNode') {
            // User clicked a publish button
            var c = confirm('Are you sure you want to publish this content?');

            if (c === true) {
              // User confired choice to publish
              return true;
            }

            // User backed out of publishing
            return false;
          }

          // User clicked a button other than a publish button
          return true;
        }
      );
    }
  };
})(jQuery, Drupal);
