Feature: Investor Navigation
  As a Content Creator, I want to be able to view left navigation on most of the pages
  so the users can navigate to the other pages from one page to other pages
 Able to see left navigation on pages (matching current D7 behavior)
 Able to click on the links appropriately

@api @javascript @ui @wdio
Scenario: Screenshot For Create Left Nav
  Given "article" content:
     | title                        | body                                             |  status | moderation_state |
     | Investor Behat Test Article  | Investor Behat Display Title http://www.123.org  |  1      | published        |
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
  Then I take a screenshot on "investor" using "leftNav.feature" file with "@create_new_left_nav" tag

@ui @wdio
Scenario: Element Screenshots of Breadcrumbs
  Given I am on "/"
  Then I take a screenshot on "investor" using "landingpage.feature" file with "@breadcrumb" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@breadcrumb_mobile" tag
