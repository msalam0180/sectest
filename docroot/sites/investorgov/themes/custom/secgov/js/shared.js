(function ($) {
  'use strict';

  // Preload SEC Video Search Feature
  $(document).ready(function () {
    var context = $('.path-webform');
    var attrForValidation = {
      'required': 'required',
      'aria-required': true
    };
    if (context.length > 0) {
      var fileInput = context.find('input[type="file"]');
      context.find('.webform-address option[value="United States"]').first()
        .prop('selected', true);
      var isRequiredfileInput = fileInput.parents()
        .find('#ajax-wrapper')
        .first()
        .find('label')
        .hasClass('form-required');
      if (isRequiredfileInput) {
        fileInput.attr(attrForValidation);
      }
      $('form').submit(function () {
        if (!grecaptcha.getResponse()) { // eslint-disable-line no-undef
          event.preventDefault();
          $('<span class="red recaptcha">reCAPTCHA is invalid</span>').insertAfter('.g-recaptcha');
        }
      });
    }
    if ($('.sec-videos-view #edit-reset').length > 0) {
      $('.sec-videos-view #edit-submit-sec-videos').hide();
      $('.sec-videos-view .views-exposed-form').show();
    }
    else {
      $('.sec-videos-view .views-exposed-form').show();
      $('.sec-videos-view #edit-submit-sec-videos').show();
    }
    if ($('.spotlights-view #edit-reset').length > 0) {
      $('.spotlights-view #edit-submit-spotlights').hide();
      $('.spotlights-view .views-exposed-form').show();
    }
    else {
      $('.spotlights-view .views-exposed-form').show();
      $('.spotlights-view #edit-submit-spotlights').show();
    }
  });
  // Initialize main-navigation
  $('ul#main-menu').superfish({
    delay: 650,		// delay on mouseout
    animation: {height: 'show'},	// fade-in and slide-down animation
    dropShadows: false
  });

  $('ul#user-menu').superfish();

  // when window loads
  $(window).on('load', function () {
    shortenPageTitle();
  });

  // On viewport size change, refresh the screen
  window.onresize = function (event) {
  // document.location.reload(true);
  // location.reload();
    shortenPageTitle();

    if ($('div[id^="tabs-"]').length > 0) {
      setTabSize();
    }
    if ($('div.tabs').length > 0) {
      setTabSize();
    }
  };

  /* disable dropdown for preview pages without id (new content preview) */
  if ($("meta[name='id']").length == 0 && $('.node-preview-form-select select').length > 0) {
    $('.node-preview-form-select select').attr('disabled', true);
  }

  /* highlight navigation for detail pages */
  if ($('.newsroom-list-page').length > 0 || $('.article-list').length > 0) {
    $("#local-nav li a[href='" + window.location.pathname + "']").addClass('is-active');
  }

  if ($('body.path-node').length > 0) {
    var navPath = window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/'));
    switch (navPath) {
    case '/news/press-release':
      navPath = '/news/pressreleases';
      break;
    case '/news/public-statement':
      navPath = '/news/statements';
      break;
    default:
      break;
    }
    $("body.node--type-news #local-nav li a[href^='" + navPath + "']").addClass('is-active');
  }


  /* Show/Hide Global Search label */
  $('#global-search-box').click(function () {
    $('#global-search label.overlabel').hide();
  }).focusin(function () {
    $('#global-search label.overlabel').hide();
  }).focusout(function () {
    if ($('#global-search-box').val().length > 0) {
      $('#global-search label.overlabel').hide();
    }
    else {
      $('#global-search label.overlabel').show();
    }
  });

  $('.sf-menu li a').focusin(function () {
    $(this).parent().addClass('focus');
  }).focusout(function () {
    $(this).parent().removeAttr('class');
  });

  /* Check if homepage then add ids to slides */
  if ($('#home').length > 0) {
    $('ul.slides > li').each(function (i) {
      $(this).attr('id', 'slide-' + (i + 1));
    });
  }

  $('tr').focusin(function () {
    $(this).addClass('current');
  }).focusout(function () {
    $(this).removeClass('current');
  });

  /* Calculate the height of the left nav to set min-height of the article-content class */
  if ($('.article-content').length > 0) {
    var leftNavHeight = $('.local-nav').height();
    var articleContent = $('.article-content').height();
    if (leftNavHeight > articleContent) {
      $('.article-content').css('min-height', leftNavHeight);
    }
  }

  /* Tablet Left Nav Control */
  $('.left-nav-menu').click(function () {
    var $leftNav = $(this).children('span.fa');

    if ($leftNav.hasClass('fa-navicon')) {
      $leftNav.removeClass('fa-navicon').addClass('fa-close');
      $('.local-nav').show('slide', {direction: 'left'});
    }
    else {
      $leftNav.removeClass('fa-close').addClass('fa-navicon');
      $('.local-nav').hide('slide', {direction: 'left'}, 'fast');
    }
  });

  $('.local-nav li a').click(function () {
    if ($(window).width() < 768 && !($(this).parent().hasClass('slider-key'))) {
      $(this).css({
        'background-color': '#FFC057​',
        'color': '#273a56'
      });
    }
  });

  /* Mobile Navigation Accordion */
  var mobileSliders = $('#sidebar-first ul.mobile-nav li ul').parent();
  mobileSliders.wrapAll('<div class="mobile-nav-sliders"> </div>');
  $('.mobile-nav-sliders').find('> li').addClass('slider-key');
  $('.mobile-nav-sliders').find('> li > ul').addClass('slider-children');
  $('.mobile-nav-sliders').accordion({
    active: false,
    collapsible: true,
    heightStyle: 'content'
  });
  $('.mobile-nav-sliders .slider-key > a').attr('tabindex', '0');

  /* Mobile Search block in mobile nav */
  $('#mobile-search-box').click(function () {
    $('#mobile-search label.overlabel').hide();
  }).focusin(function () {
    $('#mobile-search label.overlabel').hide();
  }).focusout(function () {
    if ($('#mobile-search-box').val().length > 0) {
      $('#mobile-search label.overlabel').hide();
    }
    else {
      $('#mobile-search label.overlabel').show();
    }
  });

  /* Left Newsroom Navigation Accordion */
  var sliders = $('#sidebar-first nav ul li ul').parent();
  sliders.wrapAll('<div class="left-nav-sliders"> </div>');
  $('.left-nav-sliders').find('> li').addClass('slider-key');
  $('.left-nav-sliders').find('> li > ul').addClass('slider-children');
  $('.left-nav-sliders').accordion({
    active: false,
    collapsible: true,
    heightStyle: 'content'
  });
  $('.left-nav-sliders .slider-key > a').attr('tabindex', '1');

  // left nav gtm track expansion
  $('#block-newsroomleftnav .slider-key > a').first().attr('id', 'rss-feed-subheader');
  $('#block-newsroomleftnav .slider-key > a').last().attr('id', 'social-media-subheader');


  /* AddThis async load function */
  var checkAddThisLoadedInterval = null;

  function checkAddThisLoaded() {
    if ($('.addthis_button_compact')) {
      $('.appIconsDetail').css('visibility', 'visible');
      clearInterval(checkAddThisLoadedInterval);
    }
  }

  if (typeof addthis !== 'undefined') { // eslint-disable-line no-undef
    addthis.init(); // eslint-disable-line no-undef
    checkAddThisLoadedInterval = setInterval(checkAddThisLoaded, 100);
  }

  /* Newsroom Monthbars */
  if ($('body.path-news #block-secgov-content .newsroom-list-page').length > 0) {
  // move first monthbar into place
    var firstMonthBar = $('.newsroom-list-page .grouped').first();
    $(firstMonthBar).insertAfter($('thead tr.header').first());
    $(firstMonthBar).replaceWith("<th colspan='3' class='grouped'>" + $(firstMonthBar).text() + '</th>');

    // hide bars when not sorting by date column
    if ($('#view-field-display-title-table-column').hasClass('is-active') ||
      $('#view-field-release-number-table-column').hasClass('is-active') ||
      $('#view-field-person-table-column').hasClass('is-active')) {
      $('.newsroom-list-page .grouped').hide();
    }

    else {
      $('.newsroom-list-page .grouped').show();
    }
  }

  /* Execute Biography Page JS */
  if ($('body.node--type-secperson').length > 0) {
  // add title to view more links
    $('.more-link a').each(function () {
      $(this).text($(this).text() + ' by ' + jQuery('span.title').text());
    });


    jQuery('.block-region-right > div').each(function () {
      // hide empty related blocks
      if ($(this).find('.views-row').length === 0) {
        $(this).hide();
      }
      // set links for block title
      var moreLinkHref = $(this).find('.more-link a').attr('href');
      $(this).find('.block-title-more-link a').attr('href', moreLinkHref);
    });

    // add Download link to image
    jQuery('.field_photo_person a').append('<br>Download High Resolution Image');

    if ($('.block.field_position_history .position-history-row').length == 0) {
      $('.block.field_position_history').hide();
    }
  }

  if ($('.article-list, .im-disclosure').length > 0) {
  /* Filter list by keywords */
    var $rows = $('.list tbody tr');
    $('#listSearch').keyup(function () {
      var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

      // do not filter columns with noFilter class
      $rows.show().filter(function () {
        var text = $(this).children('td').not('.noFilter').text().replace(/\s+/g, ' ').toLowerCase();
        return !~text.indexOf(val);
      }).hide();
    });

    /* Tablesorter for Article List Pages */
    var monthNames = {};
    monthNames['Jan.'] = 0;
    monthNames['Feb.'] = 1;
    monthNames['March'] = 2;
    monthNames['April'] = 3;
    monthNames['May'] = 4;
    monthNames['June'] = 5;
    monthNames['July'] = 6;
    monthNames['Aug.'] = 7;
    monthNames['Sept.'] = 8;
    monthNames['Oct.'] = 9;
    monthNames['Nov.'] = 10;
    monthNames['Dec.'] = 11;

    $.tablesorter.addParser({
      id: 'monthYear',
      is: function (s) {
        return false;
      },
      format: function (s, table, cell, cellIndex) {
        var date = $(cell).children('span.show-for-small').remove().end().text().trim().match(/^(Jan\.|Feb\.|March|April|May|June|July|Aug\.|Sept\.|Oct\.|Nov\.|Dec\.)[ ](\d{4})$/);
        if (date && date.length == 3) {
          var m = monthNames[date[1]];
          var y = date[2];
          var d = new Date(date[1].replace('.', '') + ' 1, ' + date[2]);
          return d.getTime();
        }
        return '';
      },
      type: 'numeric'
    });

    $.tablesorter.addParser({
      id: 'monthDayYear',
      is: function (s) {
        return false;
      },
      format: function (s, table, cell, cellIndex) {
        var date = $(cell).children('span.show-for-small').remove().end().text().trim().match(/^(Jan\.|Feb\.|March|April|May|June|July|Aug\.|Sept\.|Oct\.|Nov\.|Dec\.)[ ](\d{1,2}),[ ](\d{4})$/);

        if (date && date.length == 4) {
          var m = monthNames[date[1]];
          var dt = date[2];
          var y = date[3];
          var d = new Date(date[1].replace('.', '') + ' ' + date[2] + ', ' + date[3]);
          return d.getTime();
        }
        return '';
      },
      type: 'numeric'
    });


    $.tablesorter.addParser({
      id: 'replaceNA',
      is: function (s) {
        return false;
      },
      format: function (s) {
        return s.trim().replace(/\bn\/a\b/i, String.fromCharCode(127));
      },
      type: 'text'
    });

    $.tablesorter.addParser({
      id: 'datetime',
      is: function (s) {
        return false;
      },
      format: function (s, table, cell, cellIndex) {
        var t = $(cell).find('time').attr('datetime');
        return new Date(t).getTime();
      },
      type: 'numeric'
    });

    $.tablesorter.addParser({
      id: 'strippedString',
      is: function (s) {
        return false;
      },
      format: function (s, table, cell, cellIndex) {
        return s.trim().replace(/"/g, '').toLowerCase();
      },
      type: 'text'
    });


    /* Add list page sorts here */
    $('.fast-answers-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[0, 0]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'strippedString'},
        1: {sorter: 'monthDayYear', sortInitialOrder: 'desc'}
      },
      debug: false

    });

    $('.foia-freq-doc-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[1, 1]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'strippedString', sortInitialOrder: 'asc'},
        1: {sorter: 'monthDayYear', sortInitialOrder: 'desc'}
      },
      debug: false

    });

    $('.data-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[2, 1]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'text'},
        1: {sorter: 'text'},
        2: {sorter: 'monthYear', sortInitialOrder: 'desc'}
      },
      debug: false

    });

    $('.forms-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[0, 0]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'replaceNA'},
        1: {sorter: 'text'},
        2: {sorter: 'monthYear', sortInitialOrder: 'desc'},
        3: {sorter: 'text'},
        4: {sorter: 'text'}
      },
      debug: false
    });

    $('.im-disclosure .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[2, 1]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'text'},
        1: {sorter: 'text'},
        2: {sorter: 'datetime', sortInitialOrder: 'desc'}
      }
    });

    /* Forms List Show or Hide Section Details for Mobile */

    if (window.innerWidth <= 767) {
      $('.forms-list tr').each(function () {
        $(this).children('td.views-field-field-list-page-det-secarticle, td.views-field-term-node-tid').wrapAll($('<div>').addClass('section'));
      });
      $('.forms-list tr div.section').prepend($('<div>').addClass('section-label').html('Show Details'));

      $('.forms-list tr .section-label').click(function () {
        $(this).parent('div.section').toggleClass('active', function () {
          if ($(this).hasClass('active')) {
            $(this).children('.section-label').html('Hide Details');
          }
          else {
            $(this).children('.section-label').html('Show Details');
          }
        });
      });
    }

    $('.marketstructure-data .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[2, 1]],
      headers: {
        2: {sorter: 'monthYear'}
      },
      debug: false

    });

    $('.reports-pubs-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[0, 1]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'monthDayYear'}
      },
      debug: false

    });

    $('.staff-papers-list .list').tablesorter({
      emptyTo: 'emptyMax',
      ignoreCase: true,
      sortRestart: true,
      sortList: [[0, 1]],
      textExtraction: function (node, table, cellIndex) {
        return $(node).clone().children('span.show-for-small').remove().end().text();
      },
      headers: {
        0: {sorter: 'monthYear'}
      },
      debug: false

    });
  }

  // add onchange event listener to sec-videos filters and dropdown select on Article list pages
  if ($('.sec-videos-view,.spotlights-view,.im-disclosure').length > 0 || $('.article-list').length > 0) {
    Drupal.behaviors.contentSearchPage = {
      attach: function (context, settings) {
        $('.form-select').change(function () {
          $("input[name='aId']", this.form).val($(this).attr('id'));
          $(this).closest('form').trigger('submit');
        });
      }
    };
  }

  // Unhide view all link on filtered investor alerts page
  if ($("form[action='/investor/alerts']").length == 0) {
    $('#viewall').css('visibility', 'visible');
    $(".button-box a[href='" + window.location.pathname + "']").addClass('active');
  }

  // Activate accordion
  if ($('.list-accordion').length > 0) {
    var icons = {
      header: 'ui-icon-circlesmall-plus',
      activeHeader: 'ui-icon-circlesmall-minus'
    };
    $('.list-accordion').accordion({
      active: false,
      collapsible: true
    });
  }

  $('.accordion-statistics-guide').accordion({
    active: false,
    collapsible: true
  });// Activate tabs
  function setTabSize() {
    $('li.ui-tabs-tab').css('height', '');
    $('li.ui-tabs-tab').children().removeAttr('style');

    var tabSets;
    var tabsLength;
    var tabGroupName;
    var tabWidth;
    var tabHeights = [];
    var tabWidths = [];
    var contentHeights = [];
    var tabHeight;
    var currentHeight;
    var maxHeight;
    var minHeight;
    var newPadding;

    if ($('.ui-tabs').length > 0) {
      tabSets = $('.ui-tabs').length;
    }

    // if ( $('div[id^="tabs"] ul li').length > 0 ) {
    //
    // } else if ( $('div.tabs ul li').length > 0 ) {
    // 	tabsLength = $('div.tabs ul > li.ui-state-default').length;
    // }

    $('.ui-tabs').each(function (i) {
      if ( $(this).attr('id') ) {
        tabGroupName = '#' + $(this).attr('id');
      }
      else {
        $(this).attr('id', 'tabs-ui-tabs-' + i);
        tabGroupName = '#' + $(this).attr('id');
      }

      if ($(tabGroupName).has('li.ui-tabs-tab')) {
        tabsLength = $(tabGroupName + ' ul li.ui-tabs-tab').length;

        $(tabGroupName + ' ul li.ui-tabs-tab').each(function (tab) {
          tabWidth = (100 / tabsLength);
          $(this).css('width', tabWidth + '%');
        });

        // finds the largest height and creates tabs that are equal heights
        Array.max = function (array) {
          return Math.max.apply(Math, array);
        };
        Array.min = function (array) {
          return Math.min.apply(Math, array);
        };

        $(tabGroupName + ' ul li.ui-tabs-tab').each(function (tab) {
          tabHeights.push( $(this).height() );
          contentHeights.push( $(this).has('a').contents().height() );
        });

        tabHeight = Array.max(tabHeights);
        tabWidth = Array.max(tabWidths);
        maxHeight = Array.max(contentHeights);
        minHeight = Array.min(contentHeights);

        if (tabHeight < 32) {
          $(tabGroupName + ' ul li.ui-tabs-tab').css('height', '32px');
        }
        else {
          $(tabGroupName + ' ul li.ui-tabs-tab').css('height', Array.max(tabHeights) + 'px');
        }

        $(tabGroupName + ' a.ui-tabs-anchor').each(function (j) {
          var h;
          var p;
          h = contentHeights[j];
          p = (tabHeight - h) / 2;

          $(this).css({
            'padding-top': Math.round((tabHeight - h) / 2) + 'px',
            'height': 'inherit'
          });
        });
      }
    });

    if ($(window).width() < 476) {
      if ($('div[id^="tabs-"] ul.ui-tabs-nav li').length > 4) {
        $('div[id^="tabs-"]').addClass('vertical-tabs');
      }
      if ($(tabGroupName).hasClass('vertical-tabs')) {
        $('div.vertical-tabs ul.ui-tabs-nav li').removeAttr('style');
        $('div.vertical-tabs ul.ui-tabs-nav li a').removeAttr('style');
      }
    }
  }

  if ($('div[id^="tabs-"]').length > 0) {
    Drupal.behaviors.contentTabBox = {
      attach: function (context, settings) {
        $('div[id^="tabs-"]').tabs();
        // function to fix the alignment and padding
        $.fn.resetTabs = function () {
          // finds the largest height and creates tabs that are equal
          $('li.ui-tabs-tab').css('height', '');
          $('li.ui-tabs-tab').children().removeAttr('style');
        };
        setTabSize();
      }
    };
  }
  if ($('div.tabs').length > 0) {
    Drupal.behaviors.contentTabBox = {
      attach: function (context, settings) {
        $('div.tabs').tabs();
        // function to fix the alignment and padding
        $.fn.resetTabs = function () {
          // finds the largest height and creates tabs that are equal
          $('li.ui-tabs-tab').css('height', '');
          $('li.ui-tabs-tab').children().removeAttr('style');
        };
        setTabSize();
      }
    };
  }

  if ($('div[id^="accordion-"]').length > 0) {
    $('div[id^="accordion-"]').accordion({
      active: false,
      collapsible: true,
      heightStyle: 'content'
    });
  }
  if ($('.field_transcript').length > 0) {
    $('.field_transcript').accordion({
      active: false,
      collapsible: true
    });
  }
  // Page-Title H1 - checks to see if the page-title needs to split to 2 lines
  // function shortenPageTitle() {
  //   if ($(window).width() > 1024) {
  //     if ($('#page-title h1').innerWidth() > 600) {
  //       if ($('#page-title h1').children('span').length) {
  //         return;
  //       }

  //       $('#page-title h1').wrapInner('<span class="shorten-header clearfix"></span>');
  //     }
  //   }
  //   else {
  //     $('span.shorten-header').contents().unwrap();
  //   }
  // }

  // Gov Delivery
  Drupal.behaviors.govDeliveryBox = {
    attach: function (context, settings) {
      $('#gov-delivery-box').focus(function () {
        $('#subscribe-form .overlabel').hide();
      });
      $('#gov-delivery-box').click(function () {
        $('#subscribe-form .overlabel').hide();
      });
      $('#gov-delivery-box').blur(function () {
        if ($(this).val().length > 0) {
          $('#subscribe-form .overlabel').hide();
        }
        else {
          $('#subscribe-form .overlabel').show();
        }
      });
    }
  };

  $.fn.getQueryVariable = function () {
    var query = window.location.search.substring(1);
    var vars = query.split('&');
    var pair;
    var i = 0;
    var elem;
    if (vars.length > 0) {
      pair = vars[i].split('=');
      if (pair[0] == 'aId') {
        elem = pair[1];
      }
    }
    return elem;
  };
  // autofocus on page load
  $(window).on('load', function () {
    var q = $.fn.getQueryVariable();
    if (q) {
      $('#' + q).focus();
    }
  });

  // Custom backtoTop logic.

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


  // On document ready envoke our method;
  $(document).ready(function () {
    initBackTotop();
    // Detect select change for datatable front-end length change event.
    $('#datatable_length select').change(function () {
      initBackTotop();
    });

    $('#edit-items-per-page').change(function () {
      window.location.search = window.location.search + '&items_per_page=' + this.value;
    });

    if ($('body.node--type-link').length > 0) {
      var redirectTo = $('.field-link-title-url a').attr('href');
      window.location.replace(redirectTo);
    }
    var displayHelpBlocks = $('#videoplayer').length > 0 || $('.sample-player').length > 0 ? true : false;
    if (displayHelpBlocks) {
      $('#block-webcast-trouble,#block-flashsoftware').show();
    }
  });


  // iife to handle clickble table row in data-distribution table view;
  (function (selector) {
    $('.associated-data-distribution table tbody tr').each(function () {
      var href = $(selector, this).attr('href');
      var height = $(this).find('td').height();
      if (href) {
        var link = $('<a href="' + $(selector, this).attr('href') + '" download></a>').css({
          'text-decoration': 'none',
          'display': 'block',
          'color': $(this).css('color')
        });
        $(this).children().wrapInner(link);
      }
    });
  }('a:first'));


  // Begin logic for custom smooth scroll to an anchor.
  // Re-use this method for your own custom scroll to anchor needs. Just add generic css class e.g. 'scroll' in the anchor tag
  // and replace the selector e.g. $('.scroll');

  var hashTagActive = '';
  $('#sec-mission .hp-content a').on('click', function (e) {
    if ($(this).get(0).hash) {
      if (hashTagActive != this.hash) { // this will prevent if the user click several times the same link to freeze the scroll.
        e.preventDefault();
        // calculate destination place
        var dest = 0;
        if ($(this.hash).offset().top > $(document).height() - $(window).height()) {
          dest = $(document).height() - $(window).height();
        }
        else {
          dest = $(this.hash).offset().top;
        }
        // go to destination
        $('html,body').animate({
          scrollTop: dest
        }, 1000, 'swing');
        hashTagActive = this.hash;
      }
    }
  });

  // Submit handler for 'meeting category' select option;
  $(document.body).on('change', '#edit-field-meeting-category-value', function () {
    $(this).closest('form').submit();
  });

  // handle info links for webforms
  if ($('form.webform-submission-corp-fin-noaction-form, form.webform-submission-corp-fin-interpretive-form').length > 0) {
    var infoMap = {
      'Office of Chief Counsel': 'cfocc',
      'Office of Chief Accountant': 'cfdcao',
      'Office of Mergers and Acquisitions': 'oma',
      'Office of International Corporate Finance': 'oicf',
      'Office of Small Business Policy': 'osbp',
      'Office of Rulemaking': 'cfor',
      'Office of Capital Markets Trends': 'cfcmt',
      'Office of Structured Finance': 'cfsf',
      'Office of Enforcement Liaison': 'cfoel'
    };
    $('form.webform-submission-corp-fin-noaction-form .form-item-division-office-field').each(function () {
      var divisionOffice = $(this);
      divisionOffice.find('label').after("&nbsp;<a target='_blank' href='https://www.sec.gov/divisions/corpfin/cflegalregpolicy.htm#" + infoMap[divisionOffice.text().trim()] + "'>[info]</a>");
    });

    $('form.webform-submission-corp-fin-interpretive-form .form-item-division-office-to-receive-your-request-field').each(function () {
      var divisionOffice = $(this);
      divisionOffice.find('label').after("&nbsp;<a target='_blank' href='https://www.sec.gov/corpfin/Article/corp-fin-legal-policy-and-accounting-offices.html#" + infoMap[divisionOffice.text().trim()] + "'>[info]</a>");
    });
  }

  // Custom Accordion Panel Expander
  $('#accordion li').on('click', function () {
    $(this).find('div').slideToggle(100);
    $(this).find('.expander-icon').toggleClass('minus');
    $(this).find('.expander-icon').text('[+]');
    $(this).find('.expander-icon.minus').text('[-]');
  });

  // Public Comments Submit Script
  $('.submitcommentslink').click(function (e) {
    e.preventDefault();
    $('.comment-form').submit();
  });

  // Email Subscribe Box Script
  $('#email').on('blur', function (e) {
    if ($(this).val() == '') {
      $(this).val('Email address');
      $(this).css({'color': '#b1b1b1'});
    }
    else if ($(this).val() != '') {
      $(this).css({'color': '#000'});
    }
  });
  $('#email').on('focus', function (e) {
    if ($(this).val() == 'Email address') {
      $(this).val('');
      $(this).css({'color': '#000'});
    }
  });
})(jQuery);
