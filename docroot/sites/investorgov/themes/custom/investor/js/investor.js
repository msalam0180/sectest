//Megamenu
(function($, enquire) {

	$('#investor-main-menu li > span, #investor-main-menu li > a').addClass('menu__link');
	$('#investor-main-menu li > span').addClass('nolink');
	$('#investor-global-navigation').addClass('region-navigation');
	$('#block-investor-main-menu').addClass('menu-block-1');
	$('.menu-item--expanded').addClass('is-expanded');
	$('.menu-item').addClass('menu__item');

  // wrapper to allow for full width of background for "Additional Resources" submenu
  var createSubMenuWrapper = function () {
    var section = $(".navigation-wrapper #investor-main-menu > .menu-item.menu-item--expanded");

    section.each(function() {
      var item = $(this);
      var submenu = item.children('.menu');
      var menuWrapper = "<div class='nav-submenu-wrapper'></div>";
      item.append(menuWrapper);
      item.children('.nav-submenu-wrapper').html(submenu);
    });
  };

  var removeSubMenuWrapper = function() {
    var section = $(".navigation-wrapper #investor-main-menu > .menu-item.menu-item--expanded");

    section.each(function() {
      var item = $(this);
      var subMenu = item.children('.nav-submenu-wrapper').children('.menu');
      item.append(subMenu);
      item.children('.nav-submenu-wrapper').remove();
    })
  };

  var collapseTools = function () {
    var tools = $('.menu-mlid-709');
    var toolsLink = tools.children('.menu__link').clone();
    var subMenu = tools.children('.menu');
    subMenu.html('<li class="menu__item is-leaf first leaf tools-link"></li>');
    $('.tools-link').append(toolsLink);
    tools.children('.menu__link').remove();
    tools.prepend('<span class="menu__link nolink">Planning Tools</span>');
    toolsLink.html('Free Financial Planning Calculators');
  }


	var megaMenu = $('#investor-main-menu');
	var menuSection = megaMenu.children('.menu-item');

  var hideSubMenus = function () {
    menuSection.find('ul').hide();
  }

  var showSubMenus = function () {
    menuSection.find('ul').show();
  }


  $(document).ready(function () {
    hideSubMenus();
    collapseTools();
  });

	$(document).ready(function(){
    enquire.register("screen and (min-width:960px)", {


      match: function () {
        createSubMenuWrapper();
        showSubMenus();
      },

      unmatch: function () {
        removeSubMenuWrapper();
      }
    });
  });
})(jQuery, enquire);

// Megamenu tabable
(function ($) {

  var desktopFocus = function () {

    if(window.innerWidth >= 960) {
      $('a').focus(function(){
        // on any focus event, close all nav submenus
        var section = $(".navigation-wrapper #investor-main-menu > .menu-item.menu-item--expanded");
        var activeSection = $(this).parents('.navigation-wrapper #investor-main-menu > .menu-item.menu-item--expanded');

        section.each(function() {
          section.find('.nav-submenu-wrapper').removeClass('has-target');
        });

        // open active nav submenu if focused item in main nav
        if($(this).parents('.navigation-wrapper').length) {
          activeSection.find('.nav-submenu-wrapper').addClass("has-target");
        }
      });

      $('.nav-submenu-wrapper').mouseleave(function() {
        $('.has-target').removeClass('has-target');
      })

      $(":not(a):not(svg):not(path)").focus(function() {
        $('.nav-submenu-wrapper.has-target').removeClass('has-target');
      })
    }
  }

  $(document).ready(function(){
    desktopFocus();
  });

  // End custom jQuery wrapper
})(jQuery);

//Placeholder text on search
(function ($) {

  var SearchFieldContainer = $('.block-views-blocksearch-content-block-1 .form-item-keys');
  SearchFieldContainer.find('.form-text').attr('placeholder', SearchFieldContainer.find('label').text());

})(jQuery);

//Megamenu Mobile
(function($, enquire) {

  var placeSearchBarInMobileMenu = function () {

    if (!$('.mobile-menu-search-container').length) {
      $('.navigation-wrapper').append('<div class="mobile-menu-search-container"></div>');
      $('.mobile-menu-search-container').append($('.block-views-blocksearch-content-block-1'));
      $('.mobile-menu-search-container').append($('.menu--auxiliary-header'));
    }

  };

  var removeMobileSearchSection = function () {

    if($('.mobile-menu-search-container').length) {
      $('.menu--auxiliary-header').appendTo('.region-header2');
      $('.block-views-blocksearch-content-block-1').appendTo('.region-header2');
      $('.mobile-menu-search-container').remove();
    }
  };

  var openCloseMenu = function () {

    var navbar = $('#investor-global-navigation');
    var menuIcon = $('#mobile-menu-toggle');


    if (menuIcon.hasClass('is-closed')) {

      menuIcon
        .removeClass('is-closed')
        .addClass('is-open');

      navbar.slideDown();
    } else if (menuIcon.hasClass('is-open')) {

      menuIcon
        .removeClass('is-open')
        .addClass('is-closed');
      resetMenu();

      navbar.slideUp()
    }
  };

  var resetMenu = function() {
    $('.region-navigation .is-selected').removeClass('is-selected');

    if($('.submenu-open')) {
      var parent = $('.submenu-open');
      $('.mobile-menu-back').hide();
      $('.region-navigation .menu .menu').css({'overflow': '','display': 'none'});
      $('.menu__item:not(.nav-icon)').show();
      $(parent).removeClass('submenu-open').slideDown();
    };
    $(".menu-block-1 > .menu > li.menu__item.is-expanded").css({'overflow': '','display': ''});
  }



  $(document).ready(function () {

    var mobileMenuToggle = $("<div id='mobile-menu-toggle' class='is-closed' tabindex=0><span class='sr-only'>Menu Toggle</span><span class='fa fa-navicon'></span></div>"),
        regionHeader = $('.header-content');

    mobileMenuToggle.insertAfter(regionHeader);

    $('#mobile-menu-toggle').on('click keypress', function (e) {
      if(e.type == 'click') {
        openCloseMenu();
      }
      else {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode == '13') {
          openCloseMenu();
        }
      }
    });

  })

  $(document).ready(function () {



      enquire.register("screen and (max-width:959px)", {

        match: function () {
          $('.region-navigation').hide();
          placeSearchBarInMobileMenu();
          $('.region-navigation .menu .menu').css({'display': ''});
        },

        unmatch: function () {
          removeMobileSearchSection();
          resetMenu();
          $('.region-navigation .menu .menu').css({'display': ''});
          $('#mobile-menu-toggle').removeClass('is-open').addClass('is-closed');
          $('.region-navigation').css({'overflow': '', 'display': 'block'});
        }
      });

  });

})(jQuery, enquire);

//Mobile subMenu
(function($, enquire) {
  function levelDown() {
    // selecting all first-level main menu sections
    $(".menu-block-1 > .menu > li.menu__item.is-expanded").each(function() {
      var item=this;
      // focused item is first-level link or child link
      if($(item).hasClass('is-selected')) {
        // add tabbability for non-links in menu
        $('.region-navigation .is-selected .menu__link.mobile').attr('tabindex', 0);
        $('.region-navigation .is-selected').children('.menu__link.mobile.nolink').attr('tabindex', -1);
        if($(item).find('.is-selected').length) {

          $('.region-navigation .is-selected').children('.menu').slideDown();
          $('.region-navigation .is-selected').siblings('.mobile-menu-back').slideDown();
          $('.region-navigation .is-selected').siblings('.menu__item').slideUp();
          $(item).siblings('.mobile-menu-back').slideUp();
          $(item).addClass('submenu-open');
        } else {
          $(item).removeClass('submenu-open');
          $(item).children('.menu').slideDown();
          $('.region-navigation .is-selected').siblings('.mobile-menu-back').slideDown();
        };
      } else {
        // close menus not containing focused item
        $(item).hide();
      };
    });
  }

  var mobileMenuLinks = function () {

    var parent = $('.region-navigation li.is-expanded');

    parent.removeClass('is-selected');
    parent.children('.menu__link').addClass('mobile');

    //Main Menu Expand Toggles Function
    $('.region-navigation .is-expanded .menu__link.mobile').on('click keypress', function(e){

      var link = $(this);
      if(e.type == 'click') {
        if(link.parent('li').hasClass('is-selected')){
            link.trigger();
        } else {
          e.preventDefault();
          link.parent('li').addClass('is-selected');
          link.blur();
        };

        levelDown();

        return false;
      }
      else {
        var keycode = (e.keyCode ? e.keyCode : e.which);
        if (keycode == '13') {
          if(link.parent('li').hasClass('is-selected')){
              link.trigger();
          } else {
            e.preventDefault();
            link.parent('li').addClass('is-selected');
            link.blur();
          };

          levelDown();

          return false;
        }
      }
    });
  };

  var activateSelectedLinks = function(link) {
    if(link.parent('li').hasClass('is-selected')){
        link.trigger();
    } else {
      e.preventDefault();
      link.parent('li').addClass('is-selected');
    };

    levelDown();

    return false;
  }

  var removeMobileMenuLinks = function () {

      var mobileLink = $('.region-navigation .is-expanded .menu__link');

      if(mobileLink.hasClass('mobile')) {
        mobileLink.unbind('click');
        mobileLink.removeClass('mobile');
      }

      if(mobileLink.hasClass('nolink')) {
        // mobileLink.attr('tabindex', -1);
      }
  };


  var upOneLevel = function (el) {
    var activeElement = $(el).siblings('.is-selected');
    activeElement.children('.menu').slideUp(function() {
      activeElement.removeClass('is-selected');
    });
    activeElement.slideDown();
    activeElement.siblings('.menu__item:not(.nav-icon)').slideDown();
    activeElement.siblings('.mobile-menu-back').slideUp();

    if($('.submenu-open')) {
      var parent = $('.submenu-open');
      $(parent).removeClass('submenu-open').slideDown();
      $(parent).siblings('.mobile-menu-back').slideDown();
    }
  };

  var backContainer = function () {
    var back = $("<li class='mobile-menu-back'><a href='javascript:void(0)' class='back-link'>BACK</a></li>");
    $('.region-navigation .menu').prepend(back);
    $('.mobile-menu-back').hide();

    $('.back-link').on('click', function (e) {
      e.preventDefault;
      var el = $(this).parent();
      upOneLevel(el);
    })
  }

  $(document).ready(function () {
    backContainer();
    mobileMenuLinks();
  });

	$(document).ready(function () {
    enquire.register("screen and (min-width:960px)", {

      match: function () {
      	removeMobileMenuLinks();
      },

      unmatch: function () {
      	mobileMenuLinks();
      }
    });
  });



})(jQuery, enquire);

(function($, enquire) {

  var getIcons = function () {
    var iconItem = "<li class='menu-item nav-icon'></li>";
    var glossary = $('.menu-item-intro > .nav-submenu-wrapper > .menu');
    var alert = $('.menu-item-research > .nav-submenu-wrapper > .menu');
    var research = $('.menu-item-protect > .nav-submenu-wrapper > .menu');
    var additional = $('.menu-item-resources > .nav-submenu-wrapper > .menu');
    var iconGlossary = "<a href='/introduction-investing/investing-basics/glossary'><div class='glossary-link'>Questions? <span>Visit Our Glossary</span></div></a>";
    var iconAlert = "<a href='/introduction-investing/general-resources/news-alerts/alerts-bulletins'><div class='alerts-link'>Alerts <span>and Bulletins<span></div></a>";
    var iconGlass = "<a href='http://www.adviserinfo.sec.gov/IAPD/Default.aspx'><div class='magnify-glass-link'>Check Out Your <span>Investment Professional</span></div></a>";
    var iconCalc = "<a href='/financial-tools-calculators/calculators/compound-interest-calculator'><div class='calc-link'>Calculate <span>Compound Interest</span></div></a>";
    $(glossary).append(iconItem);
    $(alert).append(iconItem);
    $(research).append(iconItem);
    $(additional).append(iconItem);
    $(glossary).find('.nav-icon').append(iconGlossary);
    $(alert).find('.nav-icon').append(iconAlert);
    $(research).find('.nav-icon').append(iconGlass);
    $(additional).find('.nav-icon').append(iconCalc);
  }

  var hideIcons = function () {
    $('.magnify-glass-link').hide();
    $('.calc-link').hide();
  };

  var showIcons = function () {
    $('.magnify-glass-link').show();
    $('.calc-link').show();
  };

  $(document).ready(function () {
    getIcons();
  });

  $(document).ready(function () {
    enquire.register("screen and (min-width:960px)", {

      match: function () {
        showIcons();
      },

      unmatch: function () {
        hideIcons();
      }
    });
  });

})(jQuery, enquire);

// Sidebar menu
(function($, enquire) {

  $('.main .layout__region--first').addClass('region-sidebar-first');
  $('#investor-sidebar-first .foux-sidebar').addClass('region-sidebar-first');
  $('#investor-sidebar-first #local-nav').addClass('region-sidebar-first');


  // Make make pages look active
  function fouxActiveLink(linkSelector){
    var $linkSelector = $(linkSelector);
    $linkSelector.addClass('is-active');
    $linkSelector.parent('li').addClass('menu-item--active-trail is-selected');
  }


  var dropdownButtons = function () {

    var sidebarItem = $('.region-sidebar-first .menu-item--expanded'),
        subMenuButton = $('<span class="sub-menu-button" tabindex="0"><a class="sub-menu-link" tabindex="-1" href="javascript:void(0)"><span class="element-invisible">Expand</span></a></span>');
    sidebarItem.append(subMenuButton);

    $('.region-sidebar-first .sub-menu-button').each(setHeight);


    //Main Menu Expand Toggles Function
    $('.region-sidebar-first .sub-menu-button').click(function(e){
      var button = this;
      e.preventDefault();
      activateButtons(button);
      return false;
    });

    $('.region-sidebar-first .sub-menu-button').keypress(function(e){
      var button = this;
      e.preventDefault();
      if(e.keyCode == '13') {
        activateButtons(button);
      }

      return false;
    });
  };

  var activateButtons = function(button){
    var parent = $(button).parent('li');
    if (parent.hasClass('is-selected')){
      parent.removeClass('is-selected');
      $(button).prev('ul').slideUp();
      $('.region-sidebar-first .sub-menu-button').each(setHeight);
    } else {
      parent.addClass('is-selected');
      $(button).prev('ul').slideDown();
      parent.children('.menu__link').focus();
      $('.region-sidebar-first .sub-menu-button').each(setHeight);
    }
  }

  var setHeight = function () {
    var button = this;
    var sibling = $(button).prev().prev();
    $(button).css('height', $(sibling).innerHeight() + 'px');
  }

  var openActive = function () {
    var sidebarParent = $('.region-sidebar-first .menu__item.menu-item--active-trail');
    sidebarParent.addClass('is-selected');
    sidebarParent.children('.menu').show();
  }

  $(document).ready(function() {
    openActive();
    fouxActiveLink(".node--type-glossary-term .region-sidebar-first #investor-main-menu a[data-drupal-link-system-path*='glossary']");
    fouxActiveLink(".view-id-glossary .region-sidebar-first #investor-main-menu a[data-drupal-link-system-path*='glossary']");

    var location = window.location.pathname;
    var bodyClass;
    if (location.indexOf('/investor-alerts/') >= 0){
      bodyClass = 'news-type-alerts-and-bulletins';
    }else if (location.indexOf('/alerts-bulletins/') >= 0){
      bodyClass = 'news-type-alerts-and-bulletins';
    }else if (location.indexOf('/press-releases/') >= 0){
      bodyClass = 'news-type-press-releases';
    }
    $('body').addClass(bodyClass);

    fouxActiveLink(".news-type-press-releases.node--type-news .region-sidebar-first #investor-main-menu a[data-drupal-link-system-path*='selected-press-releases']");
    fouxActiveLink(".news-type-alerts-and-bulletins.node--type-news .region-sidebar-first #investor-main-menu a[data-drupal-link-system-path*='alerts-bulletins']");
  });

  $(document).ready(function() {
    dropdownButtons();

    window.addEventListener('resize', function (){
      $('.region-sidebar-first .sub-menu-button').each(setHeight);
    });


  });
})(jQuery, enquire);

(function ($) {
  $(document).ready(function () {

    // add extlink for external gov sites
    $("a[href*='.gov']").each(function(){
      var domain =  new URL($(this).attr("href")).hostname.split(".").slice(-2)[0].toLowerCase();
      if (domain && domain !== "sec" && domain !== "investor") {
        $(this).append('<svg class="ext" role="img" aria-label="(link is external)" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 40"><metadata><sfw xmlns="http://ns.adobe.com/SaveForWeb/1.0/"><slicesourcebounds y="-8160" x="-8165" width="16389" height="16384" bottomleftorigin="true"></slicesourcebounds><optimizationsettings><targetsettings targetsettingsid="0" fileformat="PNG24Format"><png24format transparency="true" filtered="false" interlaced="false" nomattecolor="false" mattecolor="#FFFFFF"></png24format></targetsettings></optimizationsettings></sfw></metadata><title>(link is external)</title><path d="M48 26c-1.1 0-2 0.9-2 2v26H10V18h26c1.1 0 2-0.9 2-2s-0.9-2-2-2H8c-1.1 0-2 0.9-2 2v40c0 1.1 0.9 2 2 2h40c1.1 0 2-0.9 2-2V28C50 26.9 49.1 26 48 26z"></path><path d="M56 6H44c-1.1 0-2 0.9-2 2s0.9 2 2 2h7.2L30.6 30.6c-0.8 0.8-0.8 2 0 2.8C31 33.8 31.5 34 32 34s1-0.2 1.4-0.6L54 12.8V20c0 1.1 0.9 2 2 2s2-0.9 2-2V8C58 6.9 57.1 6 56 6z"></path></svg>');
      }
    })

    //prevent ajax from header search
    Drupal.behaviors.headerSearchAjax = {
      attach: function (context, settings) {
        if (context.className.indexOf("view-id-search_content") > 0) {
          let keyword = $("#views-exposed-form-search-content-block-1 input.form-text").val();
          if (typeof keyword !== "undefined") {
            window.location.href = "/search?keys=" + keyword;
          }
          return false;
        }
      }
    };

    if ($("body.view-id-glossary").length > 0 && $("#glossary-filter").length === 0 ) {
      //makes jQuery :contains case insensitive
      $.expr[":"].contains = $.expr.createPseudo(function(arg) {
        return function( elem ) {
            return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
        };
      });

      $("#glossary-search").append('<label for="glossary-filter">Search</label><input type="text" class="glossary-filter" id="glossary-filter" aria-controls="glossary-results" />');
      $(".view-glossary .view-content").attr({
        'aria-live':"polite",
        id:"glossary-results"
      });

      //add glossary search
      $("#glossary-filter").on("keyup",function(e){
        let keyword = $("#glossary-filter").val();
        if (typeof keyword !== "undefined" && keyword !== "") {
          //filter out glossary based on keyword matching
          $(".views-row").addClass("hidden"); //hide all elements
          $(".views-row .entity-list-title:contains('" + keyword +"')").parents(".views-row").removeClass("hidden");
          $(".views-row .views-field-field-alternate-name:contains('" + keyword +"')").parents(".views-row").removeClass("hidden");
          // no results behavior
          $('.view-glossary .view-content .no-results').remove();
          if( $('.view-glossary .view-content').children('.views-row:visible').length == 0 ) {
            $('.view-glossary .view-content').append('<div class="no-results">No results</div>');
          }
        } else {
          $('.view-glossary .view-content .no-results').remove();
          $(".views-row").removeClass("hidden"); //show all elements
        }
        e.preventDefault();
        return false;
      });
    }
  });
})(jQuery);


 // Custom backtoTop logic.
 (function ($) {
  var initBackTotop = function () {
  // No business running this function if id is not there.
    if ($('.back-to-top').length === 0) {
      return;
    }

    // Logic to handle smoother return-to-top.
    var amountScrolled = 500;
    var backTotop = $('a.back-to-top');
    var footerHeight = $('.site-footer').height() + 10;
    backTotop.hide();

    $(window).scroll(function () {
      if ($(window).scrollTop() > amountScrolled) {
        backTotop.fadeIn('slow');
        backTotop.css('bottom', footerHeight);
      }
      else {
        backTotop.fadeOut('slow');
      }
    });

    $('a.back-to-top').click(function () {
      $('html, body').animate({
        scrollTop: 0
      }, 700);
      return false;
    });
  };

  initBackTotop();
})(jQuery);


//placholder text for IE so that it does not disappear
(function ($) {

  /* Microsoft Internet Explorer detected  */
  if(navigator.userAgent.indexOf('MSIE')!==-1 || navigator.appVersion.indexOf('Trident/') > -1){
    $(document).on( "focus", "[type='text']", function () {
      if ($(this).filter("[placeholder]") && !$(this).val()) {
        var placeholderText = $(this).attr('placeholder');
        $(this).val(placeholderText);
      }
    });

  }

  if ($('div[id^="accordion-"]').length > 0) {
    $('div[id^="accordion-"]').accordion({
      active: false,
      collapsible: true,
      heightStyle: 'content'
    });
  }

  // Smooth scroll  cross browser
  $(document).ready(function(){
    // Add smooth scrolling to all links
    $("a").on('click', function(event) {

      // Make sure this.hash has a value before overriding default behavior
      if (this.hash !== "") {
        // Prevent default anchor click behavior
        event.preventDefault();

        // Store hash
        var hash = this.hash;

        // Using jQuery's animate() method to add smooth page scroll
        // The optional number (600) specifies the number of milliseconds it takes to scroll to the specified area
        $('html, body').animate({
          scrollTop: $(hash).offset().top
        }, 600, function(){

          // Add hash (#) to URL when done scrolling (default click behavior)
          window.location.hash = hash;
        });
      } // End if
    });
  });

  // If there is an anchor menu/sidebar block add this element to use to detect when menu is at top
  // Using this element and not the block/menu prevents flickering
  $('div[class*=block-title-anchor]').before('<div id=\'sticky-anchor\'></div>');

  if ($('div[class*=block-title-anchor]').length > 0) {
    // Anchor Sidebar - make menu sticky when at top of window
    function sticky_relocate() {
      var window_top = $(window).scrollTop();
      var div_top = $('#sticky-anchor').offset().top;
      if (window_top > div_top)
        $('div[class*=block-title-anchor]').addClass('sticky-anchor');
      else
        $('div[class*=block-title-anchor]').removeClass('sticky-anchor');
    }

    $(function () {
      $(window).scroll(sticky_relocate);
      sticky_relocate();
    });
  }


// Views filter by items per page
  $(document).ready(function () {

    if ($('.view-id-news_alerts #edit-items-per-page').length > 0) {
      $('#edit-items-per-page').change(function () {
        window.location.search = window.location.search + '&page=0&items_per_page=' + this.value;
      });

      if (!String.prototype.endsWith)
        String.prototype.endsWith = function(searchStr, Position) {
          // This works much better than >= because
          // it compensates for NaN:
          if (!(Position < this.length))
            Position = this.length;
          else
            Position |= 0; // round position
          return this.substr(Position - searchStr.length,
            searchStr.length) === searchStr;
        };
      if (window.location.href.endsWith("5")) {
        $('#opt25').removeAttr("selected");
        $('#opt5').attr("selected", "selected");
        $('.pager__item a').attr('href',function(i,str) { //updates the pager 1,2,3,last etc links to be this option
          return str + '?items_per_page=5';
        });
      }
      if (window.location.href.endsWith("10")) {
        $('#opt25').removeAttr("selected");
        $('#opt10').attr("selected", "selected");
        $('.pager__item a').attr('href',function(i,str) {
          return str + '?items_per_page=10';
        });
      }
      if (window.location.href.endsWith("25")) {
        $('#opt5').removeAttr("selected"); // first item in select list is given a default 'selected'
        $('#opt25').attr("selected", "selected");
        $('.pager__item a').attr('href',function(i,str) {
          return str + '?items_per_page=25';
        });
      }
      if (window.location.href.endsWith("50")) {
        $('#opt25').removeAttr("selected");
        $('#opt50').attr("selected", "selected");
        $('.pager__item a').attr('href',function(i,str) {
          return str + '?items_per_page=50';
        });
      }
      if (window.location.href.endsWith("100")) {
        $('#opt25').removeAttr("selected");
        $('#opt100').attr("selected", "selected");
        $('.pager__item a').attr('href',function(i,str) {
          return str + '?items_per_page=100';
        });
      }
    }

  });

  // Unhide view all link on filtered investor alerts page and give active class to category header
  if ($("form[action='/investor/alerts']").length === 0) {
    $('#viewall').css('visibility', 'visible');
    $(".button-box a[href='" + window.location.pathname + "']").addClass('active');
  }



})(jQuery);

