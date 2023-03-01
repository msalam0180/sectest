import jQuery from 'jquery';
import Drupal from 'drupal';
import once from 'once';

/**
 * @file
 * Dropbutton feature.
 */

(function initShowHide($) {
  
  function showHideItem(e) {
    const $thisBtn = $(e.target);
    const isExpanded = $thisBtn.attr('aria-expanded');
    const thisID = $thisBtn.attr('aria-controls');
    const $thisContent = $(`[id=${  thisID  }]`);

    // eslint-disable-next-line eqeqeq
    if(isExpanded == 'true'){
      $thisBtn.attr('aria-expanded', false);
      $thisContent.attr('hidden', true);
    }else{
      $thisBtn.attr('aria-expanded', true);
      $thisContent.attr('hidden', false);
    }
  }

  function setDefaultShowHideItem($showHideBtn) {
    const $thisBtn = $showHideBtn;
    const isExpanded = $thisBtn.attr('aria-expanded');
    const thisID = $thisBtn.attr('aria-controls');
    const $thisContent = $(`[id=${  thisID  }]`);

    // eslint-disable-next-line eqeqeq
    if(isExpanded == 'true'){
      $thisContent.attr('hidden', false);
    }else{
      $thisContent.attr('hidden', true);
    }
  }

  Drupal.behaviors.showHide = {
    // eslint-disable-next-line no-unused-vars
    attach(context, settings) {

      once('showHideClick', 'body', context).forEach(bodyElem => {
        const $body = $(bodyElem);
        if ($body.length) {
          $body.on('click', '[data-showHideBtn]', showHideItem);

          const $showHideBtn = $('[data-showHideBtn]');
          // eslint-disable-next-line func-names
          $showHideBtn.each(function() {
            setDefaultShowHideItem($( this ));
          });

        }
      });

    },
  };
})(jQuery);
