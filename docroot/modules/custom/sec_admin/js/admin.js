(function ($, Drupal) {
  'use strict';

  // set ckeditor custom settings
  Drupal.behaviors.customCKEditorConfig = {
    attach: function (context, settings) {
      if (typeof CKEDITOR !== 'undefined') {
        CKEDITOR.config.fillEmptyBlocks = false;
        CKEDITOR.dtd.$removeEmpty['i'] = false;

        // Allow tags inside anchors - see https://ckeditor.com/old/forums/Support/CKEditor-wont-allow-inside
        CKEDITOR.dtd['a']['h2'] = true;
        CKEDITOR.dtd['a']['h3'] = true;
        CKEDITOR.dtd['a']['div'] = true;
      }
    }
  };

  // Add tab focus for multiple entry fields
  Drupal.behaviors.focusAutocompleteEntityReferences = {
    attach: function(context) {
      $(".field-add-more-submit").not('.field--type-entity-reference-revisions .field-add-more-submit').on("mousedown", function () {
        var fieldwrapper = $(this).closest("div.form-wrapper");
        $(document).ajaxComplete(function() {
          waitForEl(".ajax-new-content input", fieldwrapper, function(){
            var firstInput = fieldwrapper.find(".ajax-new-content :input")[0];
              //focus on the first element
              if (typeof firstInput !== "undefined") {
                firstInput.focus();
                $(document).off('ajaxComplete');
                return;
              }
            });
        });
      });
    }
  }

  // Show and hide quick links on releases
  Drupal.behaviors.releaseShowHideQuickLinks = {
    attach: function(context) {
      var showHideQuickLinksField = $('.form-item-field-quick-links select');
      var customizeFieldWrapper = $('.field--name-field-customized-quick-links');

      showHideQuickLinksField.once().change(function() {
        showHideCustomQuickLinksField($( this ).val(), customizeFieldWrapper)
      });

      showHideQuickLinksField.trigger( "change" );
    }
  }

  function showHideCustomQuickLinksField(selectValue, customizeField) {
    if (selectValue == "customize") {
      customizeField.show();
    } else {
      customizeField.hide();
    }
  }

  // Add tab focus for paragraphs
  Drupal.behaviors.focusParagraphs = {
    attach: function(context) {
      $(".field--type-entity-reference-revisions .field-add-more-submit").on("mousedown", function () {
        var fieldwrapper = $(this).closest(".field--widget-entity-reference-paragraphs");
        $(document).ajaxComplete(function() {
            waitForEl(".ajax-new-content .paragraphs-dropbutton-wrapper input.js-form-submit", fieldwrapper, function(){
              var firstInput = fieldwrapper.find(".ajax-new-content .paragraphs-subform :input")[0];
              //focus on the first element
              if (typeof firstInput !== "undefined") {
                firstInput.focus();
                $(document).off('ajaxComplete');
                return;
              }
            });
        });
      });
    }
  }

  var waitForEl = function(selector, context, callback, maxTimes) {
    if(maxTimes === undefined) {
      maxTimes = 150;
    }
    if ($(selector, context).length) {
      callback();
    } else {
      if (maxTimes === false || maxTimes > 0) {
        maxTimes != false && maxTimes--;
        setTimeout(function() {
          waitForEl(selector, context, callback, maxTimes);
        }, 100);
      }
    }
  };

  // uncheck url alias if path is set (migration issue)
  if ($('form.node-form #edit-path-0-alias').length > 0) {
    if ($('form.node-form #edit-path-0-alias').val().length > 0) {
      $('form.node-form #edit-path-0-pathauto').attr('checked', false);
      $('form.node-form #edit-path-0-alias').attr('disabled', false);
    }
  }

  // SEC Person Admin Functions
  if ($('body.page-node-type-secperson, .node-secperson-form').length > 0) {
    if ($('.field--name-field-position-history-paragraph table.field-multiple-table').length > 0) {
      // add event listener to add more button field-add-more-submit
      Drupal.behaviors.positionHistory = {
        attach: function (context, settings) {
          handlePersonPositionHistory();
        }
      };
    }
  }

  // Handle Current Position disabling To date.
  function handlePersonPositionHistory() {
    var hasCurrentChecked = $('.field--name-field-current-position .form-checkbox:checked').length > 0;
    $('.field--name-field-position-history-paragraph table.field-multiple-table tbody tr').each(
      function () {
        var currentPosition = $(this).find('.field--name-field-current-position .form-checkbox');
        var toDate = $(this).find('.field--name-field-to .form-date');
        if (currentPosition.is(':checked')) {
          toDate.val('');
          toDate.prop('disabled', true);
          toDate.prop('placeholder', 'Present');
          hasCurrentChecked = true;
        }
        else {
          if (hasCurrentChecked) {
            currentPosition.prop('disabled', true);
          }
          toDate.prop('disabled', false);
          toDate.prop('placeholder', '');
        }
        currentPosition.change(
          function () {
            if ($(this).is(':checked')) {
              toDate.val('');
              toDate.prop('disabled', true);
              toDate.prop('placeholder', 'Present');
              $('.field--name-field-current-position .form-checkbox').prop('disabled', true);
              $(this).prop('disabled', false);
              hasCurrentChecked = true;
            }
            else {
              $('.field--name-field-current-position .form-checkbox').prop('disabled', false);
              toDate.prop('disabled', false);
              toDate.prop('placeholder', '');
              hasCurrentChecked = false;
            }
          }
        );
      }
    );
  }

  // Article Type -> Article Subtype Filtering
  if ($('.node-secarticle-form.node-form').length > 0 || $('.node-secarticle-edit-form.node-form').length > 0) {
    filterSubType('#edit-field-article-sub-type-secart', '#edit-field-article-type-secarticle', '#edit-field-article-sub-type-secart option');
  }

  // content search page
  if ($('#views-exposed-form-content-page-1').length > 0 || $('#views-exposed-form-content-page-2').length > 0) {
    Drupal.behaviors.contentSearchPage = {
      attach: function (context, settings) {
        filterSubType('.form-item-field-article-sub-type select', "select[name='article_type']", '.form-item-field-article-sub-type select option');
      }
    };
  }

  // Handles filtering subtype field based on article type field
  function filterSubType(selected, articleType, options) {
    // initialize list to hide when form loads
    var sel = $(selected).children(':selected');
    resetOptions(options);
    if (sel.length > 0) {
      selectOptions(articleType, options);
      sel.prop('selected', true);
    }
    // onchange article type
    $(articleType).change(
      function () {
        resetOptions(options);
        selectOptions(articleType, options);
      }
    );
  }


  function resetOptions(options) {
    // wrap all options except "none" to hide
    $(options).each(
      function (index) {
        if (index != 0 && $(this).parent('span').length == 0) {
          $(this).wrap('<span></span>');
        }
      }
    );
  }


  function selectOptions(articleType, options) {
    var selectedArticleType = $(articleType).children(':selected').text();
    var allOptions = $(options);
    // reset previous selected option
    allOptions.prop('selected', false);

    allOptions.each(function (index) {
      var keyValue = $(this).val().split('-');

      // show option if key matches article type
      if (keyValue[0] === selectedArticleType && $(this).parent('span').length == 1) {
        $(this).unwrap('span');
      }
    });
  }

  if ($('#views-form-individual-defendant-admin-page-1').length > 0) {
    Drupal.behaviors.contentIDDSearchPage = {
      attach: function (context, settings) {
        // Move export btn into the correct place for document order
        $('.export_csv').appendTo('.view-filters');
      }
    };
  }

  if ($('.views-field-thumbnail__target-id').length > 0) {
    // Add alt text for media view thumbnail icons for video and image
    $('img.image-style-thumbnail').filter(function() {
      return !this.alt;
    }).attr('alt', 'file document icon');

    $("img[src*='video.png']").each(function () {
      $(this).attr('alt', 'video media icon');
    });
  }

  // Change ckeditor Linkit title from 'Link' to 'Linkit'
  setTimeout(function(){
      if ($('.cke_button__drupallink').length > 0) {
        $('.cke_button__drupallink').each(function () {
          $(this).attr('title', 'LinkIt (Ctrl+K)');
        });
      }
    }, 3000);

})(jQuery, Drupal);
