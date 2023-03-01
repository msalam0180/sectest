var amp;

// Load AWS snippet config and CDN
function loadHandler(primary, secondary, options) {
  var amp;
  var cdn = '//amp.akamaized.net/hosted/1.1/player.esi?apikey=sec&version=9.1.2'; // Update CDN version here
  var config = {
    autoplay: true,
    robustnessLevel: 'SW_SECURE_CRYPTO',
    captioning: {
      enabled: true
    },
    media: {
      autoplay: true,
      autoplayPolicy: "muted",
      title: 'SEC Live Video',
      poster: '//www.sec.gov/video/resources/images/sec-video-poster.jpg',
      duration: 108,
      source: [{ // Pass taxonomy vocabulary to stream
        src: primary + '?enableSSLTransfer=true',
        type: 'application/x-mpegURL'
      },
      {
        src: secondary + '?enableSSLTransfer=true',
        type: 'video/f4m'
      }],
      temporalType: 'live',
      track: [{
        kind: 'captions',
        type: (navigator.userAgent.match(/iPad/i) === null) ? 'live-oncaptioninfo' : 'text/cea-708',
        srclang: 'en',
        src: ''
      }],
    }
  }
  // Add required config to AWS config
  jQuery.extend(true, config, options);
  jQuery.getScript(cdn, function (data, textStatus, jqxhr) {
    amp = akamai.amp.AMP.create('akamai-media-player', config);
  });
  // Removing stream urls from html.
  jQuery('#akamai-media-player').attr('data-primary', '');
  jQuery('#akamai-media-player').attr('data-secondary', '');
}

function checkLiveWebcast() {
  jQuery.get(
    '/api/webcast/event/' + jQuery('meta[name=id]').attr('content'), function (data) {
      var webcast = data[0];
      if (webcast && webcast['field_webcast_state'] === 'live'
        || webcast && webcast['field_event_type'] === 'Hidden' && webcast['field_webcast_state'] === 'testing'
      ) {
        if (jQuery('.live-player:hidden').length > 0) {
          jQuery('.live-player,#block-webcast-trouble,#block-flashsoftware').show();
          loadHandler(jQuery('#akamai-media-player').data('primary'), jQuery('#akamai-media-player').data('secondary'), jQuery('#akamai-media-player').data('config'));
        }
      }
      else if (jQuery('.live-player:visible').length > 0) {
        // if the video was playing then destroy it and hide
        amp.destroy();
        jQuery('.live-player,#block-webcast-trouble,#block-flashsoftware').hide();
      }
      setTimeout(checkLiveWebcast, 10000);
    }
  );
}

jQuery(document).ready(
  function () {
    if (jQuery('body.user-logged-in').length > 0) {
      loadHandler(jQuery('#akamai-media-player').data('primary'), jQuery('#akamai-media-player').data('secondary'), jQuery('#akamai-media-player').data('config'));
    }
    else {
      checkLiveWebcast();
    }
  }
);

