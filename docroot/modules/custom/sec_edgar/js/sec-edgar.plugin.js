jQuery(
  function ($) {
    $(document).ready(function () {
      $(".tooltip").tooltip({
        position: "top right",
        offset: [-12, -12],
        relative: true
      });
      $("#less_options").toggle();
      $("#less_options_button").toggle();
      $("#more_options").toggle();
      $("#company_filing_search_tips").toggle();

      $(':input', 'form')
        .not(':button, :submit, :reset, :hidden')
        //.val('')
        .prop('selected', false);
    });
    $("img.tooltip").keypress(function (event) {
      if (event.which == 13) {
        event.preventDefault();//prevent form submission
        var api = $(this).data("tooltip");
        if (api.isShown()) {
          api.hide();
        }
        else {
          api.show();
        }
      }
    });
  }
);
