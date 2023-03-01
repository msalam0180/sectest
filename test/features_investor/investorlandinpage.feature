Feature: Investor Home Page and Landing page
  As a Site Visitor, the user should be able to navigate to investor.gov home page and will be able to access Utility menu, Header

  Background:

    Given I create "media" of type "image":
      | name      | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Pig Image | behat-gold-pig.png | some alt txt          | 222229 | publication      |
      And "landing" content:
        | title              |
        | BEHAT Landing Page |

  @api @investor
  Scenario: Verify All Utility Menu On The Home Page
    Given I am on "/"
    Then I should see the text "About Us"
      And I click "About Us"
      And I should see the text "About Us"
    Then I should see the text "Contact Us"
      And I click "Contact Us"
      And I should see the text "Contact Us"
    Then I should see the text "Follow Us"
      And I click "Follow Us"
      And I should see the text "Follow Us"
    Then I should see the text "Información en Español"
      And I click "Información en Español"
      And I should see the text "Información en Español"

  @api @investor
  Scenario: Verify Header Menu On The Home Page
    Given I am on "/"
    Then I should see the text "Introduction To Investing"
      And I should see the text "Financial Tools & Calculators"
      And I should see the text "Protect Your Investments"
      And I should see the text "Additional Resources"

  @api @investor
  Scenario: Investor Landing Page Item Blocks
    Given I am on "/"
    Then I should see the text "Investor.gov"
      And I should see the text "Featured Information"
      And I should see the text "Investor Alerts And Bulletins"
      And I should see the text "Get Help"
      And I should see the text "Required Minimum Distribution Calculator"
      And I should see the text "More Financial Planning Tools"
      And I should see the text "Compound Interest Calculator"

  @api @investor
  Scenario: Investor Blocks on Financial Planning Tools Page
    Given I am on "/free-financial-planning-tools"
    Then I should see the text "Required Minimum Distribution Calculator"
      And I should see the text "Compound Interest Calculator"
      And I should see the text "Social Security Retirement Estimator"
      And I should see the text "Retirement Ballpark Estimator"
      And I should see the text "Mutual Fund Analyzer"
      And I should see the text "529 Expense Analyzer"

  @api @javascript @investor
  Scenario: Verify Government Banner
    Given I am on "/"
      And I click on the element with css selector ".usa-banner__button-text"
    Then I should see the text "An official website of the United States government"
      And I should see the button "Here’s how you know"
      And I should see the text "The .gov means it’s official"
      And I should see the text "The site is secure."
    When I am on "/introduction-investing/investing-basics/glossary"
      And I press the "Here’s how you know" button
    Then I should see the text "An official website of the United States government"
      And I should see the text "The .gov means it’s official"
      And I should see the text "The site is secure."
    When I am on "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
      And I press the "Here’s how you know" button
    Then I should see the text "An official website of the United States government"
      And I should see the text "The .gov means it’s official"
      And I should see the text "The site is secure."
    When I am on "/financial-tools-calculators/calculators/compound-interest-calculator"
      And I press the "Here’s how you know" button
    Then I should see the text "An official website of the United States government"
      And I should see the text "The .gov means it’s official"
      And I should see the text "The site is secure."

  @api @javascript @investor
  Scenario: Create Landing Page Using UI
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/landing"
      And I fill in "Title" with "Investor Behat Landing page"
      And I type "Investor Behat Display Body" in the "Body" WYSIWYG editor
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "edit-submit" button
      And I visit "/Investor-Behat-Landing-page"
    Then I should see the heading "Investor Behat Landing page"
      And I should see the text "Investor Behat Display Body"

  @api @investor
  Scenario: Delete Landing Page
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
      | title                       | body                                            | status | moderation_state | nid |
      | Investor Behat Test Landing | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
    When I am on "/node/123/delete"
    Then I should see the text "Investor Behat Test Landing"
    When I press "Delete"
    Then I am on "/Investor-Behat-Test-Landing"
    Then I should see the text "Page not found"
    When I am on "/node/123"
    Then I should see the text "Page not found"

  @api @investor
  Scenario: Hide Landing Page Title
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
      | title                       | body                                            | status | moderation_state | nid |
      | Investor Behat Test Landing | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
    When I am on "/node/123/edit"
      And I check "Hide Page Title"
      And I press the "edit-submit" button
      And I am on "/Investor-Behat-Test-Landing"
    Then I should not see title
      And I should see the text "Investor Behat Body Landing"

  @api @investor
  Scenario: Edit Landing Page Title
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
      | title                       | body                                            | status | moderation_state | nid |
      | Investor Behat Test Landing | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
    When I am on "/Investor-Behat-Test-Landing"
    Then I should see the heading "Investor Behat Test Landing"
      And I should see the text "Investor Behat Body Landing"
    When I am on "/node/123/edit"
      And I fill in "Title" with "Update Behat Landing page"
      And I press the "edit-submit" button
      And I am on "/Investor-Behat-Test-Landing"
    Then I should see the heading "Update Behat Landing page"
      And I should see the text "Investor Behat Body Landing"

  @api @javascript @investor
  Scenario: Adding Button Block To Landing Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-wrapper"
      And I wait 2 seconds
      And I fill in "URL" with "/files/pig-image"
      And I fill in "Link text" with "LP Block"
      And I wait 1 seconds
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "The layout override has been saved."
      And I should see the heading "BEHAT Landing Page"
      And I should see the text "Behat Testing Block"
    When I click "LP Block"
    Then I should see the heading "Pig Image"

  @api @javascript @investor
  Scenario: Adding Link To Custom Content Block On Landing Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Link on LP"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait 1 seconds
      And I press "Add Link"
      And I wait for ajax to finish
      And I fill in "URL" with "/files/pig-image"
      And I fill in "Link text" with "Goldy"
      And I type "Investor Behat Link on the Landing Page is easy to add now.Stop watch timing was the norm until recent years when hand timing has been proven to be inaccurate and inconsistent" in the "Description" WYSIWYG editor
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I should see the heading "BEHAT Landing Page"
      And I should see the text "Behat Testing Link on LP"
      And I should see the link "Goldy"
    When I click "Goldy"
    Then I should see the heading "Pig Image"

  @api @javascript @investor
  Scenario: Adding Text to Custom Content Block On Landing Page And Hide Display Title
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Text on LP"
      And I wait 2 seconds
      And I uncheck "Display title"
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait for ajax to finish
      And I press "Add Text"
      And I wait for ajax to finish
      And I type "oral test assessor will verbally ask a question to a student, who will then answer it using words" in the "Text" WYSIWYG editor
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I should see the heading "BEHAT Landing Page"
      And I should not see the heading "Behat Testing Text on LP"
      And I should see the text "oral test assessor will verbally ask a question to a student, who will then answer it using words"

  @api @javascript @investor
  Scenario: Editing Button Block On Landing Page
    Given I am logged in as a user with the "Site Builder" role
      And I create "media" of type "image":
        | name      | field_media_image  | field_media_image_alt | mid   | moderation_state |
        | Block pig | behat-gold-pig.png | some alt txt          | 12345 | publication      |
        | Parrot    | behat-bird.gif     | some alt txt          | 12346 | publication      |
    When I am on "/block/add/simple_content_block"
      And I fill in "Block description" with "Behat content Block"
      And I click on the element with css selector ".dropbutton-wrapper"
      And I wait 2 seconds
      And I fill in "URL" with "/files/block-pig"
      And I fill in "Link text" with "LP Block"
      And I select "Alternate 1" from "Theme"
      And I select "Large" from "Size"
      And I wait for ajax to finish
      And I press "Save"
      And I am logged in as a user with the "Content Approver" role
      And I am on "/Behat-Landing-Page"
      And I wait 2 seconds
      And I click "Layout"
      And I wait 2 seconds
      And I click "Add block"
      And I wait for ajax to finish
      And I fill in "Filter by block name" with "Behat"
      And I click "Behat content Block" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I press the "Add block" button
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "The layout override has been saved."
      And I should see the heading "BEHAT Landing Page"
      And I should see the link "LP Block"
    When I click "LP Block"
      And I wait 1 seconds
    Then I should see the heading "Block pig"
    When I am logged in as a user with the "Site Builder" role
      And I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Behat content Block" row
      And I fill in "Block description" with "Behat content Block updated"
      And I fill in "URL" with "/files/parrot"
      And I fill in "Link text" with "Updated: LP Block"
      And I select "Alternate 2" from "Theme"
      And I select "Regular" from "Size"
      And I wait for ajax to finish
      And I press "Save"
      And I wait 1 seconds
    Then I should see the text "Content Block Behat content Block updated has been updated."
    When I am on "/"
      And I fill in "Search Investor.gov" with "BEHAT Landing Page"
      And I click on the element with css selector "#edit-submit-search-content"
      And I wait 2 seconds
      And I should see the link "BEHAT Landing Page" in the maincontent region
      And I click "BEHAT Landing Page" in the maincontent region
      And I should see the link "Updated: LP Block"
      And I should see the text "BEHAT Landing Page"
      And I click "Updated: LP Block"
      And I wait 1 seconds
    Then I should see the heading "Parrot"
    When I am on "/admin/structure/block/block-content"
      And I wait 1 seconds
      And I click "Edit" in the "Behat content Block updated" row
      And I click on the element with css selector "#edit-delete"
      And I press "Delete"
    Then I should see the text "The custom block Behat content Block updated has been deleted."

  @api @javascript @investor
  Scenario: Removing Text Custom Block From Landing Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I wait 1 seconds
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Text on LP"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait 2 seconds
      And I press "Add Text"
      And I wait 2 seconds
      And I type "oral test assessor will verbally ask a question to a student, who will then answer it using words" in the "Text" WYSIWYG editor
      And I press "Add block"
      And I wait for ajax to finish
      And I scroll ".layout-builder__region" into view
      And I click on the element with css selector "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blocksimple-content-block.block-wrapper-.block-spacing- > div > button"
      And I click on the element with css selector "div.js-layout-builder-block:nth-child(5) > div:nth-child(2) > ul:nth-child(2) > li:nth-child(3) > a:nth-child(1)"
      And I wait for ajax to finish
      And I press "Remove"
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I click on the element with css selector "#edit-submit"
    Then I should not see the text "Behat Testing Text on LP"

  @api @javascript @investor
  Scenario: Adding Image To Custom Content Block On Landing Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/admin/content/media"
      And I click "Edit" in the "Pig Image" row
      And I fill in "Alternative text" with "Piggy"
      And I fill in "Caption" with "Golden Piglet"
      And I wait for ajax to finish
      And I press "Save"
      And I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Content Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Image on LP"
      And I wait 2 seconds
      And I click on the element with css selector ".dropbutton-arrow"
      And I wait 1 seconds
      And I press "Add Image"
      And I wait for ajax to finish
      And I fill in "Use existing media" with "Pig Image"
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I scroll to the top
      And I press "Save layout"
    Then I should see the text "The layout override has been saved."
      And I should see the text "BEHAT Landing Page"
      And I should see the "img" element with the "alt" attribute set to "Piggy" in the "landingpage_img" region

  @api @javascript @investor
  Scenario: Adding Image Text To Landing Page And Shifting Blocks
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I wait 2 seconds
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
      And I hover over the element "#layout-builder > div:nth-child(3) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region--first"
      And I click on the element with css selector "#layout-builder > div:nth-child(3) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region--first div > button"
      And I click on the element with css selector ".block-inline-blocksimple-content-block > div:nth-child(2) > ul:nth-child(2) > li:nth-child(2) > a:nth-child(1)"
      And I wait for ajax to finish
      And I select "Section: 1, Region: Second" from "Region"
      And I wait for ajax to finish
      And I press "Move"
      And I wait for ajax to finish
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
    Then I should see the text "BEHAT Landing Page"
      And "Behat Testing Text on LP" should precede "Behat Testing Image" for the query "//h2"
    When I click "Layout"
      And I wait for ajax to finish
      And I scroll ".layout-builder__region" into view
      And I hover over the element "#layout-builder > div:nth-child(2) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region"
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region div button"
      And I click on the element with css selector ".layout__region--first > div:nth-child(2) > div:nth-child(2) > ul:nth-child(2) > li:nth-child(2) > a:nth-child(1)"
      And I wait for ajax to finish
      And I select "Section: 1, Region: First" from "Region"
      And I wait for ajax to finish
      And I press "Move"
      And I wait for ajax to finish
      And I scroll ".layout-builder__region" into view
      And I hover over the element "#layout-builder > div:nth-child(3) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region--first"
      And I click on the element with css selector "#layout-builder > div:nth-child(3) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region--first div > button"
      And I click on the element with css selector ".layout__region--first > div:nth-child(2) > div:nth-child(2) > ul:nth-child(2) > li:nth-child(2) > a:nth-child(1)"
      And I wait for ajax to finish
      And I select "Section: 1, Region: Second" from "Region"
      And I wait for ajax to finish
      And I press "Move"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I wait 2 seconds
      And I press "Save layout"
    Then "Behat Testing Image" should precede "Behat Testing Text on LP" for the query "//h2"

  @api @javascript @investor
  Scenario: Verify Texts are Showing Bold When Using Strong Tag for Landing Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/landing"
      And I fill in "Title" with "Behat Test Title"
      And I fill in "Title" with "Testing ticket 13871"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Article"
      And I press "Bold" in the "Body" WYSIWYG Toolbar
      And I type "Testing body" in the "Body" WYSIWYG editor
      And I scroll to the bottom
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "Save" button
    Then I should see the text "Testing ticket 13871"
      And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div > div > div.block.block-layout-builder.block-field-blocknodelandingbody.block-title- > div > p > strong" element

@api @javascript @investor
Scenario Outline: Add Edgar Search Featured Block Using Layout Builder
  Given "landing" content:
    | title                       | body                                            | status | moderation_state | nid    |
    | Investor Behat Test Landing | investor behat body landing  http://www.abc.org | 1      | published        | 825034 |
  When I am logged in as a user with the "<role>" role
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
    And I select "<status_change>" from "Change to"
    And I press "Save layout"
  Then I should see the text "The layout override has been saved."
    And I should see the link "EDGAR"
    And the hyperlink "EDGAR" should match the Drupal url "https://www.sec.gov/edgar/searchedgar/webusers.htm"
    And I should see the text "Search company and individual filings."
  When I fill in "Name or Ticker" with "ACN"
    And I wait 1 seconds
    And I press "edgar-search-button"
  Then I should see the text "EDGAR Search Results"
    And I should see the text 'Companies with names matching "ACN"'

   Examples:
    | role                          | status_change |
    | Content Creator               | Draft         |
    | Content Approver              | Published     |
    | Content Creator, Site Builder | Draft         |
    | Administrator                 | Published     |
