<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Tester\Exception\PendingException;
use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;

/**
 * Defines application features from the specific context.
 */
class WysiwygContext extends RawDrupalContext implements Context {

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
   * Get id of WYSIWYG element by label text
   *
   * @param String
   * The label associated with the WYSIWYG NodeElement
   *
   * @return String
   * The id attribute of the WYSIWYG NodeElement
   */

  protected function getWysiwygId($label) {
    // Traverse page content matching $label. The first label found, get the for
    // attribute as this is the id of the WYSIWYG field.
    $id = '';
    $page = $this->getSession()->getPage();
    // Search for content containing $label
    $nodeElements = $page->findAll('named', array('content', $label));
    foreach ($nodeElements as $el) {
      if ($el->getTagName() == 'label') {
        $id = $el->getAttribute('for');
        // Make sure NodeElement is a textarea
        if ($page->find('css', '#' . $id)->getTagName() == 'textarea') {
          break;
        }
      }
    }
    return $id;
  }

  /**
   * Get a Mink Element representing the WYSIWYG toolbar.
   *
   * @throws Exeception
   *   Throws an exception if the toolbar can't be found.
   *
   * @return \Behat\Mink\Element\NodeElement
   *   The toolbar DOM Node.
   */
  protected function getWysiwygToolbar($label) {
    $id = $this->getWysiwygId($label);
    $driver = $this->getSession()->getDriver();

    $toolbarElement = $driver->find("//div[@id='cke_" . $id . "']");
    $toolbarElement = !empty($toolbarElement) ? $toolbarElement[0] : NULL;

    if (!$toolbarElement) {
      throw new \Exception(sprintf('Toolbar for %s editor was not found on the page %s', $label, $this->getSession()->getCurrentUrl()));
    }

    return $toolbarElement;
  }

  /**
   * @When I type :arg1 in the :arg2 WYSIWYG editor
   */
  public function iTypeInTheWysiwygEditor($text, $arg2)
  {
    $id = $this->getWysiwygId($arg2);
    $this->getSession()->executeScript("CKEDITOR.instances['" . $id . "'].insertText('$text');");
  }

  /**
   * @When I type :arg1 in the :arg2 session :arg3 WYSIWYG editor
   */
  public function iTypeInTheSessionWysiwygEditor($text, $arg2, $arg3)
  {
      $fieldName = "field_session[" . --$arg2 . "][subform][field_" . strtolower($arg3) . "][0][value]";
      $field = $this->getSession()->getPage()->findField($fieldName);
      $id = $field->getAttribute('id');
      $this->getSession()->executeScript("CKEDITOR.instances['$id'].insertText('$text');");
  }
  /**
   * @When I press :arg1 in the :arg2 WYSIWYG Toolbar
   * Likely I'm going to have to abstract this at some point too if we have to test that a field like transcript can bold
   * italic etc. I'm going to wait until that time comes.
   */
  public function iPressInTheWysiwygToolbar($arg1, $arg2)
  {
    $toolbarElement = $this->getWysiwygToolbar($arg2);

    // If the element is 'link', we need to set focus
    if ($arg1 == 'Link') {
      $id = $this->getWysiwygId($arg2);
      $script = <<<"EOT"
        var editor = CKEDITOR.instances['$id'];
        var element = editor.document.getElementsByTag('p');
        editor.getSelection().selectElement(element.getItem(0));
EOT;
      $this->getSession()->executeScript($script);
    }

    // Click the action button.
    $button = $toolbarElement->find("xpath", "//a[starts-with(@title, '$arg1')]");
    $button->click();
    $this->minkContext->iWaitForAjaxToFinish();
  }

  /**
   * @When I enter :url for link URL
   */
  public function iEnterForLinkUrl($url)
  {
    $page = $this->getSession()->getPage();
    $urlNodeElement = $page->find('css', 'input[id^=edit-attributes-href]');
    $urlNodeElement->focus();
    $urlNodeElement->setValue($url);

    // Using JavaScript to click the Save button because nothing else worked.
    $script = <<<EOT
      jQuery('button.form-submit:contains("Save")').click();
EOT;
    $this->getSession()->executeScript($script);
    $this->minkContext->iWaitForAjaxToFinish();
  }

  /**
   * @When I embed node :node in the :wysiwyg WYSIWYG
   */
  public function iEmbedNodeInTheWysiwyg($node, $wysiwyg)
  {
    $page = $this->getSession()->getPage();
    $driver = $this->getSession()->getDriver();

    $this->iPressInTheWysiwygToolbar('Embed', $wysiwyg);

    $field = $page->find('css', 'input[id^=edit-entity-id]');
    $field->setValue($node);
    $xpath = $field->getXpath();
    $driver->keyDown($xpath, 40);
    $driver->keyUp($xpath, 40);

    // Wait for AJAX to finish.
    $this->minkContext->iWaitForAjaxToFinish();

    $result = $page->find("xpath", "//ul[not(contains(@style,'display: none'))]/li[@class='ui-menu-item']/a");
    if (empty($result)) {
       throw new \Exception("Autocomplete result not found");
    } else {
      $result->click();
      $script = <<<EOT
        jQuery('button.form-submit:contains("Next")').click();
EOT;
      $this->getSession()->executeScript($script);
      $this->minkContext->iWaitForAjaxToFinish();
      $script = <<<EOT
        jQuery('button.form-submit:contains("Embed")').click();
EOT;
      $this->getSession()->executeScript($script);
      $this->minkContext->iWaitForAjaxToFinish();
    }
  }
    /**
   * @When I take a screenshot on :arg1 using :feature file with :case tag
   */
  public function iTakeAScreenshotUsingFileWithTag($arg1, $feature, $case)
  {
    if (strpos(getcwd(), 'docroot') == true) {
      if ($arg1 == 'sec') {
        $arg1 = 'features';
      }
      if ($arg1 == 'investor') {
        $arg1 = 'features_investor';
      }
      chdir('../test/'.$arg1.'/cucumber_wdio');
    }
    shell_exec('npm start ' . $feature . ' -- --cucumberOpts.tagExpression=' . $case);
  }

    /**
   * @When I take a screenshot on SEC.gov using :feature file with :case tag
   */
  public function iTakeAScreenshotOnSECUsingFileWithTag($feature, $case)
  {
    if (strpos(getcwd(), 'docroot') == true) {
      chdir('../test/features/cucumber_wdio');
    }
    shell_exec('npm start ' . $feature . ' -- --cucumberOpts.tagExpression=' . $case);
  }
  /**
    * @When I clear text in the :arg1 WYSIWYG editor
    */
 public function iClearTextInTheWysiwgEditor($arg1)
 {
 $driver = $this->getSession()->getDriver();
 // Find the wyiwyg field
 $wysiwygName = "field";
 $arg1 = strtolower($arg1);
 if ($arg1 != "body") {
 $hasSpace = strpos($arg1, " ");
 if ($hasSpace) {
 $fieldNames = explode(" ", $arg1);
 foreach ($fieldNames as $name) {
 $wysiwygName .= "-" . $name;
 }
 $arg1 = $wysiwygName;
 } else {
 $arg1 = "field-" . $arg1;
 }
 }
 // Scroll to approriate wysiwyg field
 $this->getSession()->executeScript(
 'document.querySelector("div#cke_edit-'.$arg1.'-0-value").scrollIntoView(false)'
 );
 // Find the correct wysiwyg
 $toolbarElement = $driver->find("//div[@id='cke_edit-$arg1-0-value']");
 $toolbarElement = !empty($toolbarElement) ? $toolbarElement[0] : NULL;
 if (!$toolbarElement) {
 throw new \Exception(sprintf('Toolbar for editor was not found on the page %s', $this->getSession()->getCurrentUrl()));
 }
 // Find the Source button within wysiwyg
 $button = $toolbarElement->find("xpath", "//a[starts-with(@title, 'Source')]");
 // Click the action button.
 $button->click();
 $this->minkContext->iWaitForAjaxToFinish();
 // Replace textarea value with empty value
 $this->getSession()->getDriver()->evaluateScript(
 'function(){
 document.querySelector("#cke_edit-'.$arg1.'-0-value textarea").value = "";
 }()'
 );
 // Clicking Source button again to get back to normal editor
 $button = $toolbarElement->find("xpath", "//a[starts-with(@title, 'Source')]");
 $button->click();
 }
 /*
 * @When I select all and enter :arg1 in the :arg2 WYSIWYG editor
 */
 public function selectAllWyswig($text, $arg2)
 {
 $id = $this->getWysiwygId($arg2);
 }
 /**
  * @When I type :text in the :label WYSIWYG editor number :index
  */
 public function iTypeInTheNthWysiwygEditor($text, $label, $index) {
   // Get an array of IDs by label.
   $ids = $this->getWysiwygIdsByLabel($label);
   $id = $ids[$index];
   $this->getSession()->executeScript("CKEDITOR.instances['" . $id . "'].insertText('$text');");
 }
 protected function getWysiwygIdsByLabel($label) {
    // Setup the IDs array.
    $ids = [];

    // Get the page.
    $page = $this->getSession()->getPage();

    // Search for content containing $label.
    $nodeElements = $page->findAll('named', ['content', $label]);

    // For each of the elements with $label, see if it's a label field.
    // If so add its ID to the $ids array.
    foreach ($nodeElements as $el) {
      // See if this element is a label.
      if ($el->getTagName() == 'label') {

        // Get the element's ID from the 'for' attribute.
        $id = $el->getAttribute('for');

        // Make sure NodeElement is a textarea.
        if ($page->find('css', '#' . $id)->getTagName() == 'textarea') {
          // Add the ID to the array.
          $ids[] = $id;
        }
      }
    }
    return $ids;
  }

  /**
   * @When I type :arg1 in css selector :arg2
   */
  public function iTypeInCssSelector($arg1, $arg2)
  {
    $copy = $this->getSession()->getPage()->find('css', $arg2);
    $copy->setValue($arg1);
  }

   /**
   * @When I select text :arg1 in WYSIWYG selector :arg2
   */
  public function iSelectTextInWysiwygSelector($arg1, $arg2) {
    $page = $this->getSession()->getPage();
    $field = $page->find('css', 'label[for^=' . $arg2 . ']');
    $field_name = $field->getAttribute("for");
    if (isset($field_name)) {
      try {
        $js = <<<JS
(function(){
var editor = CKEDITOR.instances['$field_name'],
  selection = editor.getSelection(),
  root = selection.root,
  textNodes = [],
  ranges = [],
  range, text, index;
console.log(root);
function getTextNodes(element) {
  var children = element.getChildren(),
    child;
  for (var i = children.count(); i--;) {
    child = children.getItem(i);
    if (child.type == CKEDITOR.NODE_ELEMENT)
      getTextNodes(child);
    else if (child.type == CKEDITOR.NODE_TEXT)
      textNodes.push(child);
  }
}

// Recursively search for text nodes starting from root.
// You may want to search a specific branch starting from other element.
getTextNodes(root);

// Iterate over found text nodes. If some contains
// phrase $arg1, create a range that selects this word.
for (i = textNodes.length; i--;) {
  text = textNodes[i];
  var word = '$arg1';
  index = text.getText().indexOf(word);
  if (index > -1) {
    range = editor.createRange();
    range.setStart(text, index);
    range.setEnd(text, index + word.length);
    ranges.push(range);
  } else {
    return false;
  }
}

// Select all ranges "containing" phrase $arg1.
selection.selectRanges(ranges);

})()
JS;
        $result = $this->getSession()->evaluateScript($js);
        if (isset($result) && !$result) {
          throw new \Exception("No text found.");
        }
      } catch (Exception $e) {
        throw new \Exception(__METHOD__ . ' No text found.');
      }
    } else {
      throw new \Exception("No element found.");
    }
  }

  /**
  * @When I choose style :option within WYSIWYG selector :selector
  */
  public function iChooseStyleInWysiwygSelector($option, $selector) {
    $page = $this->getSession()->getPage();
    $field = $page->find('css', 'label[for^=' . $selector . ']');
    $field_name = $field->getAttribute("for");
      if (isset($field_name)) {
      $this->minkContext->assertClick('Formatting Styles');
      $js = <<<JS
    (function(){
  var styles = [];
  var editor = CKEDITOR.instances['$field_name'];
  editor.getStylesSet(function( stylesDefinitions ) {
  styles = stylesDefinitions;
  });
   for ( var y = 0; y < styles.length; y++ ) {
  if (styles[y].name == '$option') {
    var style = new CKEDITOR.style( styles[y] )
    editor.applyStyle( style )
    }
  }
  })()
  JS;
      $this->minkContext->assertClick('Formatting Styles');
      try {
        $this->getSession()->evaluateScript($js);
        $this->minkContext->assertLinkVisible($option);
      } catch (Exception $e) {
        throw new \Exception(__METHOD__ . ' No option found.');
      }
      } else {
      throw new \Exception("No element found.");
    }
  }

  /**
   * @When I choose format :option within WYSIWYG selector :selector and should see :title selected
   */
  public function iChooseFormatInWysiwygSelectorAndShouldSeeSelected($option, $selector, $title) {
    $page = $this->getSession()->getPage();
    $field = $page->find('css', 'label[for^=' . $selector . ']');
    $field_name = $field->getAttribute("for");
    if (isset($field_name)) {
      $this->minkContext->assertClick('Paragraph Format');
      $js = <<<JS
    (function(){
  var styles = [];
  var editor = CKEDITOR.instances['$field_name'];
  var style = '';
  (function() {
  for ( var i = 0; i < editor.toolbar.length ; i++ ) {
    if (editor.toolbar[i].name == 'Block Formatting') {
      for ( var j = 0; j < editor.toolbar[i].items.length ; j++ ) {
        if (editor.toolbar[i].items[j].title == 'Paragraph Format') {
          for (var x = 0; x < editor.toolbar[i].items[j].allowedContent.length; x++ )
          {
            var styleDefinition = editor.toolbar[i].items[j].allowedContent[x];
            styles.push(styleDefinition);
          }
        }
      }
    }
  }
})();
  for ( var y = 0; y < styles.length; y++ ) {
    if (styles[y].element == '$option') {
    editor.applyStyle( styles[y] )
    }
  }
 })()
JS;
      $this->minkContext->assertClick('Paragraph Format');
      try {
        $this->getSession()->evaluateScript($js);
        $this->minkContext->assertLinkVisible($title);
      } catch (Exception $e) {
        throw new \Exception(__METHOD__ . ' No option found.');
      }
    } else {
      throw new \Exception("No element found.");
    }
  }
}
