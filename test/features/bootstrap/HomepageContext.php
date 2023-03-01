<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\SnippetAcceptingContext;
use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\MinkExtension\Context\RawMinkContext;


/**
 * Defines application features from the specific context.
 */
class HomepageContext extends RawDrupalContext implements Context, SnippetAcceptingContext
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * @Then I should see :arg1 nodes in the :arg2 block
     */
    public function iShouldSeeNodesInTheBlock($arg1, $arg2)
    {
      $blockName = strtolower(str_replace(' ', '_', $arg2));
      if ($arg2 == 'SEC Stories') {
        $nodeSelector = '.homepage_featured_stories-' . $blockName . ' .sec-stories-col';
      }
      else {
        $nodeSelector = '.homepage_featured_content-' . $blockName . ' .views-row';
      }
      $page = $this->getSession()->getPage();
      $count = sizeof($page->findAll('css', $nodeSelector));
      if ($count < $arg1) {
        throw new Exception('Not enough nodes (' . $count . ') in ' . $arg2 . ' block');
      }
      elseif ($count > $arg1) {
        throw new Exception('Too many nodes (' . $count . ') in ' . $arg2 . ' block');
      }
    }

}
