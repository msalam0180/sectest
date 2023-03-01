(function ($, Drupal) {
  Drupal.behaviors.webformRecaptcha = {
    attach: function (context, settings) {
      // OSSS-17645 Makes reCAPTCHA element required field.
      let intervalId = setInterval(function () {
        // This code runs every 3 seconds until element has been altered.
        let captcha = $('#captcha .g-recaptcha');
        let config = { attributes: true, childList: true, characterData: true };
        captcha.each(function () {
          let target = this;
          // Add observer once recaptcha expire to add required attribute again.
          let observer = new MutationObserver(function (mutations) {
            mutations.forEach(function (mutation) {
              if (mutation.type === 'childList') {
                if (!$('#g-recaptcha-response').hasClass('visually-hidden')) {
                  recaptchaRequired();
                }
              }
            });
          });
          observer.observe(target, config);
        });
        recaptchaRequired();
      }, 3000);
      // Alter the textarea for recaptcha.
      function recaptchaRequired() {
        let recaptcha = $('#g-recaptcha-response');
        if (recaptcha.length > 0) {
          recaptcha.addClass('visually-hidden');
          recaptcha.prop({ required: true });
          recaptcha.attr({
            onkeydown: 'return false',
            tabindex: '-1',
            style: 'margin: -83px 0 0 0; width: 302px; height: 76px;'
          });
          // Resetting focus
          recaptcha.focus(function (e) {
            e.preventDefault();
            if (e.relatedTarget) {
              // Revert focus back to captcha element
              $('#captcha > summary').focus();
            } else {
              // No previous focus target, blur instead
              e.currentTarget.blur();
            }
          });
          clearInterval(intervalId);
        }
      }
    }
  }
})(jQuery, Drupal);
