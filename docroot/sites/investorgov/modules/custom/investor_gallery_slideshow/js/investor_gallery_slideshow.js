(function ($) {
  function addVideoLinkRequired() {
    var videoOrigin = $('select[name="field_video_origin"]');
    if (videoOrigin.val() == "upload") {
      $('.form-item-field-video-0-value').addClass("hidden");
      $('.field--name-field-media-video-file').removeClass("hidden");
    } else if(videoOrigin.val() == "youtubevimeo") {
      $('.field--name-field-media-video-file').addClass("hidden");
      $('.form-item-field-video-0-value').removeClass("hidden");
    } else {
      $('.form-item-field-video-0-value').addClass("hidden");
      $('.field--name-field-media-video-file').addClass("hidden");
    }
  }

  Drupal.behaviors.investorGallerySlideshow = {
    attach: function (context) {
      $('select[name="field_video_origin"]').change(function() {        
        addVideoLinkRequired();
      });
      addVideoLinkRequired();
      const reqLabelClasses = 'js-form-required form-required';
      // Adds CSS class to style these fields to look required
      $('.form-item-field-video-0-value label, .form-item-field-video-0-value .label').addClass(reqLabelClasses);
      $('.field--name-field-media-video-file label, .field--name-field-media-video-file .label').addClass(reqLabelClasses);
    }
  }
})(jQuery);
