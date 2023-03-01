Feature: View Published Speeches
  As a Content Creator
  I want to be able to create speeches
  So that visitors to SEC.gov can view official speeches

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
Scenario: Create a Speech Through the UI
  Given "secperson" content:
    | title        | field_first_name_secperson | field_last_name_secperson | status |
    | Behat Tester | Jim                        | Behat                     | 1      |
    And I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/news"
    And I select "Speech" from "News Type"
    And I fill in "Title" with "Behat News Content Test"
    And I fill in "Display Title" with "Behat Speech Test"
    And I fill in "Description/Abstract" with "This is a speech behat test"
    And I select the first autocomplete option for "Behat Tester" on the "Speaker" field
    And I publish it
  Then I should see the heading "Behat Speech Test"
    And I should see the text "Jim Behat"

@api @javascript
Scenario: View Speeches List
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title      | status | body                      | field_display_title  | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP   | 1      | This is the first body.   | First Behat Speech   | 2018-09-11 12:00:00 | 2018-09              | John Behat                   |
    | Speech               | Agency-wide                   | Second SP  | 0      | This is the second body.  | Second Behat Speech  | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP   | 1      | This is the third body.   | Third Behat Speech   | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP  | 1      | This is the fourth body.  | Fourth Behat Speech  | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP   | 1      | This is the fifth body.   | Fifth Behat Speech   | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
    | Speech               | Agency-wide                   | Sixth SP   | 1      | This is the sixth body.   | Sixth Behat Speech   | 2019-06-11 12:00:00 | 2019-06              | Lisa Behat                   |
    | Speech               | Agency-wide                   | Seventh SP | 1      | This is the seventh body. | Seventh Behat Speech | 2018-03-11 12:00:00 | 2018-03              | Mike Behat                   |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    #list view should display link to speeches with display title as text
    And I should see the link "First Behat Speech"
    #list view should not display draft items
    And I should not see the link "Second Behat Speech"
    And I should see the link "Third Behat Speech"
    And I should see the link "Fourth Behat Speech"
    And I should see the link "Fifth Behat Speech"
    #list view should display date
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Speech" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Speech" row
    #list view should display speaker name
    And I should see the text "John Behat" in the "First Behat Speech" row
    And I should see the text "Adam Behat" in the "Fourth Behat Speech" row
    And I should see the text "Adam Behat" in the "Fifth Behat Speech" row
    And I should see the text "Showing 1 to 6 of 6 entries"

@api @javascript
Scenario: Default Sorting for Speeches List Page
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
  Then I should see the heading "Speeches and Statements"
    And I should see the date "2018-09-11 12:00:00" in the "First Behat Speech" row
    And I should see the date "2018-07-10 12:00:00" in the "Second Behat Speech" row
    And I should see the date "2017-06-13 12:00:00" in the "Third Behat Speech" row
    And I should see the date "2019-05-11 12:00:00" in the "Fourth Behat Speech" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth Behat Speech" row
    And "Fourth Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Fifth Behat Speech" should precede "Third Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches by Date
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Date"
  Then "Third Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "First Behat Speech" should precede "Fourth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
  When I click the sort filter "Date"
  Then "Fourth Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Fifth Behat Speech" should precede "Third Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches by Title
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Title"
  Then "Fifth Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Fourth Behat Speech" should precede "Second Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Third Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "Third Behat Speech" should precede "Second Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Fourth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "First Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Speeches by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Mike Behat                   |
  When I am on "/news/speeches-statements"
    And I click the sort filter "Speaker"
  Then "Fourth Behat Speech" should precede "Third Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Second Behat Speech" should precede "Fifth Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
  When I click the sort filter "Speaker"
  Then "Fifth Behat Speech" should precede "Second Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"
    And "Third Behat Speech" should precede "First Behat Speech" for the query "//td[contains(@class, 'views-field-field-display-title')]"

@api @javascript
Scenario: Filter Speeches by Speaker
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title | field_person |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2017-09-11 12:00:00 | 2017-09              | Adam Behat                   | Adam Behat   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |              |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |              |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |              |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   | Adam Behat   |
  When I am on "/news/speeches-statements"
    And I fill in "Adam Behat" for "edit-field-person-target-id"
    And I wait for AJAX to finish
    And I select "2018" from "edit-year"
  Then I should see the link "Fifth Behat Speech"
    And I should not see the link "Second Behat Speech"
  When I select "2017" from "edit-year"
  Then I should not see the link "Third Behat Speech"
    And I should see the link "First Behat Speech"

@api @javascript
Scenario: Filter Speeches by Year
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
  Then I should see the link "First Behat Speech"
    And I should not see the link "Third Behat Speech"
    And I should not see the link "Fourth Behat Speech"
    And I should see the link "Second Behat Speech"
    And I should see the link "Fifth Behat Speech"
    And I should not see the link "Sixth Behat Speech"
  When I select "2017" from "edit-year"
  Then I should see the link "Third Behat Speech"
  When I select "2019" from "edit-year"
  Then I should see the link "Fourth Behat Speech"

@api @javascript
Scenario: Filter Speeches by Month
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title | field_publish_date  | field_release_number | field_speaker_name_and_title |
    | Speech               | Agency-wide                   | First SP  | 1      | This is the first body.  | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              | Adam Behat                   |
    | Speech               | Agency-wide                   | Second SP | 1      | This is the second body. | Second Behat Speech | 2018-07-10 12:00:00 | 2018-07              | Jane Behat                   |
    | Speech               | Agency-wide                   | Third SP  | 1      | This is the third body.  | Third Behat Speech  | 2017-06-13 12:00:00 | 2017-06              | Dave Behat                   |
    | Speech               | Agency-wide                   | Fourth SP | 1      | This is the fourth body. | Fourth Behat Speech | 2019-05-11 12:00:00 | 2019-05              | Adam Behat                   |
    | Speech               | Agency-wide                   | Fifth SP  | 1      | This is the fifth body.  | Fifth Behat Speech  | 2018-02-11 12:00:00 | 2018-02              | Adam Behat                   |
  When I am on "/news/speeches-statements"
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
    And I select "September" from "Month"
    And I wait for AJAX to finish
  Then I should see the link "First Behat Speech"
    And I should not see the link "Second Behat Speech"
    And I should not see the link "Third Behat Speech"
    And I should not see the link "Fourth Behat Speech"
    And I should not see the link "Fifth Behat Speech"
  When I select "July" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should see the link "Second Behat Speech"
    And I should not see the link "Third Behat Speech"
    And I should not see the link "Fourth Behat Speech"
    And I should not see the link "Fifth Behat Speech"
  When I select "February" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Speech"
    And I should not see the link "Third Behat Speech"
    And I should not see the link "Fourth Behat Speech"
    And I should see the link "Fifth Behat Speech"
  When I select "2019" from "edit-year"
    And I select "May" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Speech"
    And I should not see the link "Third Behat Speech"
    And I should see the link "Fourth Behat Speech"
    And I should not see the link "Fifth Behat Speech"
  When I select "2017" from "edit-year"
    And I select "June" from "Month"
  Then I should not see the link "First Behat Speech"
    And I should not see the link "Second Behat Speech"
    And I should see the link "Third Behat Speech"
    And I should not see the link "Fourth Behat Speech"
    And I should not see the link "Fifth Behat Speech"

@api @javascript
Scenario: Verify Duplicate News Content Is Not Showing In The Content Dashboard When Multiple Taxonomies Are Selected
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title          | status | body                    | field_display_title | field_publish_date  | field_release_number |
    | Speech               | Agency-wide                   | Behat for News | 1      | This is the first body. | First Behat Speech  | 2018-09-11 12:00:00 | 2018-09              |
    And "secperson" content:
      | title        | field_first_name_secperson | field_last_name_secperson | status |
      | Behat Tester | Jim                        | Behat                     | 1      |
  When I am logged in as a user with the "Content Approver" role
    And I am on "admin/content/search"
    And I fill in "Behat for News" for "Title"
    And I wait for ajax to finish
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the text "Displaying 1 - 1 of 1"
  When I click "Edit" in the "First Behat Speech" row
    And I fill in "Description/Abstract" with "This is a test for landing page"
    And I select the first autocomplete option for "Behat Tester" on the "Speaker" field
    And I select "Acquisitions" from "Supporting Division / Office"
    And I additionally select "Administrative Law Judges" from "Supporting Division / Office"
    And I select "Public Companies" from "Audience"
    And I additionally select "Small Businesses" from "Audience"
    And I select "JOBS Act of 2012" from "Act"
    And I additionally select "Securities Act of 1933" from "Act"
    And I select "Regulation 13D" from "Regulation"
    And I additionally select "Regulation 14A" from "Regulation"
    And I publish it
    And I am on "admin/content/search"
    And I fill in "Behat for News" for "Title"
    And I wait for ajax to finish
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the text "Displaying 1 - 1 of 1"
