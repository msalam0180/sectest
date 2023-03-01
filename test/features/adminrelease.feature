Feature: Administator view for Release content types
  As a creator of Release content types
  I want to be able to view a list of Release(s)
  So that I can search, filter, view and edit Release content types

@api
Scenario: Validate Release Admin View and Pagination
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
      | name     |
      | ui-98-po |
      | ab-12-cd |
      | 34-12345 |
    And "customized_comment_form" content:
      | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
      | Comment Form  | Display Title for 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
      | Comment behat | Display Title for 2 | 1      | ui-98-po          | /comments/ab-12-cd | ui-98-po     |
    And I create "media" of type "static_file":
      | name         | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
      | Behat file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
      | Behat file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
    And I create "media" of type "link":
      | name                | field_media_entity_link                                | status | mid |
      | Behat Page Link     | https://sec.lndo.site/page/enforcement-section-landing | 1      | 1   |
      | Behat External Link | http://google.com                                      | 1      | 2   |
    And "release" content:
      | title      | body         | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date | field_release_file_number | field_submit_comments | field_see_also      | field_release_file | status |
      | Andrew   1 | detail body1 | Trading Suspensions        | ui-98-po             | Andrew            | published        | 01-01-2021         | ui-98-po                  | Comment Form          | Behat Page Link     | Behat file 1       | 1      |
      | Brent    2 | detail body1 | Trading Suspensions        | ui-98-po             | Brent             | published        | -1 days            | ui-98-po                  |                       | Behat Page Link     |                    | 1      |
      | Carl     3 | detail body1 | Trading Suspensions        | 34-12345             | Carl              | published        | -20 days           | 34-12345                  | Comment Form          |                     | Behat file 2       | 1      |
      | David    4 | detail body1 | Trading Suspensions        | 34-12345             | David             | published        | -30 days           | 34-12345                  | Comment Form          | Behat Page Link     |                    | 0      |
      | Eric     5 | detail body1 | Administrative Proceedings | ui-98-po             | Eric              | published        | -15 days           | ui-98-po                  |                       | Behat Page Link     | Behat file 1       | 1      |
      | Frank    6 | detail body1 | Administrative Proceedings | 34-12345             | Frank             | published        | -13 days           | 34-12345                  |                       | Behat Page Link     |                    | 1      |
      | George   7 | detail body1 | Administrative Proceedings | 34-12345             | George            | published        | -11 days           | 34-12345                  |                       |                     |                    | 1      |
      | Hana     8 | detail body1 | Administrative Proceedings | ui-98-po             | Hana              | published        | -1 days            | ui-98-po                  |                       | Behat Page Link     | Behat file 2       | 0      |
      | Isaic    9 | detail body1 | Administrative Proceedings | 34-12345             | Isaic             | published        | -11 days           | 34-12345                  | Comment Form          | Behat Page Link     |                    | 1      |
      | James   10 | detail body1 | Administrative Proceedings | ab-12-cd             | James             | published        | -13 days           | ab-12-cd                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Kyle    11 | detail body1 | ALJ Orders                 | 34-12345             | Kyle              | published        | -10 days           | 34-12345                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Laura   12 | detail body1 | ALJ Orders                 | 34-12345             | Laura             | published        | -1 days            | 34-12345                  | Comment Form          | Behat Page Link     | Behat file 1       | 1      |
      | Mason   13 | detail body1 | ALJ Orders                 | ab-12-cd             | Mason             | published        | -2 days            | ab-12-cd                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Nanci   14 | detail body1 | ALJ Orders                 | 34-12345             | Nanci             | published        | -22 days           | 34-12345                  | Comment Form          | Behat Page Link     | Behat file 1       | 0      |
      | Olga    15 | detail body1 | ALJ Orders                 | ab-12-cd             | Olga              | published        | -10 days           | ab-12-cd                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Pat     16 | detail body1 | ALJ Orders                 | 34-12345             | Pat               | published        | -4 days            | 34-12345                  |                       |                     | Behat file 1       | 1      |
      | Quincy  17 | detail body1 | ALJ Orders                 | 34-12345             | Quincy            | published        | -5 days            | 34-12345                  |                       |                     |                    | 1      |
      | Robert  18 | detail body1 | ALJ Orders                 | ab-12-cd             | Robert            | published        | -6 days            | ab-12-cd                  |                       |                     |                    | 1      |
      | Sam     19 | detail body1 | ALJ Orders                 | 34-12345             | Sam               | published        | -10 days           | 34-12345                  |                       | Behat Page Link     | Behat file 2       | 1      |
      | Tom     20 | detail body1 | Trading Suspensions        | 34-12345             | Tom               | published        | -8 days            | 34-12345                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Umar    21 | detail body1 | Trading Suspensions        | ab-12-cd             | Umar              | published        | -6 days            | ab-12-cd                  | Comment Form          | Behat Page Link     | Behat file 1       | 0      |
      | Violet  22 | detail body1 | Trading Suspensions        | 34-12345             | Violet            | published        | -31 days           | 34-12345                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Will    23 | detail body1 | Trading Suspensions        | 34-12345             | Will              | published        | -10 days           | 34-12345                  | Comment Form          | Behat Page Link     | Behat file 1       | 1      |
      | Xixi    24 | detail body1 | Trading Suspensions        | ab-12-cd             | Xixi              | published        | +3 days            | ab-12-cd                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Yolanda 25 | detail body1 | Trading Suspensions        | 34-12345             | Yolanda           | published        | -5 days            | 34-12345                  |                       | Behat Page Link     |                    | 1      |
      | Zack    26 | detail body1 | ALJ Orders                 | ui-98-po             | Zack              | published        | -80 days           | ui-98-po                  | Comment behat         | Behat External Link | Behat file 2       | 1      |
      | Xixi    14 | detail body1 | Trading Suspensions        | ab-12-cd             | Xixi              | published        | +3 days            | ab-12-cd                  | Comment Form          | Behat Page Link     |                    | 1      |
      | Yolanda 15 | detail body1 | Trading Suspensions        | 34-12345             | Yolanda           | published        | -5 days            | 34-12345                  |                       | Behat Page Link     |                    | 1      |
      | Zack    16 | detail body1 | Trading Suspensions        | ab-12-cd             | Zack              | published        | -80 days           | ab-12-cd                  | Comment Form          | Behat Page Link     | Behat file 1       | 1      |
      | Violet  12 | detail body1 | Trading Suspensions        | 34-12345             | Violet            | published        | -31 days           | 34-12345                  | Comment Form          | Behat Page Link     |                    | 1      |
    And I visit "/admin/content/release"
  Then I should see the link "Andrew 1"
    And I should see the text "2021-01-01" in the "Andrew 1" row
    And I should see the text "Trading Suspension" in the "Andrew 1" row
    And I should see the link "behat-file_data.pdf"
    And I should see the text "Andrew" in the "Andrew 1" row
    And I should see the text "ui-98-po" in the "Andrew 1" row
    And I should see the link "https://sec.lndo.site/page/enforcement-section-landing"
    And I should see the link "Comment Form"
    And I should see the link "David 4"
    And I should see the text "Administrative Proceeding" in the "Eric 5" row
    And I should see the text "ALJ Order" in the "Kyle 11" row
    And I should see the text "Displaying 1 - 30 of 30"
  When I select "25" from "Items per page"
    And I press "Apply"
    And I click "Last"
  Then I should see the text "Displaying 26 - 30 of 30"
    And I should see the link "Zack 26"
    And I should see the text "ALJ Order" in the "Zack 26" row
    And I should see the link "behat-file_invalert.pdf"
    And I should see the text "ui-98-po" in the "Zack 26" row
    And I should see the link "http://google.com"
    And I should see the link "Comment behat"
  When I click "Edit"
    And I fill in "Title" with "Update Xixi"
    And I press "Save"
    And I visit "/admin/content/release"
  Then I should see the link "Update Xixi"
    And I should not see the link "Xixi 24"

@api
Scenario: Confirm Title Search on Release Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "release" content:
      | title      | body         | field_release_type  | field_release_number | field_respondents | moderation_state | field_publish_date | status |
      | Andrew   1 | detail body1 | Trading Suspensions | ui-98-po             | Andrew            | published        | 01-01-2021         | 1      |
      | Brent    2 | detail body1 | Trading Suspensions | ui-98-po             | Brent             | published        | -1 days            | 1      |
      | David  154 | detail body1 | Trading Suspensions | 34-12345             | David             | published        | -30 days           | 0      |
      | Nanci   14 | detail body1 | ALJ Orders          | 34-12345             | Nanci             | published        | -22 days           | 0      |
      | Yolanda 25 | detail body1 | Trading Suspensions | 34-12345             | Yolanda           | published        | -5 days            | 1      |
      | Yolanda 15 | detail body1 | Trading Suspensions | 34-12345             | Yolanda           | published        | -5 days            | 1      |
      | Zack    16 | detail body1 | Trading Suspensions | ab-12-cd             | Zack              | published        | -80 days           | 1      |
      | Violet  15 | detail body1 | Trading Suspensions | 34-12345             | Violet            | published        | -31 days           | 1      |
    And I visit "/admin/content/release"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Yolanda 25"
    And I should see the link "Yolanda 15"
    And I should see the link "Violet 15"
    And I should see the link "David 154"
  When I fill in "Title" with "aNd"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should see the link "Yolanda 25"
    And I should see the link "Yolanda 15"
    And I should not see the link "Brent 2"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
  When I visit "/litigation/suspensions/david-154/edit"
    And I check the box "edit-status-value"
    And I press "Save"
    And I visit "/admin/content/release"
    And I fill in "Title" with "15"
    And I press "Apply"
  Then I should see the link "Violet 15"
    And I should see the link "Yolanda 15"
    And I should see the link "David 154"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Yolanda 25"

@api
Scenario: Validate Filters on Release Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
      | name     |
      | ui-98-po |
      | 34-12345 |
      | ab-12-cd |
    And "release" content:
      | title      | body         | field_release_type         | field_release_number | field_release_file_number | field_respondents | moderation_state | field_publish_date | status |
      | Andrew   1 | detail body1 | Trading Suspensions        | ui-98-po             | ui-98-po                  | Andrew            | published        | 01-01-2021         | 1      |
      | Brent    2 | detail body1 | Administrative Proceedings | ui-98-po             | ui-98-po                  | Brent             | published        | -1 days            | 1      |
      | David  154 | detail body1 | Trading Suspensions        | 34-12345             | 34-12345                  | David             | published        | -30 days           | 0      |
      | Nanci   14 | detail body1 | ALJ Orders                 | 34-12345             | 34-12345                  | Nanci             | published        | -22 days           | 0      |
      | Yolanda 25 | detail body1 | Trading Suspensions        | 34-12345             | 34-12345                  | Yolanda           | published        | -5 days            | 1      |
      | Yolanda 15 | detail body1 | ALJ Orders                 | 34-12345             | 34-12345                  | Yolanda           | published        | -5 days            | 1      |
      | Zack    16 | detail body1 | Trading Suspensions        | ab-12-cd             | ab-12-cd                  | Zack              | published        | -80 days           | 1      |
      | Violet  15 | detail body1 | Trading Suspensions        | 34-12345             | 34-12345                  | Violet            | published        | -31 days           | 1      |
    And I visit "/admin/content/release"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Zack 16"
    And I should see the link "Yolanda 25"
    And I should see the link "David 154"
    And I should see the link "Nanci 14"
  When I select "Trading Suspension" from "Release Type"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should see the link "Violet 15"
    And I should see the link "David 154"
    And I should not see the link "Brent 2"
    And I should not see the link "Nanci 14"
  When I select "Administrative Proceeding" from "Release Type"
    And I press the "Apply" button
  Then I should see the link "Brent 2"
    And I should not see the link "David 154"
    And I should not see the link "Violet 15"
    And I should not see the link "Andrew 1"
    And I should not see the link "Nanci 14"
  When I select "ALJ Order" from "Release Type"
    And I press the "Apply" button
  Then I should see the link "Yolanda 15"
    And I should see the link "Nanci 14"
    And I should not see the link "Violet 15"
    And I should not see the link "Brent 2"
  When I select "Yes" from "Published"
    And I press the "Apply" button
  Then I should not see the link "Andrew 1"
    And I should see the link "Yolanda 15"
    And I should not see the link "Violet 15"
    And I should not see the link "Brent 2"
    And I should not see the link "Nanci 14"
  When I select "-View All-" from "Release Type"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should see the link "Yolanda 15"
    And I should see the link "Violet 15"
    And I should see the link "Brent 2"
    And I should not see the link "Nanci 14"
  When I select "No" from "Published"
    And I press the "Apply" button
  Then I should see the link "Nanci 14"
    And I should see the link "David 154"
    And I should not see the link "Violet 15"
    And I should not see the link "Brent 2"
  When I select "-View All-" from "Published"
    And I select "ui-98-po" from "File Number"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"
  When I select "ab-12-cd" from "File Number"
    And I press the "Apply" button
  Then I should see the link "Zack 16"
    And I should not see the link "Brent 2"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"

@api @javascript
Scenario: Sorting Title on Admin Release Page
  Given I am logged in as a user with the "content_creator" role
  When "release" content:
      | title      | body         | field_release_type  | field_release_number | field_respondents | moderation_state | status |
      | Andrew   1 | detail body1 | Trading Suspensions | ui-98-po             | Andrew            | published        | 1      |
      | Brent    2 | detail body1 | Trading Suspensions | ui-98-po             | Brent             | published        | 1      |
      | Carl     3 | detail body1 | Trading Suspensions | 34-12345             | Carl              | published        | 1      |
      | David    4 | detail body1 | Trading Suspensions | 34-12345             | David             | published        | 1      |
    And I visit "/admin/content/release"
  Then "Andrew" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Carl" should precede "David" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click on the element with css selector "#view-title-table-column > a"
  Then "David" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Carl" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Andrew" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Publish Date on Admin Release Page
  Given I am logged in as a user with the "content_creator" role
  When "release" content:
      | title      | body         | field_publish_date | field_release_type  | field_release_number | field_respondents | moderation_state | status |
      | Andrew   1 | detail body1 | -1 days            | Trading Suspensions | ui-98-po             | Andrew            | published        | 1      |
      | Brent    2 | detail body1 | -14 days           | Trading Suspensions | ui-98-po             | Brent             | published        | 1      |
      | Carl     3 | detail body1 | -30 days           | Trading Suspensions | 34-12345             | Carl              | published        | 1      |
      | David    4 | detail body1 | -222 days          | Trading Suspensions | 34-12345             | David             | published        | 1      |
    And I visit "/admin/content/release"
  Then "Andrew" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Carl" should precede "David" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click on the element with css selector "#view-field-publish-date-table-column > a"
  Then "David" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Carl" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Andrew" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Release Type on Admin Release Page
  Given I am logged in as a user with the "content_creator" role
  When "release" content:
      | title      | body         | field_publish_date | field_release_type         | field_release_number | field_respondents | moderation_state | status |
      | Andrew   1 | detail body1 | -1 days            | Administrative Proceedings | ui-98-po             | Andrew            | published        | 1      |
      | Brent    2 | detail body1 | -14 days           | ALJ Orders                 | ui-98-po             | Brent             | published        | 1      |
      | Carl     3 | detail body1 | -30 days           | Trading Suspensions        | 34-12345             | Carl              | published        | 1      |
    And I visit "/admin/content/release"
  Then "Andrew" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
 When I click on the element with css selector "#view-field-release-type-table-column > a"
  Then "Carl" should precede "Andrew" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Andrew" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Release File on Admin Release Page
  Given I am logged in as a user with the "content_creator" role
  When I create "media" of type "static_file":
      | name         | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
      | Behat file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
      | Behat file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
      | Behat file 3 | published media     | behat-file_test.pdf     | This is description abs    |                          | 1      |
    And "release" content:
      | title      | body         | field_release_type         | field_respondents | moderation_state | status | field_release_file |
      | Andrew   1 | detail body1 | Administrative Proceedings | Andrew            | published        | 1      | Behat file 1       |
      | Brent    2 | detail body1 | ALJ Orders                 | Brent             | published        | 1      | Behat file 2       |
      | Carl     3 | detail body1 | Trading Suspensions        | Carl              | published        | 1      | Behat file 3       |
    And I visit "/admin/content/release"
  Then "Andrew" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Carl" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
 When I click on the element with css selector "#view-field-release-file-table-column > a"
   And I click on the element with css selector "#view-field-release-file-table-column > a"
  Then "Carl" should precede "Brent" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent" should precede "Andrew" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
