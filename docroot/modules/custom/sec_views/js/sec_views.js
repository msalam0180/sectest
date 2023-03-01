(function ($, Drupal) {
  Drupal.behaviors.secViewsBehavior = {
    attach: function (context, settings) {
      var yearFilter = $(context).find('select#edit-year');
      if (yearFilter.length === 0 ) {
        $('#edit-items-per-page').find('option[value="All"]').prop('hidden', true);
      }
    }
  };
})(jQuery, Drupal);
