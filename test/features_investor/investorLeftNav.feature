Feature: Investor Left Navigation
  As a Content Creator, I want to be able to view left navigation on most of the pages
  so the users can navigate to the other pages from one page to other pages
 Able to see left navigation on pages (matching current D7 behavior)
 Able to click on the links appropriately

@api @javascript @investor
Scenario: Create Left Nav
  Given "article" content:
    | title                       | body                                            | status | moderation_state |
    | Investor Behat Test Article | Investor Behat Display Title http://www.123.org | 1      | published        |
    And I am logged in as a user with the "administrator" role
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Test Article" row
    And I fill in "Title" with "Investor Test"
    And I wait 3 seconds
    And I click secondary option "Menu settings"
    And I check "edit-menu-enabled"
    And I fill in "edit-menu-title" with "investor test"
    And I fill in "edit-menu-description" with "investor lef nav test"
    And I select "---- Investing Basics" from "edit-menu-menu-parent"
    And I click secondary option "URL alias"
    And I check "edit-path-0-pathauto"
    And I press the "Save" button
    And I should see the text "Article Investor Test has been updated."
    And I am on "/introduction-investing/basics/save-invest"
    And I should see the link "investor test" in the "left_nav_menu" region
    And I wait 2 seconds
    And I hover over the element "#investor-main-menu > .menu-index-1"
    And I click "investor test"
    And I wait 2 seconds
  Then I should see the text "INVESTOR TEST"
    And I should see the text "Investor Behat Display Title http://www.123.org"

@api @javascript @investor
Scenario: New link should not be visible on LeftNav when Menu settings check box link is not selected
  Given "article" content:
    | title                       | body                                            | status | moderation_state |
    | Investor Behat Test Article | Investor Behat Display Title http://www.abc.org | 1      | published        |
    And I am logged in as a user with the "administrator" role
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Test Article" row
    And I wait 3 seconds
    And I click secondary option "Menu settings"
    And I check "edit-menu-enabled"
    And I fill in "edit-menu-title" with "apple test"
    And I fill in "edit-menu-description" with "apple lef nav test"
    And I select "---- Investing Basics" from "edit-menu-menu-parent"
    And I click secondary option "URL alias"
    And I check "edit-path-0-pathauto"
    And I press the "Save" button
  Then I should see the text "Article Investor Behat Test Article has been updated."
  When I am on "/introduction-investing/basics/save-invest"
    And I should see the link "apple test" in the "left_nav_menu" region
    And I hover over the element "#investor-main-menu > .menu-index-1"
    And I click "apple test"
    And I wait 2 seconds
  Then I should see the text "Investor Behat Test Article"
    And I should see the text "Investor Behat Display Title http://www.abc.org"
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Test Article" row
    And I uncheck "edit-menu-enabled"
    And I press the "Save" button
  When I am on "/introduction-investing/basics/save-invest"
    And I should not see the link "apple test" in the "left_nav_menu" region
    And I hover over the element "#investor-main-menu > .menu-index-1"
  Then I should not see the link "apple test"
