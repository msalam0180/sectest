(function ($, Drupal) {
  'use strict';
  Drupal.behaviors.webcast = {
    attach: function (context) {
      $('a#config-toggle', context).click(
        function (e) {
          e.preventDefault();
          $('#config-object').toggle();
        }
      );
    }
  };
})(jQuery, Drupal);
