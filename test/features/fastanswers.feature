@list
Feature: Fast Answers List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Fast Answers List Page
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | title                | field_display_title       | changed   | status | field_article_type_secarticle | field_primary_division_office | field_media_file_upload |
      | Bahat Fast Answers 0 | Behat Fast Answers Test 0 | +1 month  | 1      | Fast Answers                  | Corporation Finance           | Behat File              |
      | Bahat Fast Answers 1 | Behat Fast Answers Test 1 | -3 month  | 0      | Fast Answers                  | Corporation Finance           |                         |
      | Bahat Fast Answers 2 | Behat Fast Answers Test 2 | +2 day    | 1      | Fast Answers                  | Corporation Finance           |                         |
      | Bahat Fast Answers 3 | Behat Fast Answers Test 3 | +11 month | 1      | Fast Answers                  | Corporation Finance           |                         |
      | Bahat Fast Answers 4 | Behat Fast Answers Test 4 | +90 day   | 1      | Fast Answers                  | Corporation Finance           |                         |
      | Bahat Fast Answers 5 | Behat Fast Answers Test 5 | +2 year   | 1      | Fast Answers                  | Corporation Finance           |                         |
  When I visit "/fast-answers"
  Then I should see the heading "Fast Answers - Key Topics"
    #list view should display link to announcement with display title as text
    And I should see the link "Behat Fast Answers Test 0 (PDF)"
    #list view should not display draft items
    And I should not see the link "Behat Fast Answers Test 1"
    And I should see the link "Behat Fast Answers Test 3"
    And I should see the link "Behat Fast Answers Test 4"
    And I should see the link "Behat Fast Answers Test 5"
    #list view should display date
    And I should see the date "+1 month" in the "Behat Fast Answers Test 0 (PDF)" row
    And I should see the date "+2 day" in the "Behat Fast Answers Test 2" row
    And I should see the date "+11 month" in the "Behat Fast Answers Test 3" row
    And I should see the date "+90 day" in the "Behat Fast Answers Test 4" row
    And I should see the date "+2 year" in the "Behat Fast Answers Test 5" row

@api @javascript
Scenario: Default Sorting for Fast Answers List Page
  Given "secarticle" content:
    | title                | field_display_title       | changed   | status | field_article_type_secarticle | field_primary_division_office |
    | Bahat Fast Answers 0 | Behat Fast Answers Test 0 | +1 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 1 | Behat Fast Answers Test 1 | -3 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 2 | Behat Fast Answers Test 2 | +8 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 3 | Behat Fast Answers Test 3 | +11 month | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 4 | Behat Fast Answers Test 4 | +90 day   | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 5 | Behat Fast Answers Test 5 | +2 year   | 1      | Fast Answers                  | Corporation Finance           |
  When I visit "/fast-answers"
  Then "Behat Fast Answers Test 0" should precede "Behat Fast Answers Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 2" should precede "Behat Fast Answers Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 4" should precede "Behat Fast Answers Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Fast Answers List Page by Title
  Given "secarticle" content:
    | title                | field_display_title       | changed   | status | field_article_type_secarticle | field_primary_division_office |
    | Bahat Fast Answers 0 | Behat Fast Answers Test 0 | +1 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 1 | Behat Fast Answers Test 1 | -3 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 2 | Behat Fast Answers Test 2 | +8 month  | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 3 | Behat Fast Answers Test 3 | +11 month | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 4 | Behat Fast Answers Test 4 | +90 day   | 1      | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 5 | Behat Fast Answers Test 5 | +2 year   | 1      | Fast Answers                  | Corporation Finance           |
  When I visit "/fast-answers"
  Then I click the sort filter "Title"
    And "Behat Fast Answers Test 5" should precede "Behat Fast Answers Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 3" should precede "Behat Fast Answers Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 1" should precede "Behat Fast Answers Test 0" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Title"
    And "Behat Fast Answers Test 0" should precede "Behat Fast Answers Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 2" should precede "Behat Fast Answers Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 4" should precede "Behat Fast Answers Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Fast Answers List Page by Last Updated
  Given "secarticle" content:
    | title                | field_display_title       | status | field_article_type_secarticle | field_primary_division_office | field_publish_date  | field_date          |
    | Bahat Fast Answers 0 | Behat Fast Answers Test 0 | 1      | Fast Answers                  | Corporation Finance           | 2017-12-05T17:00:00 | 2019-03-19T17:00:00 |
    | Bahat Fast Answers 1 | Behat Fast Answers Test 1 | 1      | Fast Answers                  | Corporation Finance           | 2018-01-02T17:00:00 | 2019-04-19T17:00:00 |
    | Bahat Fast Answers 2 | Behat Fast Answers Test 2 | 1      | Fast Answers                  | Corporation Finance           | 2018-03-05T17:00:00 | 2019-05-19T17:00:00 |
    | Bahat Fast Answers 3 | Behat Fast Answers Test 3 | 1      | Fast Answers                  | Corporation Finance           | 2018-07-09T17:00:00 | 2019-06-19T17:00:00 |
    | Bahat Fast Answers 4 | Behat Fast Answers Test 4 | 1      | Fast Answers                  | Corporation Finance           | 2018-11-13T17:00:00 | 2019-07-19T17:00:00 |
    | Bahat Fast Answers 5 | Behat Fast Answers Test 5 | 1      | Fast Answers                  | Corporation Finance           | 2019-03-15T17:00:00 | 2019-08-19T17:00:00 |
  When I visit "/fast-answers"
    And I click the sort filter "Last Updated"
  Then "Behat Fast Answers Test 0" should precede "Behat Fast Answers Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 2" should precede "Behat Fast Answers Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 4" should precede "Behat Fast Answers Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Last Updated"
    And "Behat Fast Answers Test 5" should precede "Behat Fast Answers Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 3" should precede "Behat Fast Answers Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Behat Fast Answers Test 1" should precede "Behat Fast Answers Test 0" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript @insulated
Scenario: Filter Fast Answers List Page by Keyword
  Given "secarticle" content:
    | title                | field_display_title               | changed   | status | field_description_abstract    | field_article_type_secarticle | field_primary_division_office |
    | Bahat Fast Answers 0 | Behat Fast Answers Test One       | +1 month  | 1      | Faster Than a Speeding Bullet | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 1 | Behat Fast Answers Test Two       | -3 month  | 1      | Faster Than Speed of Light    | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 2 | Behat Fast Answers Test Three     | +8 month  | 1      | Faster Than Lightning         | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 3 | Behat Fast Answers Test Four      | +11 month | 1      | Faster Than Speed of Sound    | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 4 | Behat Fast Answers Test Five      | +90 day   | 1      | Faster Than Usual             | Fast Answers                  | Corporation Finance           |
    | Bahat Fast Answers 5 | Behat Fast Answers Test Fifty-One | +2 year   | 1      | Faster Than Usain Bolt        | Fast Answers                  | Corporation Finance           |
  When I visit "/fast-answers"
    And I fill in "listSearch" with "Speed"
    And I wait for Ajax to finish
  Then I should see the text "Faster Than a Speeding Bullet"
    And I should see the text "Faster Than Speed of Light"
    And I should see the text "Faster Than Speed of Sound"
    And I should not see the text "Faster Than Usain Bolt"
    And I should not see the text "Faster Than Lightning"
    And I should not see the text "Faster Than Usual"
    And I fill in "listSearch" with "One"
    And the search results should show the link "Behat Fast Answers Test One"
    And the search results should show the link "Behat Fast Answers Test Fifty-One"
    And the search results should not show the link "Behat Fast Answers Test Two"
    And the search results should not show the link "Behat Fast Answers Test Three"
    And the search results should not show the link "Behat Fast Answers Test Four"
    And the search results should not show the link "Behat Fast Answers Test Five"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for fast answer
  Given I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file       | field_description_abstract | status |
      | Behat Test File | static file          | behat-file_fanswer.pdf | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                                                 |  field_display_title                                                                   | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file having article type as Fast Answers and Corporate Finance as Division |  Verify PDF file having article type as Fast Answers and Corporate Finance as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as Fast Answers and Corporate Finance as Division" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
    And I publish it
    And I am not logged in
    And I am on "/fast-answers"
  Then I should see the link "Verify PDF file having article type as Fast Answers and Corporate Finance as Division"
  When I click "Verify PDF file having article type as Fast Answers and Corporate Finance as Division"
    And I wait 2 seconds
  Then I should be on "/files/behat-file_fanswer.pdf"
