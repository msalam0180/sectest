Feature: View Speeches Statements List Page
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
Scenario: View the Speeches and Statements List Page
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title      | status | body                                | field_display_title     | field_publish_date  | field_release_number | field_speaker_name_and_title | field_alternate_title_secarticle                              |
    | Testimony            | Agency-wide                   | First TM   | 1      | This is the first Testimony body.   | First Behat Testimony   | 2021-07-11 12:00:00 | 2021-01              | John Behat                   | <u>RSS</u> <em>Testimony Filer Test</em> <strong>0@0</strong> |
    | Speech               | Agency-wide                   | Second TM  | 0      | This is the second Speech body.     | Second Behat Speech     | 2021-07-10 12:00:00 | 2021-01              | Jane Behat                   |                                                               |
    | Statement            | Agency-wide                   | Third TM   | 1      | This is the third Statement body.   | Third Behat Statement   | 2021-06-13 12:00:00 | 2021-03              | Dave Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Fourth TM  | 1      | This is the fourth Testimony body.  | Fourth Behat Testimony  | 2021-05-11 12:00:00 | 2021-04              | Lisa Behat                   |                                                               |
    | Speech               | Agency-wide                   | Fifth TM   | 1      | This is the fifth Speech body.      | Fifth Behat Speech      | 2021-06-11 12:00:00 | 2021-05              | John Behat                   |                                                               |
    | Statement            | Agency-wide                   | Sixth TM   | 1      | This is the sixth Statement body.   | Sixth Behat Testimony   | 2021-06-11 12:00:00 | 2021-06              | Mike Behat                   |                                                               |
    | Testimony            | Agency-wide                   | Seventh TM | 1      | This is the seventh Testimony body. | Seventh Behat Testimony | 2021-03-11 12:00:00 | 2021-07              | Adam Behat                   |                                                               |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    #list view should not display draft items
    And I should not see the link "Second Behat Speech"
    And I should see the link "Third Behat Statement"
    And I should see the link "Fourth Behat Testimony"
    And I should see the link "Fifth Behat Speech"
    #list view should display date
    And I should see the date "2021-05-11" in the "Fourth Behat Testimony" row
    And I should see the date "2021-06-11" in the "Fifth Behat Speech" row
    #list view should display speaker name
    And I should see the text "Lisa Behat" in the "Fourth Behat Testimony" row
    And I should see the text "John Behat" in the "Fifth Behat Speech" row
    #dates should be grouped by month and display under a month banner
    And I should see "Third Behat Statement" under the "2021-06-13 12:00:00" month banner
    And I should see "Fifth Behat Speech" under the "2021-06-11 12:00:00" month banner

@api @javascript
Scenario: Default Sorting for Speeches and Statements List Page
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Speech" row
    And I should see the date "2018-07-10 12:00:00" in the "Second Behat Testimony" row
    And I should see the date "2017-06-13 12:00:00" in the "Third Behat Statement" row
    And I should see the date "2019-05-11 12:00:00" in the "Fourth Behat Testimony" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Speech" row
    #dates should be grouped by month and displayed under a month banner
    And I should see "First Behat Speech" under the "2018-09-11 12:00:00" month banner
    And I should see "Second Behat Testimony" under the "2018-07-10 12:00:00" month banner
    And I should see "Third Behat Statement" under the "2017-06-13 12:00:00" month banner
    And I should see "Fourth Behat Testimony" under the "2019-05-11 12:00:00" month banner
    And I should see "Fifth Behat Speech" under the "2018-02-11 12:00:00" month banner
    And "Fourth Behat Testimony" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Speech" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches and Statements List Page by Date
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Speech               | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Speech    | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Testimony            | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Testimony  | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Date"
  Then "Third Behat Testimony" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Speech" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Testimony" should precede "Fourth Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Date"
  Then "Fourth Behat Statement" should precede "First Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Fifth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth Behat Testimony" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches and Statements List Page by Title
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Title"
  Then "Fifth Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth Behat Testimony" should precede "Second Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Third Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "Third Behat Statement" should precede "Second Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Testimony" should precede "Fourth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches and Statements List Page by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Statement            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Statement | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Speaker"
  Then "Third Behat Testimony" should precede "Second Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Speech" should precede "Fourth Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Speaker"
  Then "Fourth Behat Testimony" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Third Behat Testimony" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Speeches and Statements List Page by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title | field_person |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2017-09-11 12:00:00 | 2017-09              | John Behat                   | John Behat   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |              |
    | Statement            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |              |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |              |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   | John Behat   |
  When I am on "/news/speeches-statements"
    And I fill in "John Behat" for "edit-field-person-target-id"
    And I wait for AJAX to finish
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
  Then I should see the link "Fifth Behat Speech"
    And I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
  When I select "2017" from "edit-year"
  Then I should not see the link "Fifth Behat Speech"
    And I should not see the link "Third Behat Statement"
    And I should see the link "First Behat Speech"

@api @javascript
Scenario: Filter Speeches and Statements List Page by Year
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
  Then I should see the link "First Behat Speech"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Statement"
    And I should see the link "Second Behat Testimony"
    And I should see the link "Fifth Behat Speech"
  When I select "2017" from "edit-year"
  Then I should see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Second Behat Testimony"
  When I select "2019" from "edit-year"
  Then I should see the link "Fourth Behat Statement"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "First Behat Speech"

@api @javascript
Scenario: Filter Speeches and Statements List Page by Month
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Statement            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Statement  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Testimony            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Testimony | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I select "September" from "Month"
  Then I should see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Speech"
  When I select "July" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Speech"
  When I select "February" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Testimony"
    And I should see the link "Fifth Behat Speech"
  When I select "2019" from "edit-year"
    And I select "May" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Statement"
    And I should see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Speech"
  When I select "2017" from "edit-year"
    And I select "June" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should see the link "Third Behat Statement"
    And I should not see the link "Fourth Behat Testimony"
    And I should not see the link "Fifth Behat Speech"

@api @javascript
Scenario: Filter Speeches and Statements List Page by News Type
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
    | Statement            | Agency-wide                   | Sixth TM  | 1      | This is the sixth body.  | Sixth Behat Statement  | 2020-05-11 12:00:00 | 2020-05              | Lisa Behat                   |
  When I am on "/news/speeches-statements"
    And I select "Speech" from "edit-news-type"
  Then I should see the link "First Behat Speech"
    And I should see the link "Fifth Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Sixth Behat Statement"
  When I select "Testimony" from "edit-news-type"
  Then I should see the link "Second Behat Testimony"
    And I should see the link "Third Behat Testimony"
    And I should not see the link "First Behat Speech"
    And I should not see the link "Fourth Behat Statement"
    And I should not see the link "Sixth Behat Statement"
  When I select "Statement" from "edit-news-type"
  Then I should see the link "Fourth Behat Statement"
    And I should see the link "Sixth Behat Statement"
    And I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Testimony"
    And I should not see the link "Third Behat Testimony"

@api @javascript
Scenario: Filter Speeches and Statements List Page by Type Year Month and Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Speech     | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Testimony            | Agency-wide                   | Second TM | 1      | This is the second body. | Second Behat Testimony | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Testimony            | Agency-wide                   | Third TM  | 1      | This is the third body.  | Third Behat Testimony  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Statement            | Agency-wide                   | Fourth TM | 1      | This is the fourth body. | Fourth Behat Statement | 2019-05-11 12:00:00 | 2019-05              | Jane Behat                   |
    | Speech               | Agency-wide                   | Fifth TM  | 1      | This is the fifth body.  | Fifth Behat Speech     | 2018-02-11 12:00:00 | 2018-02              | John Behat                   |
    | Statement            | Agency-wide                   | Sixth TM  | 1      | This is the sixth body.  | Sixth Behat Statement  | 2020-05-11 12:00:00 | 2020-05              | Jane Behat                   |
  When I am on "/news/speeches-statements"
    And I select "Testimony" from "edit-news-type"
    And I wait for AJAX to finish
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
    And I select "July" from "Month"
    And I wait for AJAX to finish
    And I fill in "Jane Behat" for "edit-field-person-target-id"
    And I wait for AJAX to finish
  Then I should see the link "Second Behat Testimony"
