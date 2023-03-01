jQuery(document).ajaxComplete(
  function () {
    document.getElementById('limelight_player_92795').focus();
  }
);


jQuery(document).ready(
  function ($) {
    $('.has-mediaid').find('a').each(
      function () {
        var linkText = $(this).text().toLowerCase().trim();
        var webcastTitle = $('#head1').text().toLowerCase().trim();
        if (linkText === webcastTitle) {
          $(this).before(linkText);
          $(this).remove();
        }
        var playercode = $('#limelight_player_92795').data('mediaid');
        LimelightPlayerUtil.embed({'playerForm': 'Player', 'width': 480, 'playerId': 'limelight_player_92795', 'mediaId': playercode, 'height': 270}); // eslint-disable-line no-undef
      }
    );
  }
);
