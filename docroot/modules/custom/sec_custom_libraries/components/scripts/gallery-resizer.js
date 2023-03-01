jQuery(function($) {
  function galleryResizer() {
    // init Isotope
    var $grid = $("#gallery").isotope({
      itemSelector: ".gallery-item",
      layoutMode: "fitRows"
    });

    var viewportWidth = $(window).width();
    if (viewportWidth <= 767) {
      $(".gallery-item").removeClass("colspan-3").addClass("small-2");
    } else {
      $(".gallery-item").removeClass("small-2").addClass("colspan-3");
    }
  }
  $(window).on("resize load", galleryResizer);
  $(document).ready(function() {
    galleryResizer();
  });
});
