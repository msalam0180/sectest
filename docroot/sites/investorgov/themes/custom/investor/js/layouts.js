(function ($, Drupal) {

  Drupal.behaviors.hideEmptyLayoutRegions = {
    attach: function (context, settings) {
      // Hide layout builder regions that are empty
      $(".layout__region:not(:has(*))").hide();
    }
  };

  Drupal.behaviors.moveBookPager = {
    attach: function (context, settings) {
      // Move the book Pager into the main section of the page
    	$bookPager = $(".book-pager");
    	$bookContent = $('.main > .layout--threecol-25-50-25 .layout__region--second').first();
      if ($bookPager.length ){
      	$(".book-pager").once().appendTo($bookContent);
      }
    }
  };



})(jQuery, Drupal);
