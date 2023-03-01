Feature: Create Pages
  As a Content Creator, I want to be able to create basic page
  So that visitors to investor.gov can learn about the investor

  @ui @api @javascript @wdio
  Scenario: Edit a Page
    Given "page" content:
      | title            | body           | status | nid |
      | Behat Basic Page | free ice cream | 1      | 1   |
      And I am logged in as a user with the "Content Approver" role
    When I visit "/node/1/edit"
      And I click "Remove"
      And I uncheck "Show Featured Content"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "Save" button
    Then I take a screenshot on "investor" using "page.feature" file with "@create_page" tag

  @ui @api @javascript @wdio
  Scenario: Take Screenshot of Landing page
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
      | title                       | body                                            | status | moderation_state | nid |
      | Investor Behat Test Landing | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
    When I visit "/node/123/edit"
      And I click "Remove"
      And I uncheck "Show Featured Content"
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@create_landing_page" tag
      And I visit "/node/123/edit"
      And I check "Hide Page Title"
      And I press the "edit-submit" button
      And I take a screenshot on "investor" using "landingpage.feature" file with "@landing_page_no_title" tag

  @ui @api @javascript @wdio
  Scenario: Adding Button Block to Landing Page Screenshot
    Given I am logged in as a user with the "Content Approver" role
      And I create "media" of type "image":
      | name      | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Pig Image | behat-gold-pig.png | some alt txt          | 122229 | publication      |
      And "landing" content:
      | title              |
      | BEHAT Landing Page |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Default Block"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-wrapper"
      And I wait 2 seconds
      And I fill in "URL" with "/"
      And I fill in "Link text" with "Default"
      And I wait 2 seconds
      And I press "Add block"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Alternate Block"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-wrapper"
      And I wait 2 seconds
      And I fill in "URL" with "/"
      And I fill in "Link text" with "Alternate 1"
      And I select "Alternate 1" from "Theme"
      And I wait 2 seconds
      And I press "Add block"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing No TitleBlock"
      And I wait 2 seconds
      And I uncheck "Display title"
      And I click on the element with css selector ".dropbutton-wrapper"
      And I wait 2 seconds
      And I fill in "URL" with "/"
      And I fill in "Link text" with "Alternate 2"
      And I select "Alternate 2" from "Theme"
      And I wait 2 seconds
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I press "Save layout"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@create_button" tag

  @ui @api @javascript @wdio
  Scenario: Take Screenshot of Image and Content on Landing Page
    Given I am logged in as a user with the "Content Approver" role
      And I create "media" of type "image":
      | name      | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Pig Image | behat-gold-pig.png | some alt txt          | 122229 | published        |
      And "landing" content:
      | title              |
      | BEHAT Landing Page |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "Two column"
      And I wait for ajax to finish
      And I press "Add section"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Image"
      And I wait for ajax to finish
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait for ajax to finish
      And I press "Add Image"
      And I wait for ajax to finish
      And I fill in "Use existing media" with "Pig Image"
      And I press "Add block"
      And I wait for ajax to finish
      And I hover over the element ".block-inline-blocksimple-content-block > div:nth-child(2) > button:nth-child(1)"
      And I wait 2 seconds
      And I press "Open Behat Testing Image configuration options"
      And I click on the element with css selector ".layout-builder-block-move"
      And I wait for ajax to finish
      And I select "Section: 1, Region: Second" from "Region"
      And I wait for ajax to finish
      And I press "Move"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Text on LP"
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait for ajax to finish
      And I press "Add Text"
      And I wait for ajax to finish
      And I type "oral test assessor will verbally ask a question to a student, who will then answer it using words" in the "Text" WYSIWYG editor
      And I press "Add block"
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I press "Save layout"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@image_text_landing_page" tag
    When I click "Layout"
      And I wait for ajax to finish
      And I scroll ".layout-builder__region" into view
      And I hover over the element "div.layout-builder__region:nth-child(2) > div:nth-child(2) > div:nth-child(2) > button:nth-child(1)"
      And I wait 2 seconds
      And I press "Open Behat Testing Image configuration options"
      And I wait 2 seconds
      ##click on Move
      And I click on the element with css selector "div.layout-builder__region:nth-child(2) > div:nth-child(2) > div:nth-child(2) > ul:nth-child(2) > li:nth-child(2) > a"
      And I wait for ajax to finish
      And I select "Section: 1, Region: First" from "Region"
      And I wait for ajax to finish
      And I press "Move"
      And I wait for ajax to finish
      And I press "Save layout"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@text_image_landing_page" tag

  @ui @api @javascript @wdio
  Scenario: Add Edgar Search Featured Block Screenshot
    Given "landing" content:
      | title                       | body                                            | status | moderation_state | nid    |
      | Investor Behat Test Landing | investor behat body landing  http://www.abc.org | 1      | published        | 825034 |
    When I am logged in as a user with the "Content Approver" role
      And I am on "/node/825034"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I fill in "Filter by block name" with "Edgar"
      And I wait for ajax to finish
      And I click "Edgar Search block" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I uncheck the box "Display title"
      And I check the box "Feature Block"
      And I press the "Add block" button
      And I wait for ajax to finish
      And I scroll to the top
      And I select "Published" from "Change to"
      And I press "Save layout"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@edgar_search_block_landing_page" tag
