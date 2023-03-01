<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\MinkExtension\Context\RawMinkContext;
use Drupal\DrupalExtension\Hook\Scope\EntityScope;
use Behat\Mink\Extension\ElementNotFoundException;
use Behat\Behat\Hook\Scope\BeforeFeatureScope;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;
use Behat\Mink\Mink;


/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements Context, SnippetAcceptingContext
{
    /** @var \Behat\MinkExtension\Context\MinkContext */
    private $minkContext;

    /**
     * @BeforeScenario
     */
    public function gatherContexts(BeforeScenarioScope $scope)
    {
      $environment = $scope->getEnvironment();
      $this->minkContext = $environment->getContext('Drupal\DrupalExtension\Context\MinkContext');
    }


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
     * remove all content type nodes which have list page testing
     * before running suite to allow list page tests to run
     * @BeforeSuite
     */
    public static function removeData(BeforeSuiteScope $scope)
    {
        // Allow tester to bypass content deletion. This comes in handy when testing specific features or scenarios.
        // Tester can supply 'nodelete' after value provided for the name, tags, or role option.
        // Example: bin/behat --tags eventsandwebcasts,nodelete
        $deleteContent = true;
        try {
          $filterString = $GLOBALS['argv'][2];
          if (strpos($filterString, 'nodelete') !== false) {
            $deleteContent = false;
          }
        }
        catch (Exception $e) {
          $deleteContent = true;
        }
        $types = array('secarticle', 'ba', 'news', 'webcast', 'event', 'sec_alert', 'sec_hero', 'data_distribution', 'data_visualization', 'video', 'image', 'file', 'featured', 'release');
        if ($deleteContent) {
          do {
            $db = \Drupal::database();
            $nids_query = $db->select('node', 'n')
              ->fields('n', array('nid'))
              ->condition('n.type', $types, 'IN')
              ->range(0, 200)
              ->execute();

            $nids = $nids_query->fetchCol();

            $nodeStorage = \Drupal::service('entity_type.manager')->getStorage('node');

            foreach ((array) $nids as $nid) {
              $node = $nodeStorage->load($nid);
              $nodeStorage->delete([$node]);
            }

          } while (!empty($nids));
        }

        // Delete most link content so that topical reference page loads locally
        do {
          $db = \Drupal::database();
          $query = $db->select('node', 'n')
            ->fields('n', array('nid'))
            ->condition('n.type', 'link')
            ->range(100, 200)
            ->execute();

          $nids = $query->fetchCol();

          $nodeStorage = \Drupal::service('entity_type.manager')->getStorage('node');

          foreach ((array) $nids as $nid) {
            $node = $nodeStorage->load($nid);
            $nodeStorage->delete([$node]);
          }

        } while (!empty($nids));

        // Remove the following webforms
        $webform_ids = array('testing_ticket_14445');
        if (\Drupal::database()->schema()->tableExists('webform')) {
          $webformStorage = \Drupal::service('entity_type.manager')->getStorage('webform');
          foreach ($webform_ids as $id) {
            if ($webform = $webformStorage->load($id)) {
              $webformStorage->delete([$webform]);
            }
          }
        }
    }

    /**
     *
     * Webcast site alerts steps will fail if Twig debug is enabled locally.
     *
     * @BeforeFeature @eventsandwebcasts
     *
     */
    public static function beforeFeature(BeforeFeatureScope $scope)
    {
      $driver = new \Behat\Mink\Driver\GoutteDriver();
      $session = new \Behat\Mink\Session($driver);
      $session->start();
      $session->visit($GLOBALS['base_url']);
      $page = $session->getPage();
      if (sizeof($page->findAll('xpath', '//*[contains(comment(), \'THEME DEBUG\')]')) > 0) {
        throw new \Exception('Twig debug is enabled. Disable this in development.services.yml and clear Drupal cache prior to running eventsandwebcasts.features.');
      }
    }

    /**
  * remove all media which have list page testing
  * before running suite to allow list page tests to run
  * @BeforeSuite
  */
  public static function removeMediaData(BeforeSuiteScope $scope)
  {
      $db_conn = \Drupal::database();
      // Allow tester to bypass media deletion. This comes in handy when testing specific features or scenarios.
      // Tester can supply 'nodelete' after value provided for the name, tags, or role option.
      // Example: bin/behat --tags eventsandwebcasts,nodelete
      $deleteContent = true;
      try {
        $filterString = $GLOBALS['argv'][2];
        if (strpos($filterString, 'nodelete') !== false) {
          $deleteContent = false;
        }
      }
      catch (Exception $e) {
        $deleteContent = true;
      }
      $types = array('static_file','image_media','video_media','file','image','video','audio');
      if ($deleteContent && $db_conn->schema()->tableExists('media')) {
        do {
          $mids_query = $db_conn->select('media', 'm')
            ->fields('m', array('mid'))
            ->condition('m.bundle', $types, 'IN')
            ->range(0, 200)
            ->execute();

          $mids = $mids_query->fetchCol();

          $mediaStorage = \Drupal::service('entity_type.manager')->getStorage('media');

          foreach ((array) $mids as $mid) {
            $mediaItem = $mediaStorage->load($mid);
            $mediaStorage->delete([$mediaItem]);
          }
        } while (!empty($mids));
      }
  }

  /**
   * Delete all files before each scenario so that duplicates are not created
   * @BeforeScenario
   */
  public static function removeStaticFiles(BeforeScenarioScope  $scope) {
    do {
      $database = \Drupal::database();
      $query = $database->select('file_managed', 'fm');
      $query->join('file_usage', 'fu', 'fm.fid = fu.fid');
      // Only delete file if its part of node and media entities
      $orGroup = $query->orConditionGroup()
        ->condition('fu.type', 'node', '=')
        ->condition('fu.type', 'media', '=');
      $andGroup = $query->andConditionGroup()
        ->condition($orGroup)
        ->condition('fm.status', 1, '=');
      $query->condition($andGroup);
      $query->fields('fm', ['fid', 'uri']);
      $query->fields('fu', ['type']);
      $query->range(0, 500);
      $result = $query->execute();
      $fids = [];
      foreach ($result as $file) {
        $fids[$file->fid] = $file->fid;
      }
      $files = \Drupal::service('entity_type.manager')->getStorage('file')->loadMultiple($fids);
      \Drupal::service('entity_type.manager')->getStorage('file')->delete($files);
    } while (!empty($fids));
  }

    /**
     * Call this function before nodes are created.
     *
     * @beforeNodeCreate
     */
    public function alterNodeObject(EntityScope $scope) {
      $node = $scope->getEntity();
      if (isset($node->field_start_date)) {
        $date = new DateTime($node->field_start_date);
        $node->field_start_date = $date->format('Y-m-d H:i:s');
      }

      if (isset($node->field_end_date)) {
        $date = new DateTime($node->field_end_date);
        $node->field_end_date = $date->format('Y-m-d H:i:s');
      }

      if (isset($node->field_sec_event_date)) {
        $date = new DateTime($node->field_sec_event_date);
        $node->field_sec_event_date = $date->format('Y-m-d H:i:s');
      }

      if (isset($node->field_sec_event_end_date)) {
        $date = new DateTime($node->field_sec_event_end_date);
        $node->field_sec_event_end_date = $date->format('Y-m-d H:i:s');
      }

    }

    /**
     *
     * To be called after webcast alert scenarios. Because the sec alert nodes
     * are created programmatically in these scenarios, they need to be deleted
     * programmatically.
     *
     * @AfterScenario @webcastalert
     */
    public function afterWebcastAlert($event)
    {
      $db_conn = \Drupal::database();
      $sql = <<<SQL
      SELECT nid
        FROM node_field_data
       WHERE type = 'sec_alert'
SQL;
      $query = $db_conn->query($sql);
      $results = $query->fetchAll();
      foreach( $results as $row) {
        $node = \Drupal::service('entity_type.manager')
          ->getStorage('node')
          ->load($row->nid);
        $node->delete();
      }
    }

	/**
     * @Given I am on page :arg1
     */
    public function iAmOnPage($page)
    {
        $this->visitPath($page);
    }


    /**
     * @Then I should see the logo :arg1 in the header
     */
    public function iShouldSeeTheLogoInTheHeader($arg1)
    {
      throw new PendingException();
    }



    /**
     * @Then I should see the latest press releases in the :arg1 region
     */
    public function iShouldSeeTheLatestPressReleasesInTheRegion($arg1)
    {
      var_export($this);
      throw new PendingException();
    }

    /**
     * @Then I should see the last :arg1 Press Releases in the latest region
     */
    public function iShouldSeeTheLastPressReleasesInTheLatestRegion($arg1)
    {
      $latest = $this->getSession()->getPage()->findAll('css', '.newsroom-latest-pr .item-list ul li');
  		$count = 0;

  		foreach ($latest as $row) {
  			$count++;
  		}
  		if ( $count == 5 ){
  			return;
  		}

  		else {
  			throw new \Exception(
  			sprintf("Expected latest pr - %s not found on page %s",
  				$arg1,
  				$this->getSession()->getCurrentUrl())
  			);
  		}
    }


    /**
     * @Then I should see the menu :arg1 in the :arg2 region
     */
    public function iShouldSeeTheMenuInTheRegion($arg1, $arg2)
    {
        /*left nav mapping for list pages */
        $navmenu = (array("Newsroom"=>"#block-newsroomleftnav", "Speech"=>"#block-newsroomleftnav", "Fast Answers"=>"#block-investorinformationmenu-menu","Forms"=>"#block-filingsmenu",
		  "Data"=>"#block-about", "Investor Alerts"=>"#block-investorinformationmenu", "Reports"=>"#block-about"));

		$listnav = $this->getSession()->getPage()->find('css', 'nav');

		if (array_key_exists($arg1, $navmenu)){

			if ($listnav->findAll('css', $navmenu[$arg1])){
			  return;
			}

		}

		else {
			throw new \Exception(
			sprintf("Expected %s menu not found on page %s",
				$arg1,
				$this->getSession()->getCurrentUrl())
			);
		}
    }

    /**
     * Click on the element with the provided CSS Selector
     *
     * @Then /^I click on the element with css selector "([^"]*)"$/
     */
    public function iClickOnTheElementWithCSSSelector($cssSelector)
    {
        $element = $this->getSession()->getPage()->find("css", $cssSelector);
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $cssSelector));
        }

        $element->click();

    }
    /**
     * @Given /^I wait (\d+) seconds$/
     */
    public function iWaitSeconds($seconds)
    {
        sleep($seconds);
    }

    /**
    * Input and select into an autocomplete field
    * @When I select the first autocomplete option for :text on the :autocomplete field
    */
    public function iSelectTheFirstAutocompleteOptionForTextOnTheAutocompleteField($autocomplete, $text)
    {
      $session = $this->getSession();
      $driver = $session->getDriver();
      $field = $this->getSession()->getPage()->findField($autocomplete);
      $field->focus();

      $this->scrollIntoView("#" . $field->getAttribute("id"));

      // Set the autocomplete text then put a space at the end which triggers
      // the JS to go do the autocomplete stuff.
      $field->setValue($text);
      $xpath = $field->getXpath();
      $driver->keyDown($xpath, 40);
      $driver->keyUp($xpath, 40);

      // Wait for AJAX to finish.
      $this->minkContext->iWaitForAjaxToFinish();

      $result = $this->getSession()->getPage()->find("xpath", "//ul[not(contains(@style,'display: none'))]/li[@class='ui-menu-item']/a");
      if (empty($result)) {
         throw new \Exception("Autocomplete result not found");
      } else {
        $result->click();
      }
    }

    /**
     * @Then I click :buttonName on the modal :title
     */
    public function iClickButtonOnTheModal($buttonName, $title)
    {
        $modals = $this->getSession()->getPage()->findAll('css', '.ui-dialog');
        if (!empty($modals)) {
          foreach ($modals as $modal) {
            $modalTitle = $modal->find("css", ".ui-dialog-title");
            if ($modal && $modal && $modal->isVisible() && trim($modalTitle->getText()) === $title) {

              //now find the button
              $buttons = $modal->findAll("css", ".button");
              if (!empty($buttons)) {
                foreach ($buttons as $button) {
                  if ($button && $button->isVisible() && trim($button->getText()) === $buttonName) {
                    $button->click();
                  }
                }
              }
            }
          }
        }
    }

    /**
     * @Given I scroll to the bottom
     */
    public function iScrollToThe()
    {
    	$this->getSession()->wait(500,' window.scrollTo(0, document.body.scrollHeight) ');
    }


	/**
	* @Then I play the video
	*/
	public function iPlayTheVideo() {
		sleep(1);
		$isPlaying= $this->getSession()->getPage()->find('css','.akamai-playing, .vjs-playing');
		if (!$isPlaying) {
			$video = $this->getSession()->getPage()->find('css', '.akamai-video, .limelight-player');
			if ($video && $video->isVisible()) {
				$playButton = $this->getSession()->getPage()->find('css', '.vjs-play-control,.akamai-play-pause');
				if ($playButton && $playButton->isVisible()) {
					$playButton->click();
				} else {
					$video->click();
				}
			}


		}

	}
	/**
     * @Then I should see a video player
     */
    public function iShouldSeeAVideoPlayer()
    {
      sleep(9);

      $video = $this->getSession()->getPage()->find('css', '#akamai-media-player, .limelight-player');
      if ($video && $video->isVisible()) {
        return;
      }

      throw new \Exception(sprintf("video player not found"));
    }

    /**
     * @Then I should not see a video player
     */
    public function iShouldNotSeeAVideoPlayer()
    {
      sleep(9);

      $video = $this->assertSession()->elementNotExists('css', '#akamai-media-player, .limelight-player');
      if (!$video) {
        return;
      }

      throw new \Exception(sprintf("video player found"));
    }

    /**
     * @Then I wait for the page to be loaded
     */
    public function iWaitForThePageToBeLoaded()
    {
    	$this->getSession()->wait(10000, "document.readyState === 'complete'");
    }

    /**
     * @Then I should see the video playing
     */
    public function iShouldSeeTheVideoPlaying()
    {
    	$video = $this->getSession()->getPage()->find('css', '.vjs-playing, .akamai-playing');
    	if ($video && $video->isVisible()) {
    		return;
    	}

    	throw new \Exception(sprintf("video player not found"));
    }


    /**
     * @Then /^I should see the modal "([^"]*)"$/
     */
    public function iShouldSeeTheModal($title)
    {
      $this->getSession()->wait(20000, '(0 === jQuery.active && 0 === jQuery(\':animated\').length)');
      $modal = $this->getSession()->getPage()->find('css', '.ui-dialog-title');
      if ($modal && $modal->isVisible() && trim($modal->getText()) === $title) {
        return;
      }

      throw new \Exception(sprintf("Modal %s not found", $title));
    }

    /**
   * A function that will allow users to set an option in the drop down publish
   * button on a node create/edit page. Searches by the value of the input.
   *
   * @Given I click the input with the value :arg1
   */
    public function iClickTheInputWithTheValue($arg1)
    {
      $xpath = '//input[@value="' . $arg1 . '"]';
      $pubButton = $this->getSession()->getPage()->findAll('xpath', $xpath);
      if ($pubButton != null){
        $pubButton[0]->click();
        return;
      } else {
        throw new \Exception(
          sprintf("Expected %s option not found on node", $arg1)
        );
      }
    }

    /**
    * @Given I publish it
    */
    public function iPublishIt() {
	    //publishing status checkbox is hidden unless moderation is not available
      if(empty($this->assertSession()->elementExists('css', '.moderation-state-published'))) {
        $this->getSession()->getPage()->checkField('edit-status-value');
      }

      try {
        $this->getSession()->getPage()->pressButton('List additional actions');
        //check upper and lower case p
  	    try {
          $this->iClickTheInputWithTheValue("Save and publish");
        } catch (Exception $e) {
          $this->iClickTheInputWithTheValue("Save and Publish");
        }
      } catch  (Exception $f)  {
        //If list addtional actions cannot be clicked
        try {
      	  $this->iClickTheInputWithTheValue("Save and publish");
        } catch (Exception $g) {
          $this->iClickTheInputWithTheValue("Save and Publish");
        }
      } finally {
        try {
          $this->confirmPopup();
          $this->minkContext->iWaitForAjaxToFinish();
        }
        catch (Exception $e) {
          // popup not present - this is ok
        }
      }
    }

    /**
    * @when /^(?:|I )confirm the popup$/
    * If you have a popup you MUST use the @javascript tag to run the test
    */
    public function confirmPopup()
    {
      $driver = $this->getSession()->getDriver();
      if ($driver instanceof Behat\Mink\Driver\Selenium2Driver) {
        $this->getSession()->getDriver()->getWebDriverSession()->accept_alert();
      }
    }

    /**
     * This depends on W3Cs online validator, if you can't reach the internet or they change it
     * this will break
     *
     * @Then I should see valid XML
     */
    public function iShouldSeeValidXml()
    {
    	$feed = $this->getSession()->getDriver()->getHtml('//body/pre');
    	$feed = htmlspecialchars_decode($feed);
      $url = 'https://validator.w3.org/feed/check.cgi';
      $data = array('rawdata' => $feed, 'manual' => 1);
      $options = array(
              'http' => array(
              'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
              'method'  => 'POST',
              'content' => http_build_query($data),
              'ssl' => array(
                  'verify_peer' => false,
                  'verify_peer_name' => false
              )
          )
      );
      $context  = stream_context_create($options);
      $result = file_get_contents($url, false, $context);
      if (stristr($result , 'Congratulations') !== false) {
        return;
      } else {
        throw new \Exception("Feed is not valid XML");
      }
    }

    /**
    * @Transform mytime :days
    **/
    public function castDateTime($days) {
      $timestamp = new DateTime($days);
      throw new \Exception($timestamp);
    }

    /**
  * @When I scroll :selector into view
  *
  * @param string $selector Allowed selectors: #id, .className, //xpath
  *
  * @throws \Exception
  */
 public function scrollIntoView($selector)
 {
     $locator = substr($selector, 0, 1);

     switch ($locator) {
         case '/' : // XPath selector
             $function = <<<JS
(function(){
var elem = document.evaluate("$selector", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
elem.scrollIntoView({block:"center"});
})()
JS;
             break;

         case '#' : // ID selector
             $selector = substr($selector, 1);
             $function = <<<JS
(function(){
var elem = document.getElementById("$selector");
elem.scrollIntoView({block:"center"});
})()
JS;
             break;

         case '.' : // Class selector
             $selector = substr($selector, 1);
             $function = <<<JS
(function(){
var elem = document.getElementsByClassName("$selector");
elem[0].scrollIntoView({block:"center"});
})()
JS;
             break;
         default:
             throw new \Exception(__METHOD__ . ' Couldn\'t find selector: ' . $selector . ' - Allowed selectors: #id, .className, //xpath');
             break;
     }

     try {
         $this->getSession()->executeScript($function);
     } catch (Exception $e) {
         throw new \Exception(__METHOD__ . ' failed');
     }
   }

    /**
     * @Then I should see the link :first_link before I see the link :second_link in the :view view
     */
    public function iShouldSeeTheLinkBeforeISeeTheLinkInTheView($first_link, $second_link, $view)
    {
      $page = $this->getSession()->getPage();
      $selector = '.view-' . strtolower(str_replace(' ', '-', $view));
      // First, find the view; if it doesn't exist, the scenario fails
      $v = $page->find('css', $selector);
      if (empty($v)) {
        throw new Exception("The view " . $view . " was not found.");
      }
      // use xpath selector with or since view rows can be identified in a variety of ways
      $rows = $v->findAll('xpath', '//tr[@role="row"] | //table[contains(concat(" ", @class, " "), "list")]/tbody/tr | //*[contains(concat(" ", @class, " "), " view-row")] | //div[contains(concat(" ", @class, " "), " item-list")]/ul/li');
      $foundFirst = false;
      $foundinOrder = false;
      // Iterate over the rows of the view
      foreach ($rows as $row) {
        if (!empty($row->findLink($first_link))) {
          $foundFirst = true;
        }
        elseif ($foundFirst && !empty($row->findLink($second_link))) {
          $foundinOrder = true;
          break;
        }
      }
      if (!$foundinOrder) {
        throw new Exception("The link " . $first_link . " was not found before the link " . $second_link);
      }
    }

    /**
     * @Then I should see the field :field
     */
    public function iShouldSeeTheField($field)
    {
        $page = $this->getSession()->getPage();
        // Get the label first
        $id = "edit-field-" . strtolower(str_replace(' ', '-', $field)) . '-wrapper';
        $label = $page->find('xpath', '//*[@id="' . $id . '"]/div/label');
        // nab the id selector for the field from the 'for' attribute of the label
        $f = $page->find('xpath', '//*[@id="' . $label->getAttribute('for') . '"]');
        if (empty($f) || !$f->isVisible()) {
          throw new Exception("The field " . $field . " is not visible.");
        }
    }

    /**
     * @When I fill in :date_field with the date :date_value
     */
    public function iFillInWithTheDate($date_field, $date_value)
    {
        $page = $this->getSession()->getPage();

        $date = DateTime::createFromFormat('Y-m-d H:i:s', $date_value);

        // Get the fieldset for the date field named in arg1
        $fs = $page->find('named', array('fieldset', $date_field));
        if (empty($fs)) {
          throw new Exception(sprintf("The date field %s is not available.", $date_field));
        }

        // Get the input for date part
        $dateInput = $fs->find('css', '#' . $fs->getAttribute('id') . '-value-date');
        if (empty($dateInput)) {
          throw new Exception(sprintf("The date field %s is not available.", $date_field));
        }

        $dateInput->setValue(date_format($date, 'Y-m-d'));

        // Get the input for time part
        $timeInput = $fs->find('css', '#' . $fs->getAttribute('id') . '-value-time');
        if (!empty($dateInput)) {
          $timeInput->setValue(date_format($date, 'H:i:s'));
        }
    }

    /**
     * @Then I should see the :block block in the :region region
     */
    public function iShouldSeeTheBlockInTheRegion($block, $region)
    {
      $session = $this->getSession();
      $page = $session->getPage();
      $regionNode = $page->find('region', $region);
      if (!$regionNode) {
        throw new Exception(sprintf('No region "%s" found on the page %s.', $region, $session->getCurrentUrl()));
      }

      $class = strtolower(str_replace([':', ' '], '-', $block));
      $blockNode = $regionNode->find('css', '.' . $class);
      if (!$blockNode) {
        // Try something a little different
        $class = strtolower(str_replace(' ', '_', str_replace(': ', '-', $block)));
        $blockNode = $regionNode->find('css', '.' . $class);
        if (!$blockNode) {
          throw new Exception(sprintf('The block %s not found in region %s on page %s.', $block, $region, $session->getCurrentUrl()));
        }
      }
    }

    /**
     * @Then I should see the statistics guide titled :title
     */
    public function iShouldSeeTheStatisticsGuideTitled($title)
    {
      $page = $this->getSession()->getPage();
      $headers = $page->findAll('css', 'h3.ui-accordion-header');
      $found = false;
      foreach($headers as $h) {
        if ($h->getText() == $title) {
          $found = true;
          break;
        }
      }
      if (!$found) {
        throw new Exception(sprintf('The statistics guide %s was not found on page %s', $title, $this->getSession()->getCurrentUrl()));
      }
    }

    /**
     * @Then I should see the text :first_text before I see the text :second_text in the :view view
     */
    public function iShouldSeeTheTextBeforeISeeTheTextInTheView($first_text, $second_text, $view)
    {
      $page = $this->getSession()->getPage();
      $selector = '.view-' . strtolower(str_replace(' ', '-', $view));
      // First, find the view; if it doesn't exist, the scenario fails
      $v = $page->find('css', $selector);
      if (empty($v)) {
        throw new Exception("The view " . $view . " was not found.");
      }
      $rows = $v->findAll('xpath', '//tr[@role="row"] | //h3[contains(concat(" ", @class, " "), " ui-accordion-header ")] | //div[contains(concat(" ", @class, " "), " item-list")]/ul/li');
      $foundFirst = false;
      $foundinOrder = false;
      // Iterate over the rows of the view
      foreach ($rows as $row) {
        if ($row->has('named', array('content', $first_text))) {
          $foundFirst = true;
        }
        elseif ($foundFirst && $row->has('named', array('content', $second_text))) {
          $foundinOrder = true;
          break;
        }
      }
      if (!$foundinOrder) {
        throw new Exception(sprintf("The text %s was not found before the text %s in view %s.", $first_text, $second_text, $view));
      }
    }

    /**
     * @When I visit :url for term :term from taxonomy :taxonomy
     */
    public function iVisitForTermFromTaxonomy($url, $term, $taxonomy)
    {
      $tid = _sec_taxonomy_get_taxonomy_term_id($taxonomy, $term);
      $sessionUrl = $this->getSession()->getCurrentUrl();
      $parsedUrl = parse_url($sessionUrl);
      $newUrl = sprintf('%s://%s%s?tid=%s', $parsedUrl['scheme'], $parsedUrl['host'], $url, $tid);
      $this->getSession()->visit($newUrl);
    }

  /**
   * @Then I should see the head title :title
   */
  public function assertHeadTitle($title)
  {
    $page = $this->getSession()->getPage();
    $headTitle = $page->find('xpath', '//head/title');
    if ($headTitle->getText() !== $title) {
      throw new \Exception(sprintf('The head title is not correct. %s was found, expecting %s.', $headTitle->getText(), $title));
    }
  }

  /**
   * @Then I should see a what's new block
   */
  public function assertWhatsNewBlock()
  {
    $page = $this->getSession()->getPage();
    $block = $page->find('xpath', '//div[contains(concat(" ", @class, " "), " whats_new")]');
    if (is_null($block)) {
      throw new \Exception (sprintf('What\'s New block was not found on %s', $this->getSession()->getCurrentUrl()));
    }
  }

  /**
   * @Then I should see the slides:
   */
  public function assertSlidesExist(TableNode $slides)
  {
    $page = $this->getSession()->getPage();
    foreach ($slides as $slide) {
      $s = $page->find('xpath', sprintf('//div[contains(concat(\' \', @class, \' \'), \' flex-viewport \')]/ul/li//p[.="%s"]', $slide['body']));
      if (is_null($s)) {
        throw new \Exception(sprintf('Slide with body text \'%s\' was not found', $slide['body']));
      }
    }
  }

  /**
   * @Then I should not see the slides:
   */
  public function assertSlidesNotExist(TableNode $slides)
  {
    $page = $this->getSession()->getPage();
    foreach ($slides as $slide) {
      $s = $page->find('xpath', sprintf('//div[contains(concat(\' \', @class, \' \'), \' flex-viewport \')]/ul/li//p[.="%s"]', $slide['body']));
      if (!is_null($s)) {
        throw new \Exception(sprintf('Slide with body text \'%s\' was found', $slide['body']));
      }
    }
  }

  /**
   * @Then I should not see the site alert titled :alert
   */
  public function assertSiteAlertIsNotDisplayed($alert)
  {
    $page = $this->getSession()->getPage();
    $title = $page->find('xpath', sprintf('//*[contains(concat(\' \', @class, \' \'), \' site_alerts-view_alerts_block_homepage \')] | //div[contains(concat(\' \', @class, \' \'), \' alert-title \') and contains(text(), \'%s\')]', $alert));
    if (!is_null($title)) {
      throw new \Exception(sprintf('Site alert \'%s\' was found', $alert));
    }
  }

  /**
   * @Then I should see the site alert titled :alert
   */
  public function assertSiteAlertIsDisplayed($alert)
  {
    $page = $this->getSession()->getPage();
    $title = $page->find('xpath', sprintf('//*[contains(concat(\' \', @class, \' \'), \' site_alerts-view_alerts_block_homepage \')] | //div[contains(concat(\' \', @class, \' \'), \' alert-title \') and contains(text(), \'%s\')]', $alert));
    if (is_null($title)) {
      throw new \Exception(sprintf('Site alert \'%s\' was not found', $alert));
    }
  }

  /**
   * @Then I should not see the event end date in the site alert
   */
  public function assertSiteAlertDoesNotDisplayEndDate()
  {
    $page = $this->getSession()->getPage();
    $text = $page->find('xpath', '//*[contains(concat(\' \', @class, \' \'), \' site_alerts-view_alerts_block_homepage \')] | //div[contains(concat(\' \', @class, \' \'), \' alert-body \')]/a')->getText();
    if (is_null($text)) {
      throw new \Exception('The site alert was not found or does not have body text.');
    }

    if (!DateTime::createFromFormat('M j, g:i a T', trim(explode('|', $text)[1]))) {
      // check if event is today
      $text = str_replace('Today, ', '', $text);
      if (!DateTime::createFromFormat('g:i a T', trim(explode('|', $text)[1]))) {
        throw new \Exception('The site alert contains the end date or is invalid.');
      }
    }
  }

  /**
   * @Then I should see the event end date in the site alert
   */
  public function assertSiteAlertDisplaysEndDate()
  {
    $page = $this->getSession()->getPage();
    $text = $page->find('xpath', '//*[contains(concat(\' \', @class, \' \'), \' site_alerts-view_alerts_block_homepage \')] | //div[contains(concat(\' \', @class, \' \'), \' alert-body \')]/a')->getText();
    if (is_null($text)) {
      throw new \Exception('The site alert was not found or does not have body text.');
    }
    $datePart = trim(explode('|', $text)[1]);
    // An undefined offset exception is caught if the date part does not contain a hyphen
    try {
      // Check for end time (same date as start) and end date
      if (!DateTime::createFromFormat('M j, g:i a T', trim(explode('-', $datePart)[1])) &&
          !DateTime::createFromFormat('g:i a T', trim(explode('-', $datePart)[1]))) {
        throw new \Exception('The site alert event end date is invalid.');
      }
    }
    catch (Exception $e) {
      throw new \Exception('The site alert does not contain the end date.');
    }
  }

  /**
   * @When I click on the element with css selector :cssSelector then click on :value in the iframe selector :iframe_selector
   */
  public function iClickOnTheElementWithCssSelectorThenClickOnInTheIframeSelector($cssSelector, $value, $iframe_selector) {
  	$page = $this->getSession()->getPage();
  	$iframe_name = $this->getIframeName($iframe_selector);
  	$this->getSession()->getDriver()->switchToIFrame($iframe_name);
  	$page = $this->getSession()->getPage();
  	$element = $page->find("css", $cssSelector);
  	if (null === $element) {
  		throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $cssSelector));
  	}
  	$element->click();
  	$element = $page->findAll('css', $cssSelector.'>.menu>.item>span');
  	if (null === $element) {
  		throw new \InvalidArgumentException(sprintf('Could not find text value: "%s"', $value));
  	}
  	foreach ($element as $elem) {
  		if ($elem && trim($elem->getText()) === $value) {
  			$elem->click();
  		}
  	}
  	$this->getSession()->getDriver()->switchToIFrame(null);
  }

  /**
   * @When I fill in input :field with the value :value in the iframe selector :iframe_selector
   */
  public function iFillInInputWithTheValueInTheIframeSelector($field, $value, $iframe_selector) {
  	$page = $this->getSession()->getPage();
  	$iframe_name = $this->getIframeName($iframe_selector);
  	$this->getSession()->getDriver()->switchToIFrame($iframe_name);
  	$page = $this->getSession()->getPage();
  	$input_field = $page->find('css', 'input[id="'.$field.'"]');
  	if (empty($input_field)) {
  		throw new Exception(sprintf("The input field %s is not available.", $field));
  	}
  	$input_field->setValue($value);
  	$this->getSession()->getDriver()->switchToIFrame(null);
  }

  /**
   * @When I should see the text :value with css selector :cssSelector in the iframe selector :iframe_selector
   */
  public function iShouldSeeTheTextWithCssSelectorInTheIframeSelector($value, $cssSelector, $iframe_selector) {
  	$cssID = null;
  	$cssClass = null;
  	if ($cssSelector[0] == '#') {
  		$cssID = substr($cssSelector, 1);
  	}
  	elseif ($cssSelector[0] == '.') {
  		$cssClass = substr($cssSelector, 1);
  	}
  	$page = $this->getSession()->getPage();
  	$iframe_name = $this->getIframeName($iframe_selector);
  	$this->getSession()->getDriver()->switchToIFrame($iframe_name);
  	$function = <<<JS
        (function() {
          if ("$cssID") {
            return document.getElementById("$cssID").innerText.search(/$value/i) >= 0;;
          }
          if ("$cssClass") {
            return document.getElementsByClassName("$cssClass")[0].innerText.search(/$value/i) >= 0;
          }
         })()
JS;
  	try {
  		$result = $this->getSession()->evaluateScript("return $function");
  	} catch (Exception $e) {
  		print_r($e->getMessage());
  		throw new \Exception("The JS did not execute correctly.".PHP_EOL . $e->getMessage());
  	}
  	if (!$result) {
  		throw new Exception(sprintf("The text %s is not available.", $value));
  	}
  	else {
  		return;
  	}
  	$this->getSession()->getDriver()->switchToIFrame(null);
  }

  /*
   * This function will add name attribute to an iframe with just css selector
   */
  public function getIframeName($iframe_selector) {
  	$function = <<<JS
        (function() {
          var iframe = document.querySelector("$iframe_selector");
           iframe.name = "iframeToSwitchTo";
         })()
JS;
  	try {
  		$this->getSession()->executeScript($function);
  		return 'iframeToSwitchTo';
  	} catch (Exception $e) {
  		print_r($e->getMessage());
  		throw new \Exception("Element $iframe_selector was NOT found.".PHP_EOL . $e->getMessage());
  	}
  }

  /**
   * @Given /^I hover over the element "([^"]*)"$/
   */
  public function iHoverOverTheElement($locator)
  {
  	$session = $this->getSession(); // get the mink session
  	$element = $session->getPage()->find('css', $locator); // runs the actual query and returns the element

  	// errors must not pass silently
  	if (null === $element) {
  		throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $locator));
  	}

  	// ok, let's hover it
  	$element->mouseOver();
  }
    /**
   * Input and select into an autocomplete field
   * @When I select the first autocomplete option for :text on the :autocomplete field on a modal
   * I think there's a way to clean this up, pass an optional field of region to the function above
   * and then add the matching step as well. I'll need to look into that TODO
   */
  public function iSelectTheFirstAutocompleteOptionForTextOnTheAutocompleteFieldOnAModal($autocomplete, $text)
  {
   $region = "modal";
   $session = $this->getSession();
   $driver = $session->getDriver();
   $regionObj = $session->getPage()->find('region', $region);
   if (!$regionObj) {
     throw new \Exception(sprintf('No region "%s" found on the page %s.', $region, $session->getCurrentUrl()));
   }
   $field = $regionObj->findField($autocomplete);
   $field->focus();

   $this->scrollIntoView("#" . $field->getAttribute("id"));

   // Set the autocomplete text then put a space at the end which triggers
   // the JS to go do the autocomplete stuff.
   $field->setValue($text);
   $xpath = $field->getXpath();
   $field->keyDown(40);
   $field->keyUp(40);

   // Wait for AJAX to finish.
   $this->minkContext->iWaitForAjaxToFinish();

   $result = $this->getSession()->getPage()->find("xpath", "//ul[not(contains(@style,'display: none'))]/li[@class='ui-menu-item']/a");
   if (empty($result)) {
      throw new \Exception("Autocomplete result not found");
   } else {
     $result->click();
   }

  }

  /**
   * @Then the link :arg1 should match the Drupal url :arg2
   */
  public function theLinkShouldMatchTheDrupalUrl($link, $url)
  {
      $linkHandle = $this->getSession()->getPage()->find('named', array('link', $link));
      if (isset($linkHandle)) {
        $linkUrl = $linkHandle->getAttribute('href');
        $root = explode('.', $link, -1);
        $file_path = explode('/', $url, -1);
        $filePieces = explode('.', $link);
        $extension = end($filePieces);
        $escaped = preg_quote($root[0], '/');
        $url_path = $file_path[1] . "/" . $file_path[2] . "/";
        $escaped_path = preg_quote($url_path, '/');
        $pattern = '/\/' . $escaped_path . '.*' . $escaped . '_*\d*' . '.' . $extension . '/';
        if (preg_match($pattern, $linkUrl)) {
          return;
        } else {
          throw new \Exception($link . " link does not match the Drupal Url " . $linkUrl);
        }
      } else {
        throw new \Exception($link . " link not found on page.");
      }
  }

  /**
   * @Then the hyperlink :arg1 should match the Drupal url :arg2
   */
  public function linkShouldMatchTheDrupalUrl($link, $url)
  {
      $linkHandle = $this->getSession()->getPage()->find('named', array('link', $link));
      if (isset($linkHandle)) {
        $linkUrl = $linkHandle->getAttribute('href');
        if (strcmp($url, $linkUrl) == 0) {
          return;
        } else {
          throw new \Exception($link . " link does not match the Drupal Url " . $linkUrl);
        }
      } else {
        throw new \Exception($link . " link not found on page.");
      }
  }

  /**
   * @When /^the link should open in a new tab$/
   */
  public function linkShouldOpenInNewTab()
  {
      $session     = $this->getSession();
      $windowNames = $session->getWindowNames();
      if(sizeof($windowNames) < 2){
          throw new \ErrorException("Expected to see at least 2 windows opened");
      }

      //Switch to that window
      $session->switchToWindow($windowNames[1]);
  }

  /**
    * @Given I click secondary option :arg1
    */
   public function iClickSecondaryOption($arg1)
   {
     $xpath = "//summary/span[text() = '" . $arg1 . "']";
     $secondaryOption = $this->getSession()->getPage()->findAll('xpath', $xpath);
     $this->scrollIntoView($xpath);
     $secondaryOption[0]->click();
   }

   /**
    * @Then I should see response headers with content type :arg1
    */
   public function iShouldSeeResponseHeadersWithContentType($arg1)
   {
     switch (strtolower($arg1)) {
       case "pdf":
         $type = "application/pdf";
         break;
       default:
         throw new \Exception(sprintf("Content Type Not Defined. Update FeatureContext."));

     }

     $headers = $this->getSession()->getResponseHeaders();
     $content_type =  $headers['Content-Type'];
     assert($content_type[0] == $type);
   }

   /**
    * @Then I should see response headers with inline content type :arg1
    */
   public function iShouldSeeResponseHeadersWithContentTypeAndInlineDisposition($arg1)
   {
     switch (strtolower($arg1)) {
       case "pdf":
         $type = "application/pdf";
         break;
       default:
         throw new \Exception(sprintf("Content Type Not Defined. Update FeatureContext."));

     }

     $headers = $this->getSession()->getResponseHeaders();
     $content_type =  $headers['Content-Type'];
     assert($content_type[0] == $type);

     $disposition = explode(';', $headers['Content-Disposition'][0]);
     $inline = $disposition[0] == 'inline' ? TRUE : FALSE;
     assert($inline);
   }

   /**
    * Switches focus to an iframe.
    *
    * @Given /^I switch (?:away from|to) the iframe "([^"]*)"$/
    * @param string $iframe_name
    */
   public function iSwitchToTheIframe($iframe_name) {
     if ($iframe_name) {
       $this->getSession()->switchToIFrame($iframe_name);
     } else {
       $this->getSession()->switchToIFrame();
     }
   }

    /**
    * @When /^I clear drupal cache$/
    */
   public function clearDrupalCache()
   {
      $this->visitPath("/admin/config/development/performance");
      $this->getSession()->getPage()->pressButton('edit-clear');

     }

  /**
   * @When I drag image :arg1 onto :arg2
   */
  public function iDragImageOnto($arg1, $arg2)
  {
     $page = $this->getSession()->getPage();
     $dragged = $page->find('xpath', '//tbody/tr/td[contains(., "' . $arg1 . '")]/preceding-sibling::td/a');
     $target = $page->find('xpath', '//tbody/tr/td[contains(., "' . $arg2 . '")]/ancestor::tr');


     $session = $this->getSession()->getDriver()->getWebDriverSession();

     $from = $session->element('xpath',$dragged->getXpath());
     $to = $session->element('xpath',$target->getXpath());

     $session->moveto(array('element' => $from->getID()));
     $session->buttondown("");
     $session->moveto(array('element' => $to->getID()));
     $session->buttonup("");
  }

  /**
   * @When I drag taxonomy term :arg1 onto :arg2
   */
  public function iDragTaxonomyTermOnto($arg1, $arg2)
  {
    $page = $this->getSession()->getPage();

    $dragged = $page->find('xpath', '//tr/td/a[contains(., "' . $arg1 . '")]/preceding-sibling::a');
    $target = $page->find('xpath', '//tr/td[contains(., "' . $arg2 . '")]/ancestor::tr');
    $session = $this->getSession()->getDriver()->getWebDriverSession();

    $from = $session->element('xpath', $dragged->getXpath());
    $to = $session->element('xpath', $target->getXpath());

    $session->moveto(array('element' => $from->getID()));
    $session->buttondown("");
    $session->moveto(array('element' => $to->getID()));
    $session->buttonup("");
  }


  /**
   * @When I scroll to the top
   */
  public function iScrollToTheTop()
  {
    $this->getSession()->wait(500,' window.scrollTo(0, 0) ');
  }

   /**
     * @Then I should not see title
     */
    public function iShouldNotSeeTitle()
    {
      $title = $this->getSession()->getPage()->findAll('css', '.hideTitle');

      if ($title != null){
        return;
      } else {
        throw new \Exception(
          sprintf("Expected to show no title on page")
        );
      }
    }

  /**
    * @Given /^I close the current (?:window|tab)$/
    */
  public function closeCurrentWindow()
  {
     $session     = $this->getSession();
     $this->getSession()->executeScript("window.open('','_self').close();");
     $session->restart();
  }

  /**
    * @When I switch to the main window
  */
  public function iSwitchToTheMainWindow()
  {
       $this->getSession()->switchToIframe();
  }

  /**
    * @Given /^I switch to the new (?:window|tab)$/
  */
  public function switchToNewWindow()
  {
      $windowNames = $this->getSession()->getWindowNames();

      if (count($windowNames) > 1) {
          $this->getSession()->switchToWindow(end($windowNames));
      } else {
          throw new Exception("There is not a tab to switch to");
      }
  }

  /**
     * @Given /^I set browser window size to "([^"]*)" x "([^"]*)"$/
     */
    public function iSetBrowserWindowSizeToX($width, $height) {
      $this->getSession()->resizeWindow((int)$width, (int)$height, 'current');
    }

  /**
   * @Then /^I should see the css selector "([^"]*)"$/
   * @Then /^I should see the CSS selector "([^"]*)"$/
   */
  public function iShouldSeeTheCssSelector($css_selector) {
    $element = $this->getSession()->getPage()->find("css", $css_selector);
    if (null === $element) {
      throw new \Exception(sprintf("The page '%s' does not contain the css selector '%s'", $this->getSession()->getCurrentUrl(), $css_selector));
    }
  }

  /**
  * @Then /^I should not see the css selector "([^"]*)"$/
  * @Then /^I should not see the CSS selector "([^"]*)"$/
  */
  public function iShouldNotSeeTheCssSelector($css_selector) {
    $element = $this->getSession()->getPage()->find("css", $css_selector);
    if (!empty($element)) {
      throw new \Exception(sprintf("The page '%s' contains the css selector '%s'", $this->getSession()->getCurrentUrl(), $css_selector));
    }
  }

  /**
   * @Then /^radio button with id "([^"]*)" should be checked$/
   */
  public function RadioButtonWithIdShouldBeChecked($sId)
  {
    $elementByCss = $this->getSession()->getPage()->find('css', 'input[type="radio"]:checked#'.$sId);
    if (!$elementByCss) {
        throw new Exception('The radio button with id ' . $sId.' is not checked');
    }
  }

   /**
   * Ensure that an HTML element does not exists on the page
   *
   * @Then I should not see the html element :arg1 on the page
   */
  public function iDoNotSeeTheHtmlElementOnPage($arg1)
  {
    $element = $this->getSession()->getPage()->find("css", $arg1);

    if ($element) {
      throw new \Exception("element $arg1 was found on the page.");
    }
  }

	  /**
	 * @Then I should see :textA followed by :textB
	 */
  public function iShouldSeeFollowedBy($textA, $textB)
  {
    $content = $this->getSession()->getPage()->getContent();

    // Get rid of stuff between script tags
    $content = $this->removeContentBetweenTags('script', $content);

    // ...and stuff between style tags
    $content = $this->removeContentBetweenTags('style', $content);

    $content = preg_replace('/<[^>]+>/', ' ',$content);

    // Replace line breaks and tabs with a single space character
    $content = preg_replace('/[\n\r\t]+/', ' ',$content);

    $content = preg_replace('/ {2,}/', ' ',$content);

    if (strpos($content,$textA) === false) {
      throw new Exception(sprintf('"%s" was not found in the page', $textA));
    }

    $seeking = $textA . ' ' . $textB;
    if (strpos($content,$textA . ' ' . $textB) === false) {
      // Be helpful by finding the 10 characters that did follow $textA
      preg_match('/' . $textA . ' [^ ]+/',$content,$matches);
      throw new Exception(sprintf('"%s" was not found, found "%s" instead', $seeking, $matches[0]));
    }
  }

  /**
   * @param string $tagName - The name of the tag, eg. 'script', 'style'
   * @param string $content
   *
   * @return string
   */
  private function removeContentBetweenTags($tagName,$content)
  {
    $parts = explode('<' . $tagName, $content);

    $keepers = [];

    // We always want to keep the first part
    $keepers[] = $parts[0];

    foreach ($parts as $part) {
      $subparts = explode('</' . $tagName . '>', $part);
      if (count($subparts) > 1) {
        $keepers[] = $subparts[1];
      }
    }

    return implode('', $keepers);
  }

    /**
    * The path where mail can be rerieved
    *
    * $mailpath string
    *
    */
    protected $mailpath = "http://mail-sec.lndo.site";

    /**
    * @Given /^I check notification$/
    */
    public function iCheckNotification()
    {
    $mail_path = $this->mailpath;
    $this->visitPath($mail_path);
    }

  /**
   * @Then the :arg1 response header does exist
   */
  public function theResponseHeaderDoesExist($arg1)
  {
    $arg1 = strtolower($arg1);
    $headers = $this->getSession()->getResponseHeaders();
    $headers = array_change_key_case($headers,CASE_LOWER);
    if (isset($headers[$arg1])) {
      echo $arg1 . " exists. Well done";
    } else {
      throw new Exception("$arg1 should exist. Please update /admin/config/system/response-headers");
    }
  }

  /**
   * @Then the :arg1 response header does not exist
   */
  public function theResponseHeaderDoesNotExist($arg1)
  {
    $arg1 = strtolower($arg1);
    $headers = $this->getSession()->getResponseHeaders();
    $headers = array_change_key_case($headers,CASE_LOWER);
    if (isset($headers[$arg1])) {
      throw new Exception("$arg1 should not exist. Please update /admin/config/system/response-headers");
    } else {
      echo $arg1 . " does not exist. Well done";
    }
  }

  /**
   * Compare a response header value against a string
   *
   * @param string $header The name of the header
   * @param string $value the value to compare
   *
   * @Then the :arg1 response header should contain :arg2
   */
  public function theResponseHeaderShouldContain($arg1, $arg2)
  {
    $arg1 = strtolower($arg1);
    $arg2 = strtolower($arg2);
    $headers = array();
    $headers = $this->getSession()->getResponseHeaders($arg1);
    $headers = array_change_key_case($headers,CASE_LOWER);
    if (array_key_exists($arg1, $headers)) {
      if (str_contains($headers[$arg1][0], $arg2)) {
        echo $arg1 . " response header contains " . $arg2 . ". Well done";
      } else {
        throw new Exception("$arg1 response header does not contain $arg2 and it should. Please update /admin/config/system/response-headers");
      }
    } else {
      throw new Exception("$arg1 response header does not exist. Please update /admin/config/system/response-headers");
    }
  }
  /**
   * Compare a response header value against a string
   *
   * @param string $header The name of the header
   * @param string $value the value to compare
   *
   * @Then the :arg1 response header should not contain :arg2
   */
  public function theResponseHeaderShouldNotContain($arg1, $arg2)
  {
    $arg1 = strtolower($arg1);
    $arg2 = strtolower($arg2);
    $headers = array();
    $headers = $this->getSession()->getResponseHeaders($arg1);
    $headers = array_change_key_case($headers,CASE_LOWER);
    if (array_key_exists($arg1, $headers)) {
      if (str_contains($headers[$arg1][0], $arg2)) {
        throw new Exception("$arg1 response header contains $arg2 and it should not. Please update /admin/config/system/response-headers ");
      } else {
        echo $arg1 . " response header does not contain " . $arg2 . ". Well done";
      }
    } else {
      throw new Exception("$arg1 response header does not exist. Please update /admin/config/system/response-headers");
    }
  }
}
