@list
Feature: Investor Alerts List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

  @api @javascript
  Scenario: View the Investor Alerts List Page
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2020-05-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2016-06-17T17:00:00 | 0      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2021-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2019-12-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2018-01-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2017-11-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
      | Behat Test 6 | Amazon Green Energy Alert    | Test 7 | 2019-10-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
    When I visit "/investor/alerts"
    Then I should see the heading "Investor Alerts and Bulletins"
      #list view should display link to article-investor alerts and bulletins with display title as text
      And I should see the link "Apple Green Energy Alert"
      #list view should not display draft items
      And I should not see the link "Google Green Energy Alert"
      And I should see the link "Facebook Green Energy Alert"
      And I should see the link "Netflix Green Energy Alert"
      And I should see the link "Tesla Green Energy Alert"
      #list view should display the date
      And I should see the date "2017-11-17 17:00:00" in the "Tesla Green Energy Alert" row
      And I should see the date "2020-05-17 17:00:00" in the "Apple Green Energy Alert" row
      And I should see the date "2021-03-17 17:00:00" in the "Facebook Green Energy Alert" row
      And I should see the date "2019-10-17 17:00:00" in the "Amazon Green Energy Alert" row
      #list view should display category
      And I should see the text "Investment Management" in the "Apple Green Energy Alert" row
      And I should see the text "Corporation Finance" in the "Facebook Green Energy Alert" row
      And I should see the text "Trading and Markets" in the "Netflix Green Energy Alert" row
      And I should see the text "Enforcement" in the "Tesla Green Energy Alert" row
      And I should see the text "Showing 1 to 6 of 6 entries"

  @api @javascript
  Scenario: Investor Alerts List Page Default Sorting
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2020-05-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2016-06-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2021-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2019-12-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2018-01-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2017-11-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
    When I visit "/investor/alerts"
    Then "Facebook Green Energy Alert" should precede "Apple Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Tesla Green Energy Alert" should precede "Google Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Netflix Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Sort Investor Alerts List Page by Date
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2018-07-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2018-06-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2018-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2017-12-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2017-01-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2016-11-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
    When I visit "/investor/alerts"
      And I click the sort filter "Date"
    Then "Tesla Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Netflix Green Energy Alert" should precede "Facebook Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Google Green Energy Alert" should precede "Apple Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I click the sort filter "Date"
      And "Apple Green Energy Alert" should precede "Google Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Facebook Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Netflix Green Energy Alert" should precede "Tesla Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript @insulated
  Scenario: Sort Investor Alerts List Page by Title
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2018-07-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2018-06-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2018-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2017-12-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2017-01-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2016-11-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
    When I visit "/investor/alerts"
      And I click the sort filter "Title"
    Then "Apple Green Energy Alert" should precede "Facebook Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Netflix Green Energy Alert" should precede "Tesla Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Google Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I click the sort filter "Title"
      And "Netflix Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Tesla Green Energy Alert" should precede "Facebook Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Google Green Energy Alert" should precede "Apple Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript
  Scenario: Sort Investor Alerts List Page by Category
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2018-07-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2018-06-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2018-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2017-12-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2017-01-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2016-11-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       |
    When I visit "/investor/alerts"
      And I click the sort filter "Category"
    Then "Facebook Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Apple Green Energy Alert" should precede "Netflix Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Google Green Energy Alert" should precede "Tesla Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And I click the sort filter "Category"
      And "Netflix Green Energy Alert" should precede "Apple Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Tesla Green Energy Alert" should precede "Google Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "Facebook Green Energy Alert" should precede "Microsoft Green Energy Alert" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

  @api @javascript @insulated
  Scenario: Filter Investor Alerts List Page by Year and Category Selection
    Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_division_office | field_description_abstract |
      | Behat Test 0 | Apple Green Energy Alert     | Test 1 | 2018-07-17T17:00:00 | 1      | Investor Alerts and Bulletins | Investment Management         | Enforcement           | Green Apple                |
      | Behat Test 1 | Google Green Energy Alert    | Test 2 | 2019-06-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   | Corporation Finance   | Yellow Google              |
      | Behat Test 2 | Facebook Green Energy Alert  | Test 3 | 2020-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       | Blue Facebook              |
      | Behat Test 3 | Netflix Green Energy Alert   | Test 4 | 2017-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Trading and Markets           |                       | Red Netflix                |
      | Behat Test 4 | Microsoft Green Energy Alert | Test 5 | 2016-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           |                       | Pink Microsoft             |
      | Behat Test 5 | Tesla Green Energy Alert     | Test 6 | 2015-03-17T17:00:00 | 1      | Investor Alerts and Bulletins | Enforcement                   |                       | White Tesla                |
    When I visit "/investor/alerts"
      And I select "2018" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Apple Green Energy Alert"
      And I should not see the link "Tesla Green Energy Alert"
      And I should see the text "Green Apple"
      And I select "2019" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Google Green Energy Alert"
      And I should not see the link "Apple Green Energy Alert"
      And I should see the text "Yellow Google"
      And I select "2020" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Facebook Green Energy Alert"
      And I should not see the link "Google Green Energy Alert"
      And I should see the text "Blue Facebook"
      And I select "2017" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Netflix Green Energy Alert"
      And I should not see the link "Facebook Green Energy Alert"
      And I should see the text "Red Netflix"
      And I select "2016" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Microsoft Green Energy Alert"
      And I should not see the link "Netflix Green Energy Alert"
      And I should see the text "Pink Microsoft"
      And I select "2015" from "edit-year"
      And I wait for AJAX to finish
      And I should see the link "Tesla Green Energy Alert"
      And I should not see the link "Microsoft Green Energy Alert"
      And I should see the text "White Tesla"
    Then I click "EnforcementFilterButton"
      And I wait for AJAX to finish
      And I should see the link "Apple Green Energy Alert"
      And I should see the link "Google Green Energy Alert"
      And I should see the link "Tesla Green Energy Alert"
      And I should not see the link "Facebook Green Energy Alert"
      And I should not see the link "Microsoft Green Energy Alert"
      And I click "InvestmentManagementFilterButton"
      And I wait for AJAX to finish
      And I should see the link "Apple Green Energy Alert"
      And I should not see the link "Tesla Green Energy Alert"
      And I click "TradingandMarketsFilterButton"
      And I wait for AJAX to finish
      And I should see the link "Netflix Green Energy Alert"
      And I should not see the link "Apple Green Energy Alert"
      And I click "CorporationFinanceFilterButton"
      And I wait for AJAX to finish
      And I should see the link "Microsoft Green Energy Alert"
      And I should see the link "Google Green Energy Alert"
      And I should see the link "Facebook Green Energy Alert"
      And I should not see the link "Tesla Green Energy Alert"
      And I click "View All"
      And I wait for AJAX to finish
      And I should see the link "Apple Green Energy Alert"
      And I should see the link "Google Green Energy Alert"
      And I should see the link "Tesla Green Energy Alert"
      And I should see the link "Netflix Green Energy Alert"
      And I should see the link "Microsoft Green Energy Alert"
      And I should see the link "Facebook Green Energy Alert"

  @api @javascript
  Scenario: Verify PDF file opens when the link is clicked from the list view for alerts
    Given I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file        | field_description_abstract | status |
      | Behat Test File | static file          | behat-file_invalert.pdf | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                               | field_display_title                                                 | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file having article type as Investor Alert and Bulletins | Verify PDF file having article type as Investor Alert and Bulletins | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
    When I am logged in as a user with the "content_approver" role
      And I visit "/admin/content"
      And I click "Edit" in the "Verify PDF file having article type as Investor Alert and Bulletins" row
      And I wait 2 seconds
      And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
      And I publish it
      And I am not logged in
      And I am on "/investor/alerts"
    Then I should see the text "Verify PDF file having article type as Investor Alert and Bulletins"
    When I click "Verify PDF file having article type as Investor Alert and Bulletins"
      And I wait 2 seconds
    Then I should be on "/files/behat-file_invalert.pdf"
