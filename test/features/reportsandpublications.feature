@list
Feature: Reports and Publications List Page
    As a visitor to SEC.gov
    I want to be able to view and sort through the information on List Pages
    So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Reports and Publications List Page
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_article_sub_type_secart                 | field_media_file_upload |
      | Behat Test 0 | Apple Green Energy Report     | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-InvestorPublications |                         |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 0      | Reports and Publications      | Reports and Publications-AnnualReports        |                         |
      | Behat Test 2 | Facebook Green Energy Report  |        | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-BuyAmericanAct       | Behat File              |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-FAIRAct              |                         |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |                         |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |                         |
      | Behat Test 6 | Amazon Green Energy Report    | Test 7 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |                         |
      | Behat Test 7 | Oracle Green Energy Report    | Test 8 | 2016-11-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |                         |
  When I am on "/reports"
  Then I should see the heading "Reports and Publications"
    And I should see the text "This listing includes periodic SEC reports and publications. See also FOIA Frequently Requested Documents and SEC Data Resources for periodic data reports and updates. For occasional reports on current trends and issues facing the securities industry, choose “Special Studies” from the “Category” field below."
    And I should see the link "FOIA Frequently Requested Documents"
    And the hyperlink "FOIA Frequently Requested Documents" should match the Drupal url "https://www.sec.gov/foia-frequently-requested-documents"
    And I should see the link "SEC Data Resources"
    And the hyperlink "SEC Data Resources" should match the Drupal url "https://www.sec.gov/sec-data-resources"
    #list view should display link to article-report and publications with display title as text
    And I should see the link "Apple Green Energy Report"
    #list view should not display draft items
    And I should not see the link "Google Green Energy Report"
    And I should see the link "Facebook Green Energy Report (PDF)"
    And I should see the link "Oracle Green Energy Report"
    And I should see the link "Tesla Green Energy Report"
    #list view should display date
    And I should see the date "2020-01-17 17:00:00" in the "Apple Green Energy Report" row
    And I should see the date "2018-03-17 17:00:00" in the "Facebook Green Energy Report (PDF)" row
    And I should see the date "2017-04-17 17:00:00" in the "Netflix Green Energy Report" row
    And I should see the date "2016-10-17 17:00:00" in the "Amazon Green Energy Report" row
    #list view should display category
    And I should see the text "Investor Publications" in the "Apple Green Energy Report" row
    And I should see the text "Strategic Plan" in the "Microsoft Green Energy Report" row
    And I should see the text "Special Studies" in the "Oracle Green Energy Report" row
    And I should see the text "FAIR Act" in the "Netflix Green Energy Report" row
    And I should see the text "Buy American Act" in the "Facebook Green Energy Report" row
    And I should see the text "Showing 1 to 7 of 7 entries"

@api @javascript
Scenario: Reports and Publications List Page Default Sorting
  Given "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_article_sub_type_secart                 |
      | Behat Test 0 | Apple Green Energy Report     | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-InvestorPublications |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-AnnualReports        |
      | Behat Test 2 | Facebook Green Energy Report  | Test 3 | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-BuyAmericanAct       |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-FAIRAct              |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |
  When I visit "/reports"
  Then "Apple Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Report" should precede "Netflix Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Reports and Publications List Page by Date
  Given "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_article_sub_type_secart                 |
      | Behat Test 0 | Apple Green Energy Report     | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-InvestorPublications |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-AnnualReports        |
      | Behat Test 2 | Facebook Green Energy Report  | Test 3 | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-BuyAmericanAct       |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-FAIRAct              |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |
  When I visit "/reports"
    And I click the sort filter "Date"
  Then "Tesla Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Date"
    And "Apple Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Report" should precede "Netflix Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Reports and Publications List Page by Title
  Given "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_article_sub_type_secart                 |
      | Behat Test 0 | 'Apple Green Energy Report'   | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-InvestorPublications |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-AnnualReports        |
      | Behat Test 2 | Facebook Green Energy Report  | Test 3 | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-BuyAmericanAct       |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-FAIRAct              |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |
  When I visit "/reports"
    And I click the sort filter "Title"
  Then "'Apple Green Energy Report'" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Title"
    And "Netflix Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Report" should precede "'Apple Green Energy Report'" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Reports and Publications List Page by Category
  Given "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_article_sub_type_secart                 |
      | Behat Test 0 | Apple Green Energy Report     | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-InvestorPublications |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-AnnualReports        |
      | Behat Test 2 | Facebook Green Energy Report  | Test 3 | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-BuyAmericanAct       |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-FAIRAct              |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-StrategicPlan        |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Reports and Publications-SpecialStudies       |
  When I visit "/reports"
    And I click the sort filter "Category"
  Then "Google Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Category"
    And "Microsoft Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Apple Green Energy Report" should precede "Netflix Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Reports and Publications List Page by Year, Category and Division or Office Selection
  Given "secarticle" content:
      | title        | field_display_title           | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart                 |
      | Behat Test 0 | Apple Green Energy Report     | Test 1 | 2020-01-17T17:00:00 | 1      | Reports and Publications      | Acquisitions                  | Reports and Publications-InvestorPublications |
      | Behat Test 1 | Google Green Energy Report    | Test 2 | 2019-02-17T17:00:00 | 1      | Reports and Publications      | Enforcement                   | Reports and Publications-AnnualReports        |
      | Behat Test 2 | Facebook Green Energy Report  | Test 3 | 2018-03-17T17:00:00 | 1      | Reports and Publications      | Corporation Finance           | Reports and Publications-BuyAmericanAct       |
      | Behat Test 3 | Netflix Green Energy Report   | Test 4 | 2017-04-17T17:00:00 | 1      | Reports and Publications      | Credit Ratings                | Reports and Publications-FAIRAct              |
      | Behat Test 4 | Microsoft Green Energy Report | Test 5 | 2016-12-17T17:00:00 | 1      | Reports and Publications      | General Counsel               | Reports and Publications-StrategicPlan        |
      | Behat Test 5 | Tesla Green Energy Report     | Test 6 | 2016-10-17T17:00:00 | 1      | Reports and Publications      | Minority and Women Inclusion  | Reports and Publications-SpecialStudies       |
  When I visit "/reports"
    And I select "2020" from "edit-year"
    And I wait for AJAX to finish
    And I should see the link "Apple Green Energy Report"
    And I should not see the link "Tesla Green Energy Report"
    And I select "2019" from "edit-year"
    And I wait for AJAX to finish
    And I should see the link "Google Green Energy Report"
    And I should not see the link "Apple Green Energy Report"
    And I select "2018" from "edit-year"
    And I wait for AJAX to finish
    And I should see the link "Facebook Green Energy Report"
    And I should not see the link "Google Green Energy Report"
    And I select "2017" from "edit-year"
    And I wait for AJAX to finish
    And I should see the link "Netflix Green Energy Report"
    And I should not see the link "Facebook Green Energy Report"
    And I select "2016" from "edit-year"
    And I wait for AJAX to finish
    And I should see the link "Microsoft Green Energy Report"
    And I should see the link "Tesla Green Energy Report"
    And I should not see the link "Facebook Green Energy Report"
    And I should not see the link "Google Green Energy Report"
    And I select "-View All-" from "edit-year"
    And I wait for AJAX to finish
  Then I select "Investor Publications" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Apple Green Energy Report"
    And I should not see the link "Tesla Green Energy Report"
    And I should see the text "Acquisitions"
    And I select "Annual Reports" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Google Green Energy Report"
    And I should not see the link "Apple Green Energy Report"
    And I should see the text "Enforcement"
    And I select "Buy American Act" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Facebook Green Energy Report"
    And I should not see the link "Google Green Energy Report"
    And I should see the text "Corporation Finance"
    And I select "FAIR Act" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Netflix Green Energy Report"
    And I should not see the link "Facebook Green Energy Report"
    And I should see the text "Credit Ratings"
    And I select "Strategic Plan" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Microsoft Green Energy Report"
    And I should not see the link "Netflix Green Energy Report"
    And I should see the text "General Counsel"
    And I select "Special Studies" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I should see the link "Tesla Green Energy Report"
    And I should not see the link "Microsoft Green Energy Report"
    And I should see the text "Minority and Women Inclusion"
    And I select "-View All-" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
    And I select "Acquisitions" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Apple Green Energy Report"
    And I should not see the link "Tesla Green Energy Report"
    And I select "Enforcement" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Google Green Energy Report"
    And I should not see the link "Apple Green Energy Report"
    And I select "Corporation Finance" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Facebook Green Energy Report"
    And I should not see the link "Google Green Energy Report"
    And I select "Credit Ratings" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Netflix Green Energy Report"
    And I should not see the link "Facebook Green Energy Report"
    And I select "General Counsel" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Microsoft Green Energy Report"
    And I should not see the link "Netflix Green Energy Report"
    And I select "Minority and Women Inclusion" from "edit-tid"
    And I wait for AJAX to finish
    And I should see the link "Tesla Green Energy Report"
    And I should not see the link "Microsoft Green Energy Report"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for reports
  Given I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file      | field_description_abstract | status |
      | Behat Test File | static file          | behat-file_rptpub.pdf | This is description abs    | 1      |
    And  "secarticle" content:
      | title                                                                                      | field_article_sub_type_secart | field_display_title                                                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file having article type as Reports and Publication and Agency-Wide as Division | Annual Reports                | Verify PDF file having article type as Reports and Publication and Agency-Wide as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Reports and Publications      | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as Reports and Publication and Agency-Wide as Division" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
    And I wait for AJAX to finish
    And I publish it
    And I am not logged in
    And I visit "/reports"
    And I should see the link "Verify PDF file having article type as Reports and Publication and Agency-Wide as Division"
    And I click "Verify PDF file having article type as Reports and Publication and Agency-Wide as Division"
    And I wait 2 seconds
  Then I should be on "/files/behat-file_rptpub.pdf"
