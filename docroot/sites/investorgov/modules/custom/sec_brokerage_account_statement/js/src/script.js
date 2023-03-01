(function ($, window, document, undefined) {

  var explainer = {
    closeInfo: '',
    currentSection: 1,
    objInfo: ''
  };


  var resizeExplainer = function() {
    $('.brokerage_account_section').each(function() {
      if($(this).data('index') === explainer.currentSection) {
        $('.content-container').height($(this).height() + 100);

        // Code to make 'Important' box stick to bottom of page on mobile
        var contentContainerHeight = $('.content-container').height($(this).height() + 100).outerHeight();
        var activeSectionHeight = $(this).outerHeight();
        var importantOffset = contentContainerHeight - activeSectionHeight;
        if ( $(window).width() < 600 ) {
          $('.important-info').css( {bottom: 0 - importantOffset} );
        } else {
          $('.important-info').css( {bottom: 0} );
        }

        // Resize 'Important Box' on mobile so it does not overlap content
        if ( $(window).width() < 600 ) {
          $('.important-info').css({width: '66%', left: '17%', marginLeft: '0'});
        } else {
          $('.important-info').css({width: '', left: '', marginLeft: ''});
        }

      }
    });
  }

  $('.clickable').unbind().on('click', function() {
    if($(window).width() > 600 ) {

      // Code to display correct infobox content if a '.clickable-container' has more than one <article> descendent.
      if ($(this).siblings().length > 0) {
        $('.information .infobox').html($(this).siblings().first().html());
      } else {
        $('.information .infobox').html($(this).closest(".clickable-container").find("article.info").first().html());
      }

      var pos = $(this).closest('.clickable-container').position();
      var posLeft = pos.left;
      // Top position to align top of clickable container and information box
      var posTop = pos.top;
      var clickableContainerHeight = $(this).closest('.clickable-container').outerHeight();
      var posBot = posTop + clickableContainerHeight;

      var activeInfoHeight = $('.information').outerHeight();
      // Top position to align bottom of clickable container and information box
      var activeInfoTopPos = posBot - activeInfoHeight; console.log(activeInfoHeight);

      if($(this).hasClass('topRight')) {
        $('.information').addClass('topRight').css({top: posTop});
      } else if($(this).hasClass('topLeft')) {
        $('.information').addClass('topLeft').css({top: posTop});
      } else if($(this).hasClass('mid')) {
        $('.information').addClass('mid').css({left: posLeft, marginLeft: "-23.5%"});
      } else if($(this).hasClass('midRight')) {
        $('.information').addClass('midRight').css({top: posBot + 15});
      } else if($(this).hasClass('bottomRight')) {
        $('.information').addClass('bottomRight').css({top: activeInfoTopPos});
      } else if($(this).hasClass('bottomLeft')) {
        $('.information').addClass('bottomLeft').css({top: activeInfoTopPos});
      }
      $('.info-overlay').addClass('active-info');
      if(!$(this).closest('.clickable-container').hasClass('active')) {
        $('.clickable').each(function() {
          $(this).closest('.clickable-container').removeClass('active');
        });
        if ($(this).closest('.clickable-container').hasClass('t_row')) {
          $(this).closest('.brokerage_info-container').addClass('active inactive-table');
        }
        $(this).closest('.clickable-container').addClass('active');
      }
      $('.clickable, .section-selector li a').addClass('disabled');
      setTimeout(function() {
        $('.information').addClass('active-info');
      }, 200);
    } else {
      if(!$(this).closest('.clickable-container').hasClass('active')) {
        $('.clickable').each(function() {
          $(this).closest('.clickable-container').removeClass('active');
        });
        if ($(this).siblings().length > 0) {
          $(this).closest('.clickable-container').addClass('active');
          $(this).siblings().first().removeClass('element-invisible');
        } else {
          $(this).closest('.clickable-container').addClass('active');
          $(this).closest('.clickable-container').find('.info').first().removeClass('element-invisible');
        }
        var articleInfoHeight = $(this).closest('.clickable-container').find('article.info').first().outerHeight();
        var articleInfoHeight2 = $(this).siblings().first().outerHeight();
        if ( !$(this).closest('.clickable-container').hasClass('important-info') ) {
          if($(this).siblings().length > 0) {
            $('.content-container').height($('.content-container').height() + articleInfoHeight2);
          } else {
            $('.content-container').height($('.content-container').height() + articleInfoHeight);
          }
        }
      } else {
        var articleInfoHeight = $(this).closest('.clickable-container').find('article.info').first().outerHeight();
        var articleInfoHeight2 = $(this).siblings().first().outerHeight();
        if ( !$(this).closest('.clickable-container').hasClass('important-info') && $(this).closest('.clickable-container').hasClass('active')) {
          if($(this).siblings().length > 0) {
            $('.content-container').height($('.content-container').height() - articleInfoHeight2);
          } else {
            $('.content-container').height($('.content-container').height() - articleInfoHeight);
          }
        }
        if ($(this).siblings().length > 0) {
          $(this).siblings().first().addClass('element-invisible');
          $(this).closest('.clickable-container').removeClass('active');
        } else {
          $(this).closest('.clickable-container').find('.info').first().addClass('element-invisible');
          $(this).closest('.clickable-container').removeClass('active');
        }
      }
    }
  });

  var infoBoxClose = function() {
    $('.clickable-container').each(function(){
      if($(this).hasClass('active')) {
        $(this).removeClass('active');
      }
    });
    $('.brokerage_info-container').each(function(){
      if($(this).hasClass('active inactive-table')) {
        $(this).removeClass('active inactive-table');
      }
    });
    $('.information, .info-overlay').removeClass('active-info');
    setTimeout(function() {
      $('.information').removeClass('bottomLeft bottomRight midRight mid topLeft topRight').css({top: '', left: '', marginLeft: ''});
      $('.clickable, .section-selector li a').removeClass('disabled');
    }, 300);
  }

  $('.information .close-btn').on('click', infoBoxClose);

  //ANIMATES SECTIONS
  var moveSection = function($sectionIndex, $thisSection) {
    var $currentActive = $('.brokerage_account_section.active-section');
    if($sectionIndex > $currentActive.data('index')) {
      if(!$thisSection.hasClass('inactive-right')) {
        $thisSection.addClass('inactive-right');
        $thisSection.removeClass('inactive-left')
      }
      $thisSection.removeClass('inactive-right').addClass('active-section animate');
      setTimeout(function() {
        $thisSection.removeClass('animate');
        $currentActive.removeClass('active-section').addClass('inactive-left');
      }, 1500);
      explainer.currentActive = $sectionIndex;
    } else {
      if(!$thisSection.hasClass('inactive-left')) {
        $thisSection.addClass('inactive-left');
        $thisSection.removeClass('inactive-right');
      }
      $thisSection.removeClass('inactive-left').addClass('active-section');
      $currentActive.removeClass('active-section').addClass('inactive-right animate');
      setTimeout(function() {
        $currentActive.removeClass('animate');
      }, 1500);
    }
    explainer.currentSection = Number($sectionIndex);
    $('.section-selector a').each(function() {
      if($(this).data('page') === explainer.currentSection) {
        $(this).addClass('current');
      } else {
        $(this).removeClass('current');
        setTimeout(function() {
          $currentActive.removeClass('animate');
        }, 1500);
      }
    })
    resizeExplainer();
  };

  $('.section-selector li a').on('click', function(e) {
    
    var $selectorOption = $(this).data('page'),
    $sectionIndex,
    $thisSection,
    $sectionIndex;
    if(typeof $selectorOption === 'number') {
      $('.brokerage_account_section').each(function(){
        if($selectorOption == $(this).data('index')) {
          $sectionIndex = $(this).data('index');
          $thisSection= $(this);
          $('.information, .info-overlay').removeClass('active-info');
          $('.clickable').closest('div').removeClass('active');
          moveSection($sectionIndex, $thisSection);
        }
      });
    } else if($selectorOption === 'next') {
      var $nextSection = explainer.currentSection + 1;
      $('.brokerage_account_section').each(function(){
        if($(this).data('index') === $nextSection) {
          $sectionIndex = $nextSection.toString();
          $thisSection = $(this);
          moveSection($sectionIndex, $thisSection);
        }
      });
    } else if($selectorOption === 'prev') {
      var $prevSection = explainer.currentSection - 1;
      $('.brokerage_account_section').each(function(){
        if($(this).data('index') === $prevSection) {
          $sectionIndex = $prevSection.toString();
          $thisSection = $(this);
          moveSection($sectionIndex, $thisSection);
        }
      });
    }
  });

  var $mobilize = function(){
    resizeExplainer();
  };

  var $unmobilize = function(){
    resizeExplainer();
    $('.clickable-container').each(function() {
      if(!$(this).find('.info').hasClass('element-invisible')) {
        $(this).find('.info').addClass('element-invisible');
      }
      if($(this).find('h2').hasClass('active')){
        $(this).find('h2').removeClass('active');
      }
    });
  };



  $(document).ready(function(){
    resizeExplainer();
  });

  $(document).click(function(event) {
    if(!$(event.target).closest('.information').length) {
      if($('.information').hasClass('active-info')) {
          infoBoxClose();
      }
    }
  });
  $(window).on('resize', function(){
    if($(window).width() > 600 ) {
      $unmobilize();

    } else {
      $mobilize();

    }
  });


})(jQuery, this, this.document);
