@list
Feature: EDGAR List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: Filegroup Announcement Missing
  Given "secarticle" content:
    | title                | field_display_title      | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_tags |
    | Behat EDGAR Filer  0 | Behat EDGAR Filer Test 0 | 2005-01-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  1 | Behat EDGAR Filer Test 1 | 2021-02-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  2 | Behat EDGAR Filer Test 2 | 2022-03-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  3 | Behat EDGAR Filer Test 3 | 2018-04-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  4 | Behat EDGAR Filer Test 4 | 2022-05-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  5 | Behat EDGAR Filer Test 5 | 2021-06-01 12:00:00 | 1      | Announcement                  | Information Technology        | filergroup |
    | Behat EDGAR Filer  6 | Behat EDGAR Filer Test 6 | 2020-07-01 12:00:00 | 1      | Other                         | Information Technology        | filergroup |
  When I visit "/filergroup/announcements"
  Then "Behat EDGAR Filer Test 4" should precede "Behat EDGAR Filer Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 2" should precede "Behat EDGAR Filer Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 5" should precede "Behat EDGAR Filer Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 1" should precede "Behat EDGAR Filer Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 3" should precede "Behat EDGAR Filer Test 0" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I should not see the link "Behat EDGAR Filer Test 6"
  When I click the sort filter "Date"
  Then "Behat EDGAR Filer Test 0" should precede "Behat EDGAR Filer Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 3" should precede "Behat EDGAR Filer Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 1" should precede "Behat EDGAR Filer Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 5" should precede "Behat EDGAR Filer Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 2" should precede "Behat EDGAR Filer Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "Behat EDGAR Filer Test 0" should precede "Behat EDGAR Filer Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 2" should precede "Behat EDGAR Filer Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 4" should precede "Behat EDGAR Filer Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "Behat EDGAR Filer Test 5" should precede "Behat EDGAR Filer Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 3" should precede "Behat EDGAR Filer Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat EDGAR Filer Test 1" should precede "Behat EDGAR Filer Test 0" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
