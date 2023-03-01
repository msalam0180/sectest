(function ($, Drupal) {
  Drupal.behaviors.secEdgarCompanyProfile = {
    attach: function (context, settings) {
      $('#sec-edgar-company-person-form .expand-options').once('expandEdgarForm').on('click', function () {
        $(this).addClass('hidden');
        $('#sec-edgar-company-person-form .collapsed-submit').addClass('hidden');
        $('#sec-edgar-company-person-form .expanded-options').slideDown('slow');
      });

      $('#sec-edgar-company-person-form .collapse-options').once('collapseEdgarForm').on('click', function () {
        $('#sec-edgar-company-person-form .collapsed-submit').removeClass('hidden');
        $('#sec-edgar-company-person-form .expanded-options').slideUp('slow', function () {
          $('#sec-edgar-company-person-form .expand-options').removeClass('hidden');
        });
      });
      $(".tooltip").tooltip({
        position: "top right",
        offset: [-12, -12],
        relative: true
      });
    }
  };
})(jQuery, Drupal);
