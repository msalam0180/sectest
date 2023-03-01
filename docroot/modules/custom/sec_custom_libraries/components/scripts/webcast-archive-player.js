jQuery(function($) {
  $(document).ready(function() {
    $.ajax({
      dataType: 'json',
      type: 'get',
      url: '/sites/secgov.dev.dd/files/2017-02/webcast-archive.json',
      success: function(data, textStatus, jqXHR) {
        var month = [];
        month[0] = "January";
        month[1] = "February";
        month[2] = "March";
        month[3] = "April";
        month[4] = "May";
        month[5] = "June";
        month[6] = "July";
        month[7] = "August";
        month[8] = "September";
        month[9] = "October";
        month[10] = "November";
        month[11] = "December";

        var webcasts = data.webcastarchives;
        var docid = window.location.search.split('=').pop();

        $.each(webcasts, function(i, webcast) {

          if (webcast.document_id === docid) {

            $("#head1").html(webcast.title);

            var d = new Date(webcast.created);
            var dfull = month[d.getUTCMonth()] + " " + d.getUTCDate() + ", " + d.getUTCFullYear();
            $("#head2").html(dfull);

            var vp1 = "<object type='application/x-shockwave-flash' id='limelight_player_694100' name='limelight_player_694100' class='LimelightEmbeddedPlayerFlash' width='480' height='321' data='//video.limelight.com/player/loader.swf'><param name='movie' value='//video.limelight.com/player/loader.swf'/><param name='wmode' value='transparent'/><param name='allowScriptAccess' value='always'/><param name='allowFullScreen' value='true'/><param name='flashVars' value='mediaId=";

            var vp2 = "&amp;playerForm=1eeeef32ccb64474827ee6f8b5c06fe9'/></object>";

            $("#videospan").html(vp1 + webcast.videoid + vp2);

            $.each(webcast.seealso, function(j, seealso) {
              $("#additionalmaterials").append("<li>" + seealso + "</li>");
            });
          }
        });
      },
      complete: function(jqXHR, textStatus) {
        LimelightPlayerUtil.initEmbed('limelight_player_694100');
      }
    });
  });

});
