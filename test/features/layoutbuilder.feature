Feature: Utilizing Layout Builder
  As a sitebuilder or above user can use Layout Builder to SEC.gov
  I want to be able to view content that allows for layouts
  So that I quickly change the section and/or blocks

  @api @javascript
  Scenario: Adding In-line Custom Block To Basic Page
    Given I am logged in as a user with the "administrator" role
    When "page" content:
      | title            |
      | BEHAT basic page |
      And I am on "/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
      And I wait for ajax to finish
    Then I should see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"

  @api @javascript
  Scenario: Revert Changes of Custom Block To Basic Page
    Given I am logged in as a user with the "administrator" role
    When "page" content:
      | title            |
      | BEHAT basic page |
      And I am on "/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
      And I wait for ajax to finish
    Then I should see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"
    When I visit "/behat-basic-page/layout"
      And I click on the element with css selector "#edit-revert"
      And I click on the element with css selector "#edit-submit"
    Then I should not see the text "Behat Testing Block"
      And I should not see the text "Detail body of custom block"

  @api @javascript
  Scenario: Removing Custom Block Using Quick Edit
    Given I am logged in as a user with the "administrator" role
    When I create "node" of type "page":
      | title            |
      | BEHAT basic page |
      And I am on "/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"
    When I visit "/behat-basic-page/layout"
      And I wait 2 seconds
      And I scroll to the bottom
      And I hover over the element "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div"
      And I wait 2 seconds
      And I press "Open Behat Testing Block configuration options"
      And I click on the element with css selector "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div > div > div.contextual > ul > li:nth-child(4)"
      And I press "Remove"
      And I wait 1 seconds
      And I click on the element with css selector "input[id^='edit-submit']"
    Then I should not see the text "Behat Testing Block"
      And I should not see the text "Detail body of custom block"

  @api @javascript
  Scenario: Move Custom Blocks Order Block To Basic Page
    Given I am logged in as a user with the "administrator" role
    When "page" content:
      | title            |
      | BEHAT basic page |
      And I am on "/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Block 1"
      And I type "body 1 sdfuoisf" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Block 2"
      And I type "body 2" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
    Then "Behat Block 1" should precede "Behat Block 2" for the query "//h2"
    When I hover over the element "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div"
      And I wait 2 seconds
      And I press "Open Behat Block 1 configuration options"
      And I click on the element with css selector "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div > div > div.contextual > ul > li:nth-child(2)"
      And I press "Show row weights"
      And I select "6" from "Weight for Behat Block 1 block"
      And I press "Move"
      And "Behat Block 2" should precede "Behat Block 1" for the query "//h2"

  @api @javascript
  Scenario: Adding Text to Custom Content Block On Basic Page And Hide Display Title
    Given I am logged in as a user with the "administrator" role
    When "page" content:
      | title            |
      | BEHAT basic page |
      And I am on "/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I uncheck "Display title"
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
      And I wait for ajax to finish
    Then I should not see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"

  @api @javascript
  Scenario: Editing Custom Block On Basic Page
    Given I am logged in as a user with the "administrator" role
      And "page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/block/add"
      And I fill in "Block description" with "Behat content Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I press "Save"
      And I am on "/Behat-basic-Page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I fill in "Filter by block name" with "Behat"
      And I click "Behat content Block" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I press the "Add block" button
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat content Block"
      And I should see the text "Detail body of custom block"
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Behat content Block" row
      And I type "Updated Body" in the "Body" WYSIWYG editor
      And I press "Save"
      And I wait 1 seconds
      And I visit "/behat-basic-page"
    Then I should see the text "Updated Body"
    When I am on "/admin/structure/block/block-content"
      And I wait 1 seconds
      And I click "Edit" in the "Behat content Block" row
      And I click on the element with css selector "#edit-delete"
      And I press "Delete"
    Then I should see the text "The custom block Behat content Block has been deleted."

  @api
  Scenario Outline: Confirm Permissions to Access Layout Builder
    Given "page" content:
      | title            |
      | BEHAT basic page |
    When I am logged in as a user with the "<role>" role
      And I am on "/behat-basic-page/edit"
    Then I should <results> the link "Layout"

    Examples:
      | role              | results |
      | Content Creator   | not see |
      | Content Approver  | not see |
      | sitebuilder       | see     |
      | Administrator     | see     |
