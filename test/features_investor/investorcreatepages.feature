Feature: Create Pages
  As a Content Creator, I want to be able to create basic page
  So that visitors to investor.gov can learn about the investor

@api @javascript @investor
Scenario: Create a Basic Page
  Given I am logged in as a user with the "Content Creator" role
  When I am on "/node/add/page"
    And I fill in "Title" with "Behat Investor Test page"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Behat investor page test"
    And I type "Behat Display Title http://www.SEC.gov/" in the "Body" WYSIWYG editor
    And I press the "Save" button
  Then I should see the text "Behat Investor Test page"

@api @javascript @investor
Scenario: Edit Basic Page
  Given "page" content:
    | title                   | body                                    | status | moderation_state |
    | Edit Test Page Investor | Behat Display Title http://www.SEC.gov/ | 1      | published        |
    And I am logged in as a user with the "Content Approver" role
    And I run cron
    And I click "Investor.gov"
    And I fill in "Search Investor.gov" with "Edit Test Page Investor"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Edit Test Page Investor" in the maincontent region
  When I am on "/admin/content"
    And I click "Edit" in the "Edit Test Page Investor" row
    And I fill in "Title" with "Test Page Investor"
    And I type "Editing Behat Display Title http://www.SEC123.gov/" in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I am on "/"
    And I fill in "Search Investor.gov" with "Test Page Investor"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Test Page Investor" in the maincontent region
    And I click "Test Page Investor" in the maincontent region
    And I should see the text "Editing Behat Display Title http://www.SEC123.gov/"

@api @javascript @investor
Scenario: Delete Basic Page
  Given "page" content:
    | title                   | body                                    | status | moderation_state |
    | Edit Test Page Investor | Behat Display Title http://www.SEC.gov/ | 1      | published        |
    And I am logged in as a user with the "Content Approver" role
    And I run cron
    And I click "Investor.gov"
    And I fill in "Search Investor.gov" with "Edit Test Page Investor"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Edit Test Page Investor" in the maincontent region
  When I am on "/admin/content"
    And I click "Edit" in the "Edit Test Page Investor" row
    And I click "edit-delete"
    And I wait 2 seconds
    And I press "edit-submit"
  Then I should see the text "The Basic page Edit Test Page Investor has been deleted."

@api @javascript @investor
Scenario: Verify Texts are Showing Bold When Using Strong Tag for Page
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/page"
    And I fill in "Title" with "Testing ticket 13871"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I press "Bold" in the "Body" WYSIWYG Toolbar
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I scroll to the bottom
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Testing ticket 13871"
    And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div.layout.layout--threecol-25-50-25 > div.layout__region.layout__region--second > div.block.block-ctools-block.block-entity-fieldnodebody.block-title-body > div > p > strong" element
