@list
Feature: CorpFin Announcement List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

  @api @javascript
  Scenario: View the Corpfin Announcements List Page
    Given "secarticle" content:
      | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
      | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 2 | Jeff is Joining the SEC Team      | Test 2 | 2019-04-17T17:00:00 | 0      | Announcement                  | Corporation Finance           |
      | Behat Test 3 | Early Dismissal                   | Test 3 | 2018-06-12T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 4 | New Director of Enforcement Joins | Test 4 | 2017-11-22T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 5 | Impacts from the Road Closings    | Test 5 | 2017-01-08T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 6 | Team Picnic Planned               | Test 6 | 2016-09-01T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 7 | Open Under a 2-Hours Delay        | Test 7 | 2019-08-13T16:00:00 | 1      | Announcement                  | Corporation Finance           |
    When I visit "/corpfin/announcements"
    Then I should see the heading "Announcements by the Division of Corporation Finance"
      #list view should display link to announcement with display title as text
      And I should see the link "Donald is Leaving the Team Today"
      #list view should not display draft items
      And I should not see the link "Jeff is Joining the SEC Team"
      And I should see the link "Early Dismissal"
      And I should see the link "Impacts from the Road Closings"
      And I should see the link "Team Picnic Planned"
      #list view should display date
      And I should see the date "2020-06-05 17:00:00" in the "Donald is Leaving the Team Today" row
      And I should see the date "2018-06-12 17:00:00" in the "Early Dismissal" row
      And I should see the date "2017-01-08 17:00:00" in the "Impacts from the Road Closings" row
      #test show items per page and pagination
      And I select "5" from "edit-items-per-page"
    Then I should see the text "1 to 5 of 6 items"
      And I should see the link "Next"
      And I should see the link "Last"
      And I click "Last"
      And I should see the text "6 to 6 of 6 items"

  @api @javascript
  Scenario: Default Sorting for Corpfin Announcements List Page
    Given "secarticle" content:
      | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
      | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 2 | Jeff is Joining the SEC Team      | Test 2 | 2019-04-17T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 3 | Early Dismissal                   | Test 3 | 2018-06-12T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 4 | New Director of Enforcement Joins | Test 4 | 2017-11-22T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 5 | Impacts from the Road Closings    | Test 5 | 2017-01-08T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 6 | Team Picnic Planned               | Test 6 | 2016-09-01T17:00:00 | 1      | Announcement                  | Corporation Finance           |
    When I visit "/corpfin/announcements"
    Then I should see the text "June 5, 2020" in the "Donald is Leaving the Team Today" row
      And I should see the text "April 17, 2019" in the "Jeff is Joining the SEC Team" row
      And I should see the text "June 12, 2018" in the "Early Dismissal" row
      And I should see the text "Nov. 22, 2017" in the "New Director of Enforcement Joins" row
      And I should see the text "Jan. 8, 2017" in the "Impacts from the Road Closings" row
      And I should see the text "Sept. 1, 2016" in the "Team Picnic Planned" row
      And "Donald is Leaving the Team Today" should precede "Jeff is Joining the SEC Team" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Early Dismissal" should precede "New Director of Enforcement Joins" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Impacts from the Road Closings" should precede "Team Picnic Planned" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Sorting of Corpfin Announcements List Page by Date
    Given "secarticle" content:
      | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
      | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 2 | Jeff is Joining the SEC Team      | Test 2 | 2019-04-17T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 3 | Early Dismissal                   | Test 3 | 2018-06-12T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 4 | New Director of Enforcement Joins | Test 4 | 2017-11-22T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 5 | Impacts from the Road Closings    | Test 5 | 2017-01-08T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 6 | Team Picnic Planned               | Test 6 | 2016-09-01T17:00:00 | 1      | Announcement                  | Corporation Finance           |
    When I visit "/corpfin/announcements"
      And I click the sort filter "Date"
    Then "Team Picnic Planned" should precede "Impacts from the Road Closings" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "New Director of Enforcement Joins" should precede "Early Dismissal" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Jeff is Joining the SEC Team" should precede "Donald is Leaving the Team Today" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I click the sort filter "Date"
      And "Donald is Leaving the Team Today" should precede "Jeff is Joining the SEC Team" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Early Dismissal" should precede "New Director of Enforcement Joins" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Impacts from the Road Closings" should precede "Team Picnic Planned" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Sorting of Corpfin Announcements List Page by Title
    Given "secarticle" content:
      | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
      | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 2 | Jeff is Joining the SEC Team      | Test 2 | 2019-04-17T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 3 | Early Dismissal                   | Test 3 | 2018-06-12T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 4 | New Director of Enforcement Joins | Test 4 | 2017-11-22T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 5 | Impacts from the Road Closings    | Test 5 | 2017-01-08T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 6 | Team Picnic Planned               | Test 6 | 2016-09-01T17:00:00 | 1      | Announcement                  | Corporation Finance           |
    When I visit "/corpfin/announcements"
      And I click the sort filter "Title"
    Then "Donald is Leaving the Team Today" should precede "Early Dismissal" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Impacts from the Road Closings" should precede "Jeff is Joining the SEC Team" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "New Director of Enforcement Joins" should precede "Team Picnic Planned" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I click the sort filter "Title"
      And "Team Picnic Planned" should precede "New Director of Enforcement Joins" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Jeff is Joining the SEC Team" should precede "Impacts from the Road Closings" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Early Dismissal" should precede "Donald is Leaving the Team Today" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Filter Corpfin Announcements List Page by Year
    Given "secarticle" content:
      | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
      | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 2 | Jeff is Joining the SEC Team      | Test 2 | 2019-04-17T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 3 | Early Dismissal                   | Test 3 | 2018-06-12T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 4 | New Director of Enforcement Joins | Test 4 | 2017-11-22T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 5 | Impacts from the Road Closings    | Test 5 | 2017-01-08T17:00:00 | 1      | Announcement                  | Corporation Finance           |
      | Behat Test 6 | Team Picnic Planned               | Test 6 | 2016-09-01T17:00:00 | 1      | Announcement                  | Corporation Finance           |
    When I visit "/corpfin/announcements"
      And I select "2018" from "edit-year"
    Then I should see the link "Early Dismissal"
      And I should not see the link "Jeff is Joining the SEC Team"
      And I should not see the link "Team Picnic Planned"
      And I select "2017" from "edit-year"
      And I should see the link "New Director of Enforcement Joins"
      And I should see the link "Impacts from the Road Closings"
      And I should not see the link "Early Dismissal"
      And I should not see the link "Donald is Leaving the Team Today"
      And I select "2016" from "edit-year"
      And I should see the link "Team Picnic Planned"
      And I should not see the link "Donald is Leaving the Team Today"
      And I should not see the link "New Director of Enforcement Joins"
      And I select "2019" from "edit-year"
      And I should see the link "Jeff is Joining the SEC Team"
      And I should not see the link "Team Picnic Planned"
      And I should not see the link "Donald is Leaving the Team Today"
      And I select "2020" from "edit-year"
      And I should see the link "Donald is Leaving the Team Today"
      And I should not see the link "Jeff is Joining the SEC Team"
      And I should not see the link "Early Dismissal"

  @api @javascript
  Scenario: Verify PDF file opens when the link is clicked from the list view for corpfin
    Given I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file       | field_description_abstract | status |
      | Behat Test File | static file          | behat-file_corpfin.pdf | This is description abs    | 1      |
      And "secarticle" content:
      | title                                                                                 | field_display_title                                                                   | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file having article type as announcement and Corporate Finance as Division | Verify PDF file having article type as announcement and Corporate Finance as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
    When I am logged in as a user with the "content_approver" role
      And I visit "/admin/content"
      And I click "Edit" in the "Verify PDF file having article type as announcement and Corporate Finance as Division" row
      And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
      And I publish it
      And I am not logged in
      And I am on "/corpfin/announcements"
    Then I should see the text "Verify PDF file having article type as announcement and Corporate Finance as Division"
    When I click "Verify PDF file having article type as announcement and Corporate Finance as Division"
      And I wait 2 seconds
    Then I should be on "/files/behat-file_corpfin.pdf"
