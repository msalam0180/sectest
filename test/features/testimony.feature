Feature: View Published Testimonies
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

  Background:

  Given "secperson" content:
    | title      | field_first_name_secperson | field_last_name_secperson | body                                    | field_enable_biography_page | status |
    | John Behat | John                       | Behat                     | John started working with behat in 2017 | 0                           | 1      |
    | Jane Behat | Jane                       | Behat                     | Jane started working with behat in 2018 | 0                           | 1      |
    | Dave Behat | Dave                       | Behat                     | Dave started working with behat in 2019 | 0                           | 1      |
    | Adam Behat | Adam                       | Behat                     | Adam started working with behat in 2016 | 0                           | 1      |
    | Mike Behat | Mike                       | Behat                     | Mike started working with behat in 2016 | 0                           | 1      |
    | Lisa Behat | Lisa                       | Behat                     | Lisa started working with behat in 2016 | 0                           | 1      |

@api @javascript
Scenario: Create a Testimony Through the UI
  Given "secperson" content:
    | title        | field_first_name_secperson | field_last_name_secperson | status |
    | Behat Tester | Jim                        | Behat                     | 1      |
    And I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/news"
    And I select "Testimony" from "News Type"
    And I fill in "Title" with "Behat News Content Test"
    And I fill in "Display Title" with "Behat Testimony Test"
    And I fill in "Description/Abstract" with "This is a testimony behat test"
    And I select the first autocomplete option for "Behat Tester" on the "Speaker" field
    And I publish it
  Then I should see the heading "Behat Testimony Test"
    And I should see "Jim Behat"

@api @javascript
Scenario: View Testimonies
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title      | status | body                      | field_display_title     | field_publish_date  | field_release_number | field_speaker_name_and_title | field_alternate_title_secarticle                              |
    | Testimony            | Agency-wide                   | First TM   | 1      | This is the first body.   | First Behat Testimony   | 2018-09-11 12:00:00 | 2018-09              | John Behat                   | <u>RSS</u> <em>Testimony Filer Test</em> <strong>0@0</strong> |
    | Testimony            | Agency-wide                   | Second TM  | 0      | This is the second body.  | Second Behat Testimony  | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Third TM   | 1      | This is the third body.   | Third Behat Testimony   | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Fourth TM  | 1      | This is the fourth body.  | Fourth Behat Testimony  | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Fifth TM   | 1      | This is the fifth body.   | Fifth Behat Testimony   | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Sixth TM   | 1      | This is the sixth body.   | Sixth Behat Testimony   | 2019-06-11 12:00:00 | 2019-06              | Dave Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Seventh TM | 1      | This is the seventh body. | Seventh Behat Testimony | 2018-03-11 12:00:00 | 2018-03              | Adam Behat                   |                                                               |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    #list view should display link to testimony with display title as text
    And I should see the link "RSS Testimony Filer Test 0@0"
    #list view should not display draft items
    And I should not see the link "Second Behat Testimony"
    And I should see the link "Third Behat Testimony"
    And I should see the link "Fourth Behat Testimony"
    And I should see the link "Fifth Behat Testimony"
    #list view should display date
    And I should see the date "2018-09-11 12:00:00" in the "RSS Testimony Filer Test 0@0" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Testimony" row
    #list view should display speaker name
    And I should see the text "John Behat" in the "RSS Testimony Filer Test 0@0" row
    And I should see the text "Lisa Behat" in the "Fourth Behat Testimony" row
    And I should see the text "John Behat" in the "Fifth Behat Testimony" row
    #dates should be grouped by month and display under a month banner
    And I should see "RSS Testimony Filer Test 0@0" under the "2018-09-11 12:00:00" month banner
    And I should see "Fifth Behat Testimony" under the "2018-02-11 12:00:00" month banner
    And I should see the text "Showing 1 to 6 of 6 entries"

@api @javascript
Scenario: Default Sorting for Testimonies
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Testimony" row
    And I should see the date "2018-07-10 12:00:00" in the "Second Behat Testimony" row
    And I should see the date "2017-06-13 12:00:00" in the "Third Behat Testimony" row
    And I should see the date "2019-05-11 12:00:00" in the "Fourth Behat Testimony" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Testimony" row
    #dates should be grouped by month and displayed under a month banner
    And I should see "First Behat Testimony" under the "2018-09-11 12:00:00" month banner
    And I should see "Second Behat Testimony" under the "2018-07-10 12:00:00" month banner
    And I should see "Third Behat Testimony" under the "2017-06-13 12:00:00" month banner
    And I should see "Fourth Behat Testimony" under the "2019-05-11 12:00:00" month banner
    And I should see "Fifth Behat Testimony" under the "2018-02-11 12:00:00" month banner
    And "Fourth Behat Testimony" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Testimony" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Testimony by Date
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Date"
  Then "Third Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Testimony" should precede "Fourth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Date"
  Then "Fourth Behat Testimony" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Testimony" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Testimony by Title
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Title"
  Then "Fifth Behat Testimony" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth Behat Testimony" should precede "Second Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "Third Behat Testimony" should precede "Second Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fourth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Testimony by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Speaker"
  Then "Fifth Behat Testimony" should precede "Second Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth Behat Testimony" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Speaker"
  Then "Third Behat Testimony" should precede "Fourth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Testimony by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title | field_person |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2017-09-11 12:00:00 | 2017-09              | John Behat                   | John Behat   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |              |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |              |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |              |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   | John Behat   |
  When I am on "/news/speeches-statements"
    And I fill in "John Behat" for "edit-field-person-target-id"
    And I wait for AJAX to finish
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
  Then I should see the link "Fifth Behat Testimony"
    And I should not see the link "First Behat Testimony"
    And I should not see the link "Second Behat Testimony"
  When I select "2017" from "edit-year"
  Then I should not see the link "Fifth Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should see the link "First Behat Testimony"

@api @javascript
Scenario: Filter Testimony by Year
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
  Then I should see the link "First Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should see the link "Second Behat Testimony"
    And I should see the link "Fifth Behat Testimony"
  When I select "2017" from "edit-year"
  Then I should see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Second Behat Testimony"
  When I select "2019" from "edit-year"
  Then I should see the link "Fourth Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "First Behat Testimony"

@api @javascript
Scenario: Filter Testimony by Month
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Mike Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I select "September" from "Month"
  Then I should see the link "First Behat Testimony"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Testimony"
  When I select "July" from "Month"
  Then I should not see the link "First Behat Testimony"
    And I should see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Testimony"
  When I select "February" from "Month"
  Then I should not see the link "First Behat Testimony"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should see the link "Fifth Behat Testimony"
  When I select "2019" from "edit-year"
    And I select "May" from "Month"
  Then I should not see the link "First Behat Testimony"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Testimony"
  When I select "2017" from "edit-year"
    And I select "June" from "Month"
  Then I should not see the link "First Behat Testimony"
    And I should not see the link "Second Behat Testimony"
    And I should see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Testimony"
