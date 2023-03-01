@list
Feature: Academic Publication List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Academic Publication List Page
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue                  | 2019-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       |
    | Behat Publication 2 | Behat Test 2        | The Sky is Black                 | 2018-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Testimonial Rule      |
    | Behat Publication 3 | Behat Test 3        | The Sky is Orange                | 2018-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 4 | Behat Test 4        | The Sky is Violet                | 2017-04-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 5 | Behat Test 5        | The Sky is Red                   | 2017-01-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 6 | Behat Test 6        | The Sky is Pink                  | 2017-02-15T17:00:00    | 0      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
  When I visit "/dera/academic-publications"
  Then I should see the heading "Publications"
    #list view should display text to publications with list page detail as text
    And I should see the text "The Sky is Gray"
    #list view should not display draft items
    And I should not see the text "The Sky is Pink"
    And I should see the text "The Sky is Black"
    And I should see the text "The Sky is Orange"
    And I should see the text "The Sky is Red"
    #list view should display date
    And I should see the text "May 2020" in the "The Sky is Gray" row
    And I should see the text "Nov. 2018" in the "The Sky is Black" row
    And I should see the text "Jan. 2017" in the "The Sky is Red" row
    #list view should display topic
    And I should see the text "Insider Trading" in the "The Sky is Gray" row
    And I should see the text "Testimonial Rule" in the "The Sky is Black" row
    And I should see the text "DERA analysis" in the "The Sky is Red" row
    #test show items per page and pagination
    And I select "5" from "edit-items-per-page"
  Then I should see the text "1 to 5 of 6 items"
    And I should see the link "Next"
    And I should see the link "Last"
  When I click "Last"
    And I wait 1 seconds
  Then I should see the text "6 to 6 of 6 items"

@api
Scenario: Default Sorting for DERA Academic Publications List Page
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue                  | 2019-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       |
    | Behat Publication 2 | Behat Test 2        | The Sky is Black                 | 2018-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Testimonial Rule      |
    | Behat Publication 3 | Behat Test 3        | The Sky is Orange                | 2018-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 4 | Behat Test 4        | The Sky is Violet                | 2017-04-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 5 | Behat Test 5        | The Sky is Red                   | 2017-01-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
  When I visit "/dera/academic-publications"
    And I should see the text "May 2020" in the "The Sky is Gray" row
    And I should see the text "July 2019" in the "The Sky is Blue" row
    And I should see the text "Nov. 2018" in the "The Sky is Black" row
    And I should see the text "Aug. 2018" in the "The Sky is Orange" row
    And I should see the text "April 2017" in the "The Sky is Violet" row
    And I should see the text "Jan. 2017" in the "The Sky is Red" row
  Then "The Sky is Gray" should precede "The Sky is Blue" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Black" should precede "The Sky is Orange" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Violet" should precede "The Sky is Red" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"

@api @javascript
Scenario: Sort DERA Academic Publications List Page by Date
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue                  | 2019-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       |
    | Behat Publication 2 | Behat Test 2        | The Sky is Black                 | 2018-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Testimonial Rule      |
    | Behat Publication 3 | Behat Test 3        | The Sky is Orange                | 2018-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 4 | Behat Test 4        | The Sky is Violet                | 2017-04-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 5 | Behat Test 5        | The Sky is Red                   | 2017-01-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
  When I visit "/dera/academic-publications"
    And I click the sort filter "Date"
    And I wait 1 seconds
  Then "The Sky is Red" should precede "The Sky is Violet" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Orange" should precede "The Sky is Black" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Blue" should precede "The Sky is Gray" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
  When I click the sort filter "Date"
    And I wait 1 seconds
  Then "The Sky is Gray" should precede "The Sky is Blue" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Black" should precede "The Sky is Orange" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Violet" should precede "The Sky is Red" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"

@api @javascript
Scenario: Sort DERA Academic Publications List Page by Publication Title
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue                  | 2019-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       |
    | Behat Publication 2 | Behat Test 2        | The Sky is Black                 | 2018-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Testimonial Rule      |
    | Behat Publication 3 | Behat Test 3        | The Sky is Orange                | 2018-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 4 | Behat Test 4        | The Sky is Violet                | 2017-04-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 5 | Behat Test 5        | The Sky is Red                   | 2017-01-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
  When I visit "/dera/academic-publications"
    And I click the sort filter "Publication"
    And I wait 1 seconds
  Then "The Sky is Black" should precede "The Sky is Blue" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Gray" should precede "The Sky is Orange" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Red" should precede "The Sky is Violet" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
  When I click the sort filter "Publication"
    And I wait 1 seconds
  Then "The Sky is Violet" should precede "The Sky is Red" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Orange" should precede "The Sky is Gray" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Blue" should precede "The Sky is Black" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"

@api @javascript
Scenario: Sort DERA Academic Publications List Page by Topic
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue                  | 2019-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       |
    | Behat Publication 2 | Behat Test 2        | The Sky is Black                 | 2018-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Testimonial Rule      |
    | Behat Publication 3 | Behat Test 3        | The Sky is Orange                | 2018-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
    | Behat Publication 4 | Behat Test 4        | The Sky is Violet                | 2017-04-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    | Behat Publication 5 | Behat Test 5        | The Sky is Red                   | 2017-01-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA analysis         |
  When I visit "/dera/academic-publications"
    And I click the sort filter "Topic(s)"
    And I wait 1 seconds
  Then "The Sky is Orange" should precede "The Sky is Blue" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Gray" should precede "The Sky is Black" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
  When I click the sort filter "Topic(s)"
    And I wait 1 seconds
  Then "The Sky is Black" should precede "The Sky is Gray" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"
    And "The Sky is Blue" should precede "The Sky is Orange" for the query "//td[contains(@class, 'views-field views-field-field-list-page-det-secarticle')]"

@api @javascript
Scenario: Filter DERA Academic Publications List by Year and Publication Status Selection
  Given "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags | field_ext_pub_secarticle |
    | Behat Publication 0 | Behat Test 0        | The Car is Black                 | 2022-06-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  |                          |
    | Behat Publication 1 | Behat Test 1        | The Car is Blue                  | 2021-08-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  |                          |
    | Behat Publication 2 | Behat Test 2        | The Car is Silver                | 2020-02-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  |                          |
    | Behat Publication 3 | Behat Test 3        | The Car is Red                   | 2019-12-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  | Forthcoming              |
    | Behat Publication 4 | Behat Test 4        | The Car is Gray                  | 2018-03-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  | Published                |
    | Behat Publication 5 | Behat Test 5        | The Car is White                 | 2017-11-19T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  | Forthcoming              |
    | Behat Publication 5 | Behat Test 5        | The Car is Gold                  | 2016-11-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Test Data  | Published                |
  When I visit "/dera/academic-publications"
    And I select "2020" from "edit-year"
    And I should see the text "The Car is Silver"
    And I should not see the text "The Car is Gold"
    And I select "2017" from "edit-year"
    And I should see the text "The Car is White"
    And I should not see the text "The Car is Gray"
    And I select "2016" from "edit-year"
    And I should see the text "The Car is Gold"
    And I should not see the text "The Car is White"
    And I select "2019" from "edit-year"
    And I should see the text "The Car is Red"
    And I should not see the text "The Car is Gray"
    And I select "2021" from "edit-year"
    And I should see the text "The Car is Blue"
    And I should not see the text "The Car is Gray"
    And I select "2022" from "edit-year"
    And I should see the text "The Car is Black"
    And I should not see the text "The Car is Blue"
    And I select "2018" from "edit-year"
    And I should see the text "The Car is Gray"
    And I should not see the text "The Car is Red"
    And I select "-View All-" from "edit-year"
  Then I select "Forthcoming" from "edit-field-ext-pub-secarticle-value"
    And I should see the text "The Car is White"
    And I should see the text "The Car is Red"
    And I should not see the text "The Car is Gray"
    And I should not see the text "The Car is Silver"
    And I select "Published" from "edit-field-ext-pub-secarticle-value"
    And I should see the text "The Car is Gold"
    And I should see the text "The Car is Gray"
    And I should not see the text "The Car is Red"
    And I should not see the text "The Car is Black"
