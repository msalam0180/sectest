/* eslint-disable */
/**
 * @file
 * Contains js alteration to the adminimal theme.
 */

(function ($, Drupal, drupalSettings) {

  'use strict';

  //Adds a tabindex to iframe in modal popups created by entity browser so it is tab-able
  Drupal.behaviors.entityBrowserModalIframeAlter = {
    attach: function(context) {
      $(window).on({
        "dialog:aftercreate": function(event, dialog, $element, settings) {
          $(".entity-browser-modal-iframe").attr("tabindex", "0")
          console.log("BAM!")
        },
      })
    },
  }

  // Adds ToolTips next to the label for tall fields so a user can see it quickly OSSS-8845
  Drupal.behaviors.helptext = {
    attach: function(context) {
      // Textarea (WYSIWYG) widgets
      $(
        ".field--widget-text-textarea-with-summary .description, .field--widget-text-textarea .description"
      ).each(function(index) {
        // Find Field Wrppaing element
        var $field = $(this).closest(".form-wrapper")
        //Check if it already has a help text popup
        if (!$field.find(".helper-popup").length) {
          //Add help popup
          var $label = $field.find("label")
          $label.addClass("has-helper-popup")
          var $question = $label
            .first()
            .after(
              "<span class='helper-popup' data-tippy-content='" +
                $(this).text() +
                "' tabindex='0'>" +
                 $(this).text() +
                "</span>"
            )
        }
      })

      // Textarea widgets
      $(".form-type-textarea .description").each(function(index) {
        // Find Field Wrppaing element
        var $field = $(this).closest(".form-item")
        //Check if it already has a help text popup
        if (!$field.find(".helper-popup").length) {
          //Add help popup
          var $label = $field.find("label")
          $label.addClass("has-helper-popup")
          var $question = $label
            .first()
            .after(
              "<span class='helper-popup' data-tippy-content='" +
                $(this).text() +
                "' tabindex='0'>" +
                 $(this).text() +
                "</span>"
            )
        }
      })

      //drag and drop tables for multiple items
      $(".field-multiple-table")
        .next(".description")
        .each(function(index) {
          var $field = $(this).closest(".form-wrapper")
          if (!$field.find(".helper-popup").length) {
            var $label = $field.find(".field-label .label")
            $label.addClass("has-helper-popup")
            var $question = $label
              .first()
              .after(
                "<span class='helper-popup' data-tippy-content='" +
                  $(this).text() +
                  "' tabindex='0'>" +
                   $(this).text() +
                  "</span>"
              )
          }
        })
    },
  }

  //Adds tab focus handling for ajax inline-entity forms
  Drupal.behaviors.focusInlineEntityForms = {
    attach: function (context) {
      $(".field--widget-inline-entity-form-complex .button.js-form-submit").on("mousedown",function() {
        var fieldwrapper = $(this).closest(".field--widget-inline-entity-form-complex");
        $(document).ajaxComplete(function() {
          var firstInput = fieldwrapper.find("fieldset input.form-text, fieldset input.entity-browser-processed")[0];
          if (typeof firstInput == "undefined") {
            firstInput = fieldwrapper.find("input")[0];
          }
          firstInput.focus();
        });        
      });
    }
  }
  
  
})(jQuery, Drupal, drupalSettings);
