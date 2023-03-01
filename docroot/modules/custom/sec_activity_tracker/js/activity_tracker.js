/**
 * @file
 * Contains the definition of the behaviour sec_activity_tracker.
 */
(function ($, Drupal) {
  'use strict';
  /**
   * Attaches the JS sec_view_filter_plugin.
  */
  Drupal.behaviors.secActivityTracker = {
    attach: function (context) {
      $('#views-exposed-form-sec-user-activity-log-page-1 input:text').datepicker();
    }
  };
})(jQuery, Drupal);
