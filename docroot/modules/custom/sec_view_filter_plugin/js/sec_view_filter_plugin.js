/**
 * @file
 * Contains the definition of the behaviour secViewsFilterPlugin.
 */
(function ($, Drupal) {
  'use strict';

  /**
   * Attaches the JS sec_view_filter_plugin.
   */

  Drupal.behaviors.secViewsFilterPlugin = {
    attach: function (context) {
      // Setup our variables for use;
      var root = $(context).find('form.views-exposed-form');
      var selectOptions = root.find('select#edit-year,select#edit-month,select#edit-news-type');
      var currMonth = (new Date()).getMonth() + 1;
      var currYear = (new Date()).getFullYear();
      var selMonth, selYear, monthOptions = $('select#edit-month > option'); // eslint-disable-line one-var
      // On Document ready check for selected option values;
      selYear = $('select#edit-year').val();
      selMonth = $('select#edit-month').val();
      if (Number(selYear) === currYear) {
        // Remove future months if selected year matches current year;
        monthOptions.each(
          function () {
            if (currMonth < Number(this.value)) {
              this.hidden = true;
            }
          }
        );
      }
      else if (selYear === 'All') {
        $('select#edit-month').prop('disabled', true);
        $('#edit-items-per-page').find('option[value="All"]').prop('hidden', true);
      }
      // On change event handler;
      selectOptions.on(
        'change', function (e) {
          $("input[name='aId']", this.form).val($(this).attr('id'));
          $(this).closest('form').submit();
          // if(this.value === "All") window.location.href = window.location.href.split('?')[0];
        }
      );
    }
  };

  /** *
     * Attach an ajax autocompleter for speaker typeahead
     * which calls a REST view via ajax and returns results
     */
  Drupal.behaviors.speaker_autocomplete = {
    attach: function () {
      $('.form-item-field-person-target-id input.form-text').autocomplete(
        {
          source: function (req, add) {
            // send off to speaker rest view
            $.getJSON(
              '/speakers.json?search=' + req.term, req, function (data) {
                var results = [];
                var preferredSorting = ['Commissioner', 'Chairman'];
                $.each(
                  data, function (i, val) {
                    var positionTitle = '';
                    var fullName = val.firstname + ' ' + val.lastname;
                    if (val.field_position_title && val.field_position_category !== 'Other') {
                      positionTitle = val.field_position_title;
                    }
                    else if (val.field_position_category !== 'Other') {
                      positionTitle = val.field_position_category === 'Chair' ? 'Chairman' : val.field_position_category;
                    }
                    var speakerCombined = positionTitle ? positionTitle + ' ' + fullName : fullName;

                    results.push(
                      {
                        label: speakerCombined,
                        id: val.id
                      }
                    );
                  }
                );
                results.sort(
                  function (a, b) {
                    var compA = $.inArray(a.label.split(' ')[0], preferredSorting);
                    var compB = $.inArray(b.label.split(' ')[0], preferredSorting);
                    if (compA > compB) return -1;
                    return (compA < compB) ? 1 : 0;
                  }
                );
                add(results);
              }
            );
          },
          select: function (e, ui) {
            $('input#edit-speaker', this.form).val(ui.item.id);
            $('input#edit-field-person-target-id', this.form).val(ui.item.label);
            $("input[name='aId']", this.form).val($(this).attr('id'));
            this.form.submit();
          }
        }
      );
    }
  };
})(jQuery, Drupal);
