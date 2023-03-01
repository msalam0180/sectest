(function ($, Drupal, drupalSettings) {
  'use strict';
  Drupal.behaviors.visualization = {
    attach: function () {
      var articleType = $('#edit-field-article-type-secarticle option:selected').text();
      var editForm = $('#node-secarticle-form').length === 1;
      if (!drupalSettings.embed || !editForm) {
        return false;
      }
      if (articleType !== 'Data Highlight') {
        var $div = $('<div>', {id: 'dialog'}).text(drupalSettings.embed.alert.message);
        if ($('#dialog')) {
          $('#dialog').dialog('destroy').remove();
        }
        $($div).one().dialog(
          {
            title: drupalSettings.embed.alert.title,
            dialogClass: drupalSettings.embed.alert.classes
          }
        );
      }
    }
  };
})(jQuery, Drupal, drupalSettings);
