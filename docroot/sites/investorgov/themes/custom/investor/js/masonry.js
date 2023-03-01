(function($) {
  $(document).ready(function() {

    function debounce(func, wait, immediate) {
	     var timeout;
       return function() {
         var context = this, args = arguments;
         var later = function() {
          timeout = null;
			    if (!immediate) func.apply(context, args);
		      };
		    var callNow = immediate && !timeout;
		    clearTimeout(timeout);
		    timeout = setTimeout(later, wait);
		    if (callNow) func.apply(context, args);
	     };
    }
    var masonryActive = false;
    var masonryElement = $('.main .layout--flowinggrid > .layout__region--content');
    function masonIt() {
      masonryActive = true;
      $(masonryElement).each(function() {
        var masonBlocks = $(this).find('.block-block-content').length;
        // if(!$(this).parent('div').hasClass('block-view--free-financial-planning-tools') && $(this).find('.views-row').length > 2) {
          $(this).masonry({
            itemSelector: '.layout--flowinggrid > .layout__region--content > .block',
            columnWidth: 1/3,
            percentPosition: true
          });
        // }
      });
    }

    if($(window).width() > 800) {
      masonIt();
    }

    var masonryToggle = debounce(function() {
      if($(window).width() > 800 ) {
        masonIt();
      } else if ($(window).width() <= 800 && masonryActive === true) {
        $(masonryElement).each(function() {
          masonryActive = false;
          $(this).masonry('destroy');
        });
      }
     }, 250);




    window.addEventListener('resize', masonryToggle);


  });




})(jQuery);

//Add help text to layout builder for Fluid Grid Sections
(function ($) {
  $( "<div class='fluidHelp'><strong>Fluid Grid:</strong> Can only contain Feature Blocks</div>" ).insertBefore( ".node-layout-builder-form .layout--flowinggrid" );
})(jQuery);