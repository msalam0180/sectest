@list
Feature: View Published Public Statements
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

  Background:

  Given "secperson" content:
    | title      | field_first_name_secperson | field_last_name_secperson | body                                    | field_enable_biography_page | status |
    | John Behat | John                       | Behat                     | John started working with behat in 2017 | 0                           | 1      |
    | Jane Behat | Jane                       | Behat                     | Jane started working with behat in 2018 | 0                           | 1      |
    | Dave Behat | Dave                       | Behat                     | Dave started working with behat in 2019 | 0                           | 1      |
    | Jack Behat | Jack                       | Behat                     | Jack started working with behat in 2016 | 0                           | 1      |

@api @javascript
Scenario: Create a Statement Through the UI
  Given "secperson" content:
    | title        | field_first_name_secperson | field_last_name_secperson | status |
    | Behat Tester | Jim                        | Behat                     | 1      |
    And I am logged in as a user with the "Content Creator" role
  When I am on "/node/add/news"
    And I select "Statement" from "News Type"
    And I fill in "Title" with "Behat News Content Test"
    And I fill in "Display Title" with "Behat Statement Test"
    And I fill in "Description/Abstract" with "This is a statement behat test"
    And I select the first autocomplete option for "Behat Tester" on the "Speaker" field
    And I press "Save and Create New Draft"
  Then I should see the heading "Behat Statement Test"
    And I should see the text "Jim Behat"

@api @javascript
Scenario: Ordering Speaker List For A Statement
  Given "secperson" content:
    | title    | field_first_name_secperson | field_last_name_secperson | status |
    | John Doe | John                       | Doe                       | 1      |
    | Jane Doe | Jane                       | Doe                       | 1      |
    | Jim Doe  | Jim                        | Doe                       | 1      |
    | Jack Doe | Jack                       | Doe                       | 1      |
    And I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/news"
    And I select "Statement" from "News Type"
    And I fill in "Title" with "Behat News Content Ordering Test"
    And I fill in "Display Title" with "Behat Statement Ordering Test"
    And I fill in "Description/Abstract" with "This is a statement behat test"
    And I select the first autocomplete option for "John Doe" on the "Speaker" field
    And I press the "field_person_add_more" button
    And I wait for ajax to finish
    And I select the first autocomplete option for "Jane Doe" on the "field_person[1][target_id]" field
    And I wait for ajax to finish
    And I press the "field_person_add_more" button
    And I wait for ajax to finish
    And I select the first autocomplete option for "Jim Doe" on the "field_person[2][target_id]" field
    And I wait for ajax to finish
    And I press the "field_person_add_more" button
    And I wait for ajax to finish
    And I select the first autocomplete option for "Jack Doe" on the "field_person[3][target_id]" field
    And I wait for ajax to finish
    And I press "Show row weights" in the "speakers" region
    # reorder the list of speakers
    And I select "2" from "field_person[1][_weight]"
    And I select "1" from "field_person[3][_weight]"
    And I select "3" from "field_person[2][_weight]"
    And I publish it
  Then I should see the heading "Behat Statement Ordering Test"
    And I should see "John Doe" followed by "Jack Doe"
    And I should see "Jack Doe" followed by "Jane Doe"
    And I should see "Jane Doe" followed by "Jim Doe"
  When I am not logged in
    And I visit "/news/speeches-statements"
  Then I should see the link "Behat Statement Ordering Test"
    And I should see "John Doe" followed by "Jack Doe"
    And I should see "Jack Doe" followed by "Jane Doe"
    And I should see "Jane Doe" followed by "Jim Doe"

@api @javascript
Scenario: HTML Formatting in Display Title field
  Given "secperson" content:
    | title        | field_first_name_secperson | field_last_name_secperson | status |
    | Behat Tester | Jim                       | Behat                     | 1      |
    And I am logged in as a user with the "content_creator" role
  When I am on "/node/add/news"
    And I select "Statement" from "News Type"
    And I fill in "Title" with "BEHAT Title"
    And I fill in "Display Title" with "<h1><strong>BEHAT Display Title in HTML</strong></h1>"
    And I fill in "Description/Abstract" with "This is a Statement behat test"
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I press "Save and Create New Draft"
  Then I should see "BEHAT Display Title in HTML" in the "h1:nth-child(2) > strong" element

@api @javascript
Scenario: View the Statements List Page
  Given I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | Behat File | behat-file_corpfin.pdf | 1      |
    And "news" content:
      | field_news_type_news | field_primary_division_office | title      | status | body                      | field_display_title     | field_publish_date  | field_release_number | field_speaker_name_and_title | field_media_file_upload |
      | Statement            | Agency-wide                   | First PS   | 1      | This is the first body.   | First Behat Statement   | 2018-09-11 12:00:00 | 2018-09              | John Behat                   | Behat File              |
      | Statement            | Agency-wide                   | Second PS  | 0      | This is the second body.  | Second Behat Statement  | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |                         |
      | Statement            | Agency-wide                   | Third PS   | 1      | This is the third body.   | Third Behat Statement   | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |                         |
      | Statement            | Agency-wide                   | Fourth PS  | 1      | This is the fourth body.  | Fourth Behat Statement  | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |                         |
      | Statement            | Agency-wide                   | Fifth PS   | 1      | This is the fifth body.   | Fifth Behat Statement   | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |                         |
      | Statement            | Agency-wide                   | Sixth PS   | 1      | This is the sixth body.   | Sixth Behat Statement   | 2018-03-11 12:00:00 | 2018-03              | John Behat                   |                         |
      | Statement            | Agency-wide                   | Seventh PS | 1      | This is the seventh body. | Seventh Behat Statement | 2018-04-11 12:00:00 | 2018-04              | John Behat                   |                         |
      | Statement            | Agency-wide                   | Seventh PS | 1      | This is the seventh body. | Seventh Behat Statement | 2018-04-11 12:00:00 | 2018-04              | John Behat                   |                         |
      | Statement            | Agency-wide                   | Ninth PS   | 1      |                           | Ninth Behat Statement   | 2018-04-11 12:00:00 | 2018-04              | John Behat                   | Behat File              |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    #list view should display link to statements with display title as text
    And I should see the link "First Behat Statement"
    And I should see the link "Ninth Behat Statement (PDF)"
    #list view should not display draft items
    And I should not see the link "Second Behat Statement"
    And I should see the link "Third Behat Statement"
    And I should see the link "Fourth Behat Statement"
    And I should see the link "Fifth Behat Statement"
    #list view should display date
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Statement" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Statement" row
    #list view should display speaker name
    And I should see the text "John Behat" in the "First Behat Statement" row
    And I should see the text "Jack Behat" in the "Fourth Behat Statement" row
    And I should see the text "John Behat" in the "Fifth Behat Statement" row
    #dates should be grouped by month and display under a month banner
    And I should see "First Behat Statement" under the "2018-09-11 12:00:00" month banner
    And I should see "Fifth Behat Statement" under the "2018-02-11 12:00:00" month banner
    And I should see the text "Showing 1 to 8 of 8 entries"

@api @javascript
Scenario: Default Sorting for Statements List Page
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Statement" row
    And I should see the date "2018-07-10 12:00:00" in the "Second Behat Statement" row
    And I should see the date "2017-06-13 12:00:00" in the "Third Behat Statement" row
    And I should see the date "2019-05-11 12:00:00" in the "Fourth Behat Statement" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Statement" row
    #dates should be grouped by month and display under a month banner
    And I should see "First Behat Statement" under the "2018-09-11 12:00:00" month banner
    And I should see "Second Behat Statement" under the "2018-07-10 12:00:00" month banner
    And I should see "Third Behat Statement" under the "2017-06-13 12:00:00" month banner
    And I should see "Fourth Behat Statement" under the "2019-05-11 12:00:00" month banner
    And I should see "Fifth Behat Statement" under the "2018-02-11 12:00:00" month banner
    And "Fourth Behat Statement" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Fifth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Statement" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Statements by Date
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Date"
  Then "Third Behat Statement" should precede "Fifth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Statement" should precede "Fourth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Date"
    And "Fourth Behat Statement" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Fifth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Statement" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Statements by Title
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Title"
  Then "Fifth Behat Statement" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth Behat Statement" should precede "Second Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Title"
    And "Third Behat Statement" should precede "Second Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Fourth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Statement" should precede "Fifth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Statements by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Speaker"
  Then "Third Behat Statement" should precede "Fourth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Speaker"
    And "First Behat Statement" should precede "Second Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth Behat Statement" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Statements Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title | field_person |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2017-09-11 12:00:00 | 2017-09              | John Behat                   | John Behat   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |              |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |              |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |              |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   | John Behat   |
  When I am on "/news/speeches-statements"
    And I fill in "John Behat" for "edit-field-person-target-id"
    And I wait for ajax to finish
    And I select "2018" from "edit-year"
    And I wait for ajax to finish
  Then I should see the link "Fifth Behat Statement"
    And I should not see the link "First Behat Statement"
    And I select "2017" from "edit-year"
    And I wait for ajax to finish
    And I should not see the link "Fifth Behat Statement"
    And I should see the link "First Behat Statement"

@api @javascript
Scenario: Filter Statements by Year
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I wait for ajax to finish
  Then I should see the link "First Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Statement"
    And I should see the link "Second Behat Statement"
    And I should see the link "Fifth Behat Statement"
    And I select "2017" from "edit-year"
    And I wait for ajax to finish
    And I should see the link "Third Behat Statement"
    And I should not see the link "Second Behat Statement"
    And I select "2019" from "edit-year"
    And I wait for ajax to finish
    And I should see the link "Fourth Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Second Behat Statement"

@api @javascript
Scenario: Filter Statements by Month
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Statement            | Agency-wide                   | First PS  | 1      | This is the first body.  | First Behat Statement  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second PS | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third PS  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth PS | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jack Behat                   |
    | Statement            | Agency-wide                   | Fifth PS  | 1      | This is the fifth body.  | Fifth Behat Statement  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I wait for ajax to finish
    And I select "September" from "Month"
    And I wait for ajax to finish
  Then I should see the link "First Behat Statement"
    And I should not see the link "Second Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Fifth Behat Statement"
  When I select "July" from "Month"
    And I wait for ajax to finish
  Then I should not see the link "First Behat Statement"
    And I should see the link "Second Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Fifth Behat Statement"
  When I select "February" from "Month"
    And I wait for ajax to finish
  Then I should not see the link "First Behat Statement"
    And I should not see the link "Second Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Statement"
    And I should see the link "Fifth Behat Statement"
  When I select "2019" from "edit-year"
    And I wait for ajax to finish
    And I select "May" from "Month"
    And I wait for ajax to finish
  Then I should not see the link "First Behat Statement"
    And I should not see the link "Second Behat Statement"
    And I should not see the link "Third Behat Statement"
    And I should see the link "Fourth Behat Statement"
    And I should not see the link "Fifth Behat Statement"
  When I select "2017" from "edit-year"
    And I wait for ajax to finish
    And I select "June" from "Month"
    And I wait for ajax to finish
  Then I should not see the link "First Behat Statement"
    And I should not see the link "Second Behat Statement"
    And I should see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Fifth Behat Statement"
