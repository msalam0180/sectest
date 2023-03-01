Feature: Create and View Press Releases
  As a Content Creator
  I want to be able to create press releases
  So that visitors to SEC.gov can view official press releases

  @api @javascript
  Scenario: Create A Press Release
    Given "secperson" content:
      | title    | field_first_name_secperson | field_last_name_secperson | status |
      | Person 1 | John                       | Doe                       | 1      |
      | Person 2 | Jane                       | Doe                       | 1      |
      And I am logged in as a user with the "Sitebuilder" role
    When I am on "/node/add/news"
      And I select "Press Release" from "News Type"
  	  And I fill in "Title" with "This is the new title"
  	  And I fill in "Display Title" with "My New Press Release"
  	  And I fill in "Release Number" with "2021-123"
      And I select the first autocomplete option for "Person 1" on the "Speaker" field
      And I type "A test press release" in the "Body" WYSIWYG editor
      And I select "Agency-Wide" from "Primary Division/Office"
  	  And I publish it
    Then I should see the heading "My New Press Release"
    When I am not logged in
      And I visit "/news/pressreleases"
    Then I should see the link "My New Press Release"
      And I should see the text "2021-123" in the "My New Press Release" row

  @api
  Scenario: View a Press Release
    Given I am viewing an "news" content:
      | field_news_type_news          | Press Release           |
      | field_primary_division_office | Agency-wide             |
      | moderation_state              | published               |
      | title                         | This is the title       |
      | status                        | 1                       |
      | body                          | This is the body        |
      | field_display_title           | My test press release   |
    Then I should see the heading "My test press release"
      And I should see the text "This is the body"
      And I should see the link "Newsroom" in the navigation region
      And I should see the link "Press Release" in the contentbanner region

  @api
  Scenario: Press Release URLs
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  |
    When I visit "/news/press-release/first-new-pr"
    Then the response status code should be 200

  @api
  Scenario: View the News Landing Page
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  |
      | Press Release        | Agency-wide                   | published        | Second New PR | 1      | This is the second body. | Second New Press Release |
      | Press Release        | Agency-wide                   | published        | Third New PR  | 1      | This is the third body.  | Third New Press Release  |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  |
    When I am on "/news"
    Then I should see the heading "Newsroom"
      And I should see the link "First New Press Release"
      And I should see the link "Second New Press Release"
      And I should see the link "Third New Press Release"
      And I should see the link "Fourth New Press Release"
      And I should see the link "Fifth New Press Release"
      And I should see the link "View all Press Releases"

  @api @javascript
  Scenario: View the Press Release List Page
    Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
      And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number | field_media_file_upload |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |                         |
      | Press Release        | Agency-wide                   | draft            | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |                         |
      | Press Release        | Agency-wide                   | draft            | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |                         |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      |                          | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               | Behat File              |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               | Behat File              |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2018-03-11 12:00:00 | 2018-6               |                         |
      | Press Release        | Agency-wide                   | published        | Seventh New PR| 1      | This is the seventh body.| Seventh New Press Release| 2018-04-11 12:00:00 | 2018-4               |                         |
      | Press Release        | Agency-wide                   | published        | Eighth New PR | 1      | This is the eighth body. | Eighth New Press Release | 2018-06-11 12:00:00 | 2018-6               |                         |
      | Press Release        | Agency-wide                   | published        | Ninth New PR  | 1      | This is the ninth body.  | Ninth New Press Release  | 2018-07-11 12:00:00 | 2018-4               |                         |
    When I am on "/news/pressreleases"
    Then I should see the heading "Press Releases"
      #list view should display link to press release with display title as text
      And I should see the link "First New Press Release"
      #list view should not display draft items
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should see the link "Fourth New Press Release (PDF)"
      And I should see the link "Fifth New Press Release"
      #list view should display  date
      And I should see the date "2018-09-11 12:00:00" in the "First New Press Release" row
      And I should see the date "2018-05-11 12:00:00" in the "Fourth New Press Release (PDF)" row
      And I should see the date "2018-02-11 12:00:00" in the "Fifth New Press Release" row
      #list view should display release number
      And I should see the text "2018-12" in the "First New Press Release" row
      And I should see the text "2018-6" in the "Fourth New Press Release (PDF)" row
      And I should see the text "2018-4" in the "Fifth New Press Release" row
      #dates should be grouped by month and display under a month banner
      And I should see "First New Press Release" under the "2018-09-11 12:00:00" month banner
      And I should see "Fourth New Press Release (PDF)" under the "2018-05-11 12:00:00" month banner
      And I should see "Fifth New Press Release" under the "2018-02-11 12:00:00" month banner
      #default sorting is by date: newest to oldest
      And "First New Press Release" should precede "Fourth New Press Release (PDF)" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fourth New Press Release (PDF)" should precede "Fifth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I should see the text "Showing 1 to 7 of 7 entries"

  @api @javascript @insulated
  Scenario: Press Release List Page Title Sorting
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
      | Press Release        | Agency-wide                   | draft            | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |
      | Press Release        | Agency-wide                   | published        | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2018-03-11 12:00:00 | 2017-4               |
    When I am on "/news/pressreleases"
      And I click the sort filter "Headline"
      And I wait for Ajax to finish
    Then "Fifth New Press Release" should precede "First New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "First New Press Release" should precede "Fourth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fourth New Press Release" should precede "Sixth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Sixth New Press Release" should precede "Third New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    When I click the sort filter "Headline"
      And I wait for Ajax to finish
    Then "Fourth New Press Release" should precede "First New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Sixth New Press Release" should precede "Fourth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Third New Press Release" should precede "Sixth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "First New Press Release" should precede "Fifth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript @insulated
  Scenario: Press Release List Page Release Number Sorting
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
      | Press Release        | Agency-wide                   | published        | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |
      | Press Release        | Agency-wide                   | published        | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2018-03-11 12:00:00 | 2017-1               |
    When I am on "/news/pressreleases"
      And I click the sort filter "Release No."
      And I wait for Ajax to finish
    Then "Third New Press Release" should precede "First New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fourth New Press Release" should precede "Third New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fifth New Press Release" should precede "Fourth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Sixth New Press Release" should precede "Fifth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Press Release List Page Year Filter
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
      | Press Release        | Agency-wide                   | draft            | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |
      | Press Release        | Agency-wide                   | draft            | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2017-02-11 12:00:00 | 2017-4               |
    When I am on "/news/pressreleases"
    Then I should see the heading "Press Releases"
    When I select "2018" from "Year"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "First New Press Release"
      And I should see the link "Fourth New Press Release"
      And I should see the link "Fifth New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should not see the link "Sixth New Press Release"

  @api @javascript
  Scenario: Press Release List Page Month Filter
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
      | Press Release        | Agency-wide                   | draft            | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |
      | Press Release        | Agency-wide                   | draft            | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2017-02-11 12:00:00 | 2017-4               |
    When I am on "/news/pressreleases"
    Then I should see the heading "Press Releases"
    When I select "2018" from "Year"
      And I select "September" from "Month"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "First New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should not see the link "Fourth New Press Release"
      And I should not see the link "Fifth New Press Release"
      And I should not see the link "Sixth New Press Release"
      And I should see the text "Showing 1 to 1 of 1 entries"
    When I select "-View All-" from "Year"
      And I select "February" from "Month"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "Fifth New Press Release"
      And I should see the link "Sixth New Press Release"
      And I should not see the link "First New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should not see the link "Fourth New Press Release"
      And I should see the text "Showing 1 to 2 of 2 entries"
    When I select "-View All-" from "Month"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "Fifth New Press Release"
      And I should see the link "Sixth New Press Release"
      And I should see the link "First New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should see the link "Fourth New Press Release"
      And I should see the text "Showing 1 to 4 of 4 entries"

  @api @javascript
  Scenario: Press Release List Page Date Sorting
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
      | Press Release        | Agency-wide                   | draft            | Second New PR | 0      | This is the second body. | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              |
      | Press Release        | Agency-wide                   | draft            | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2017-02-11 12:00:00 | 2017-4               |
    When I am on "/news/pressreleases"
      And I click the sort filter "Date"
      And I wait for Ajax to finish
    Then "Fifth New Press Release" should precede "Fourth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fourth New Press Release" should precede "First New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api
  Scenario Outline: Validate Display of Publish Date for News Content Type
    Given I am viewing an "news" content:
      | title                         | Test              |
      | body                          | This is the body. |
      | field_news_type_news          | <Type>            |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_display_title           | My test article   |
      | field_primary_division_office | Enforcement       |
      | field_publish_date            | <date>            |
    Then I should see the text "<apdate>"

    Examples:
      | Type             | date                | apdate       |
      | Press Release    | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Speech           | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Statement        | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Testimony        | 2020-01-01 12:00:00 | Jan. 1, 2020 |

  @api @javascript
  Scenario: Press Release Search
    Given "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-123             |
      | Press Release        | Agency-wide                   | published        | Second New PR | 1      | This is the second body. | Second New Press Release | 2018-10-03 12:00:00 | 2018-170             |
      | Press Release        | Agency-wide                   | published        | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-05 12:00:00 | 2018-88               |
      | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-06-25 12:00:00 | 2018-66              |
      | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-14 12:00:00 | 2018-43              |
      | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2019-03-15 12:00:00 | 2019-18              |
      | Press Release        | Agency-wide                   | published        | Seventh New PR| 1      | This is the seventh body.| Seventh New Press Release| 2019-04-17 12:00:00 | 2019-42              |
      | Press Release        | Agency-wide                   | published        | Eighth New PR | 1      | This is the eighth body. | Eighth New Press Release | 2019-06-30 12:00:00 | 2019-62              |
      | Press Release        | Agency-wide                   | published        | Ninth New PR  | 1      | This is the ninth body.  | Ninth New Press Release  | 2019-07-23 12:00:00 | 2019-68              |
    When I am on "/news/pressreleases"
    Then I should see the heading "Press Releases"
    #search by title
    When I fill in "edit-combine" with "th new"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "Fourth New Press Release"
    #search results should be grouped by month and display under a month banner
      And I should see "Fourth New Press Release" under the "2018-06-25 12:00:00" month banner
      And I should see the link "Fifth New Press Release"
      And I should see "Fifth New Press Release" under the "2018-02-14 12:00:00" month banner
      And I should see the link "Sixth New Press Release"
      And I should see "Sixth New Press Release" under the "2019-03-15-25 12:00:00" month banner
      And I should see the link "Seventh New Press Release"
      And I should see "Seventh New Press Release" under the "2019-04-17 12:00:00" month banner
      And I should see the link "Eighth New Press Release"
      And I should see "Eighth New Press Release" under the "2019-06-30 12:00:00" month banner
      And I should see the link "Ninth New Press Release"
      And I should see "Ninth New Press Release" under the "2019-07-23 12:00:00" month banner
      And I should not see the link "First New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
    #search results should be ordered by newest to oldest date
      And "Ninth New Press Release" should precede "Eighth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Eighth New Press Release" should precede "Seventh New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Seventh New Press Release" should precede "Sixth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Sixth New Press Release" should precede "Fifth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Fourth New Press Release" should precede "Fifth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    #number of items from search results should be displayed
      And I should see the text "Showing 1 to 6 of 6 entries"
    #search by release number
    When I fill in "edit-combine" with "2019-6"
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "Eighth New Press Release"
    #search results should be ordered by newest to oldest date
      And I should see the link "Ninth New Press Release"
      And "Ninth New Press Release" should precede "Eighth New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I should not see the link "First New Press Release"
      And I should not see the link "Second New Press Release"
      And I should not see the link "Third New Press Release"
      And I should not see the link "Fourth New Press Release"
      And I should not see the link "Fifth New Press Release"
      And I should not see the link "Sixth New Press Release"
      And I should not see the link "Seventh New Press Release"
      And I should see the text "Showing 1 to 2 of 2 entries"
    #resetting search should show all results
    When I fill in "edit-combine" with " "
      And I press "Apply"
      And I wait for ajax to finish
    Then I should see the link "First New Press Release"
      And I should see the link "Second New Press Release"
      And I should see the link "Third New Press Release"
      And I should see the link "Fourth New Press Release"
      And I should see the link "Fifth New Press Release"
      And I should see the link "Sixth New Press Release"
      And I should see the link "Seventh New Press Release"
      And I should see the link "Eighth New Press Release"
      And I should see the link "Ninth New Press Release"
      And I should see the text "Showing 1 to 9 of 9 entries"

 @api @javascript
  Scenario: Office of Credit Ratings Press Release List Page Date Sorting
    Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
      And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number | field_tags | field_media_file_upload |
      | Press Release        | Credit Ratings                | published        | First New PR  | 1      |                          | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              | OCRNews    | Behat File              |
      | Press Release        | Credit Ratings                | published        | Second New PR | 1      |                          | Second New Press Release | 2018-07-11 12:00:00 | 2018-10              | OCRNews    | Behat File              |
      | Press Release        | Credit Ratings                | draft            | Third New PR  | 0      | This is the third body.  | Third New Press Release  | 2018-06-11 12:00:00 | 2018-8               | OCRNews    | Behat File              |
      | Press Release        | Credit Ratings                | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-05-11 12:00:00 | 2018-6               | OCRNews    | Behat File              |
      | Press Release        | Credit Ratings                | published        | Fifth New PR  | 1      |                          | Fifth New Press Release  | 2018-02-11 12:00:00 | 2018-4               | OCRNews    | Behat File              |
      | Press Release        | Credit Ratings                | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2017-02-11 12:00:00 | 2017-4               | OCRNews    | Behat File              |
    When I am on "/ocr/ocr-news-list-page-"
    Then I should see the link "First New Press Release (PDF)"
      And I should see the link "Fourth New Press Release"
      And I should not see the link "Sixth New Press Release (PDF)"
      And I should not see the link "Third New Press Release"
      And I should see the link "First New Press Release (PDF)" before I see the link "Fifth New Press Release" in the "Ocr Press Release List" view
    When I click the sort filter "Date"
    Then I should see the link "Sixth New Press Release" before I see the link "Fourth New Press Release" in the "Ocr Press Release List" view
    When I click the sort filter "Title"
    Then I should see the link "Fifth New Press Release (PDF)" before I see the link "Second New Press Release (PDF)" in the "Ocr Press Release List" view
    When I select "2018" from "edit-year"
    Then I should see the link "Fifth New Press Release (PDF)"
      And I should not see the link "Sixth New Press Release"
      And I select "July" from "Month"
      And I should see the link "Second New Press Release (PDF)"
      And I should not see the link "First New Press Release (PDF)"
      And I should not see the link "Fourth New Press Release"
      And I should not see the link "Fifth New Press Release (PDF)"
      And I should not see the link "Sixth New Press Release"
    When I am on "/ocr/ocr-news-list-page-"
      And I click "First New Press Release (PDF)"
    Then I should be on "/files/behat-file_corpfin.pdf"
      And I close the current tab
    When I am on "/ocr/ocr-news-list-page-"
      And I click "Sixth New Press Release"
    Then I should be on "/news/press-release/sixth-new-pr"
