/**
 * @file
 * Contains the definition of the behaviour secConditionalFields.
 */
(function ($) {
  'use strict';
  /**
   * Attaches the JS secConditionalFields behavior to to weight div.
   */
  Drupal.behaviors.secConditionalFields = {
    attach: function (context) {
      var root = $('form');
      var formItems = $('form .layout-region-node-main .form-item');
      var subType = $('select#edit-field-article-sub-type-secart');
      var reqLabelClasses = 'js-form-required form-required';
      var articleType = $('select#edit-field-article-type-secarticle');
      var reqInputAttr = {
        'required': 'required',
        'aria-required': true
      };

      var dataMediaDescriptionAddition = '<div class="description data-description">If applicable please attach data dictionary with this Article.</div>';

      if ( articleType.val() === '621' && $('#edit-field-media-file-upload-wrapper .fieldset-legend').text() === 'File Upload' ) {
        $('#edit-field-media-file-upload-wrapper .fieldset-legend').text('Data Dictionary');
        $('#edit-field-media-file-upload-wrapper legend').after(dataMediaDescriptionAddition);
      }
      else {
        $('#edit-field-media-file-upload-wrapper .fieldset-legend').text('File Upload');
        $('#edit-field-media-file-upload-wrapper .data-description').remove();
      }

      if ( subType && subType.val() !== '_none') {
        var subTypeValue = subType.val();
      }
      
      // Trigger
      $(context).find(formItems).once().each(function () {
        var rootId = root.once().attr('id');

        switch (rootId) {
        case 'node-secarticle-form':
        case 'node-secarticle-edit-form':
          if (rootId === 'node-secarticle-edit-form') {
            triggerChange('select#edit-field-article-type-secarticle', subTypeValue);
          }
          formItems.find('select#edit-field-article-type-secarticle').on('change', function () {
            var dataIdReq = [
              '#edit-field-description-abstract-wrapper',
              '#field-tags-add-more-wrapper',
              '#edit-field-date-wrapper',
              '#edit-field-contact-name-wrapper',
              '#edit-field-contact-email-wrapper',
              '#edit-field-access-level-wrapper'
            ];
            switch (this.value) {
            case '621':
              if ( $('#edit-field-media-file-upload-wrapper .fieldset-legend').text() === 'File Upload' )  {
                $('#edit-field-media-file-upload-wrapper .fieldset-legend').text('Data Dictionary');
                $('#edit-field-media-file-upload-wrapper legend').after(dataMediaDescriptionAddition);

                $(document).ajaxSuccess(function () {
                  if (this.value === '621' ) {
                    $('#edit-field-media-file-upload-wrapper .fieldset-legend').text('Data Dictionary');
                    $('#edit-field-media-file-upload-wrapper legend').after(dataMediaDescriptionAddition);
                  }
                });
              }

              require(
                dataIdReq,
                []
              );
              break;

            default:
              // defaults to File Upload if not;
              $('#edit-field-media-file-upload-wrapper .fieldset-legend').text('File Upload');
              $('#edit-field-media-file-upload-wrapper .data-description').remove();
              require(
                [],
                dataIdReq
              );
              break;
            }
          });
          break;
        case 'node-news-form':
        case 'node-news-edit-form':
          if (rootId === 'node-news-edit-form') {
            triggerChange('select#edit-field-article-type-secarticle');
            triggerChange('select#edit-field-news-type-news');
          }
          formItems.find('select#edit-field-news-type-news').on('change', function () {
            var pressReleaseIdReq = [
              '#edit-field-display-title-wrapper',
              '#edit-field-release-number-wrapper',
              '#edit-field-location-news-wrapper',
              '#edit-field-primary-division-office-wrapper'
            ];

            var pressReleaseIdnotReq = [
              '#edit-field-description-abstract-wrapper',
              '#edit-field-person-wrapper'
            ];

            var speechIdReq = [
              '#edit-field-display-title-wrapper',
              '#edit-field-description-abstract-wrapper',
              '#edit-field-person-wrapper'
            ];

            var speechIdnotReq = [
              '#edit-field-display-title-wrapper',
              '#edit-field-release-number-wrapper',
              '#edit-field-location-news-wrapper',
              '#edit-field-primary-division-office-wrapper'
            ];

            var publicStatementIdReq = [
              '#edit-field-display-title-wrapper',
              '#edit-field-description-abstract-wrapper',
              '#edit-field-location-news-wrapper',
            ];

            var publicStatementIdnotReq = [
              '#edit-field-release-number-wrapper',
              '#edit-field-primary-division-office-wrapper',
              '#edit-field-person-wrapper'
            ];

            var testimonyIdReq = [
              '#edit-field-display-title-wrapper',
              '#edit-field-person-wrapper',
              '#edit-field-description-abstract-wrapper'
            ];

            var testimonyIdnotReq = [
              '#edit-field-release-number-wrapper',
              '#edit-field-location-news-wrapper'
            ];

            switch (this.value) {
            case '21':
              require(
                pressReleaseIdReq,
                pressReleaseIdnotReq
              );
              break;
            case '26':
              require(
                speechIdReq,
                speechIdnotReq
              );
              break;
            case '286':
              require(
                publicStatementIdReq,
                publicStatementIdnotReq
              );
              break;
            case '291':
              require(
                testimonyIdReq,
                testimonyIdnotReq
              );
              break;
            default:
              break;
            }
          });
          break;
        default:
          return true;
        }
      });
      /**
          * [triggerChange description]
          * @param  {[type]} element [description]
          * @return {[type]}         [description]
          */
      function triggerChange(element, subTypeValue) { // eslint-disable-line no-shadow
        $(document).ready(function () {
          $(element).trigger('change');
          if ( subTypeValue ) {
            subType[0].value = subTypeValue;
          }
        });
      }


      /**
           * [require Helper function to require and not require fields]
           * @param  {[type]} reQids    [description]
           * @param  {[type]} notreQids [description]
           * @return {[type]}           [description]
           */

      function require(reQids, notreQids) {
        var formBlock = $('form .layout-region-node-main');
        var element;
        // Remove not Required id's;
        if (notreQids) {
          for (var i = 0; i <= notreQids.length; i++) {
            if ( $(notreQids[i]).find('.error').length > 0 ) {
              $(notreQids[i]).find('.error').removeClass('error');
            }
            element = formBlock.find(notreQids[i]);
            // Remove Required icon;
            element.find('label,.label,fieldset>legend>span.fieldset-legend').removeClass(reqLabelClasses);
            if ( element.length > 0 ) {
              if ( element.find('input,textarea').attr(reqInputAttr) ) {
                element.find('select,input,textarea').removeAttr('required aria-required');
                  element.find('select#edit-field-person option[value="_none"]').remove();
                  element.find('select#edit-field-person').prepend($("<option></option>").attr("value", '_none').text("- None - "));
              }
            }
          }
        }

        if (reQids) {
          // Dynamically add classes & attr;
          for (var j = 0; j <= reQids.length; j++) {
            element = formBlock.find(reQids[j]);
            element.find('label,.label,fieldset>legend>span.fieldset-legend').addClass(reqLabelClasses);
            element.find('select,input,textarea').first().attr(reqInputAttr);
            element.find('select#edit-field-person option[value="_none"]').remove();
          }
        }
      }
    }
  };
})(jQuery);
