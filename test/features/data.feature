@list
Feature: Data List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Data List Page
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed             | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_publish_date  | field_date          |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now                 | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |                     |                     |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month            | 0      | Data                          | Enforcement                   | Data-Enforcement              |                     |                     |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month            | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |                     |                     |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month            | 1      | Data                          | Credit Ratings                | Data-Other                    |                     |                     |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 |                     | 1      | Data                          | General Counsel               | Data-InvestorComplaints       | 2018-12-05T17:00:00 |                     |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | 2018-07-05T17:00:00 | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          | 2018-03-05T17:00:00 | 2019-03-05T17:00:00 |
    | Behat Test 6 | Amazon Green Energy Data    | Test 7 | +3 month            | 1      | Data                          | Credit Ratings                | Data-Other                    |                     |                     |
    | Behat Test 7 | Oracle Green Energy Data    | Test 8 | +4 week             | 1      | Data                          | Credit Ratings                | Data-Other                    |                     |                     |
  When I visit "/data"
  Then I should see the heading "SEC and Markets Data"
    #list view should display link to article-data with display title as text
    And I should see the link "Apple Green Energy Data"
    #list view should not display draft items
    And I should not see the link "Google Green Energy Data"
    And I should see the link "Facebook Green Energy Data"
    And I should see the link "Netflix Green Energy Data"
    And I should see the link "Tesla Green Energy Data"
    #list view should display the correct Last Updated date which is to use modified date if specified
    And I should see the text "March 2019" in the "Tesla Green Energy Data" row
    #list view should display category
    And I should see the text "Broker-Dealers" in the "Apple Green Energy Data" row
    And I should see the text "Market Structure" in the "Facebook Green Energy Data" row
    And I should see the text "Investor Complaints" in the "Microsoft Green Energy Data" row
    And I should see the text "Public Companies" in the "Tesla Green Energy Data" row
    #test show items per page and pagination
    And I select "5" from "edit-items-per-page"
  Then I should see the text "1 to 5 of 7 items"
    And I should see the link "Next"
    And I should see the link "Last"
    And I click "Last"
    And I should see the text "6 to 7 of 7 items"

@api @javascript
Scenario: Data List Page Default Sorting
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month | 1      | Data                          | Enforcement                   | Data-Enforcement              |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-Other                    |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 | -3 month | 1      | Data                          | General Counsel               | Data-InvestorComplaints       |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          |
  When I visit "/data"
  Then "Netflix Green Energy Data" should precede "Apple Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Data" should precede "Facebook Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Data" should precede "Tesla Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Data List Page by Last Updated
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month | 1      | Data                          | Enforcement                   | Data-Enforcement              |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -3 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-Other                    |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 | -4 month | 1      | Data                          | General Counsel               | Data-InvestorComplaints       |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          |
  When I visit "/data"
    And I click the sort filter "Last Updated"
    And I wait for AJAX to finish
  Then "Tesla Green Energy Data" should precede "Microsoft Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Apple Green Energy Data" should precede "Netflix Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Data" should precede "Google Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Last Updated"
    And I wait for AJAX to finish
    And "Netflix Green Energy Data" should precede "Apple Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Data" should precede "Tesla Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Data" should precede "Facebook Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Data List Page by Title
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month | 1      | Data                          | Enforcement                   | Data-Enforcement              |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-Other                    |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 | -3 month | 1      | Data                          | General Counsel               | Data-InvestorComplaints       |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          |
  When I visit "/data"
    And I click the sort filter "Title"
    And I wait for AJAX to finish
  Then "Apple Green Energy Data" should precede "Facebook Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Data" should precede "Microsoft Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Data" should precede "Tesla Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Title"
    And I wait for AJAX to finish
    And "Tesla Green Energy Data" should precede "Netflix Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Data" should precede "Google Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Data" should precede "Apple Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Data List Page by Category
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month | 1      | Data                          | Enforcement                   | Data-Enforcement              |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-Other                    |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 | -3 month | 1      | Data                          | General Counsel               | Data-InvestorComplaints       |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          |
    | Behat Test 6 | Investment Company Data     | Test 7 | -6 month | 1      | Data                          | Investment Management         | Data-InvestmentCompanies      |
  When I visit "/data"
    And I click the sort filter "Category"
    And I wait for AJAX to finish
  Then "Apple Green Energy Data" should precede "Google Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Data" should precede "Facebook Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Data" should precede "Netflix Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Investment Company Data" should precede "Tesla Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Category"
    And I wait for AJAX to finish
    And "Netflix Green Energy Data" should precede "Tesla Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Data" should precede "Microsoft Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Data" should precede "Apple Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Investment Company Data" should precede "Apple Green Energy Data" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Data List Page by Division or Office and Category Selection
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_description_abstract |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            | Green Apple                |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month | 1      | Data                          | Enforcement                   | Data-Enforcement              | Yellow Google              |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Blue Facebook              |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-Other                    | Red Netflix                |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 | -3 month | 1      | Data                          | General Counsel               | Data-InvestorComplaints       | Pink Microsoft             |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-PublicCompanies          | White Tesla                |
    | Behat Test 6 | Investment Company Data     | Test 7 | -6 month | 1      | Data                          | Investment Management         | Data-InvestmentCompanies      | Lavender IC                |
  When I visit "/data"
    And I select "Data-BrokerDealers" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Apple Green Energy Data"
    And I should not see the link "Google Green Energy Data"
    And I select "Data-Enforcement" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Google Green Energy Data"
    And I should not see the link "Facebook Green Energy Data"
    And I select "Data-InvestmentCompanies" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Investment Company Data"
    And I should not see the link "Netflix Green Energy Data"
    And I select "Data-MarketStructure" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Facebook Green Energy Data"
    And I should not see the link "Netflix Green Energy Data"
    And I select "Data-Other" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Netflix Green Energy Data"
    And I should not see the link "Microsoft Green Energy Data"
    And I select "-View All-" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Microsoft Green Energy Data"
    And I should see the link "Tesla Green Energy Data"
  Then I select "Acquisitions" from "edit-tid"
    And I should see the link "Apple Green Energy Data"
    And I should not see the link "Google Green Energy Data"
    And I should see the text "Green Apple"
    And I select "Enforcement" from "edit-tid"
    And I should see the link "Google Green Energy Data"
    And I should not see the link "Apple Green Energy Data"
    And I should see the text "Yellow Google"
    And I select "Corporation Finance" from "edit-tid"
    And I should see the link "Facebook Green Energy Data"
    And I should not see the link "Google Green Energy Data"
    And I should see the text "Blue Facebook"
    And I select "Credit Ratings" from "edit-tid"
    And I should see the link "Netflix Green Energy Data"
    And I should not see the link "Facebook Green Energy Data"
    And I should see the text "Red Netflix"
    And I select "General Counsel" from "edit-tid"
    And I should see the link "Microsoft Green Energy Data"
    And I should not see the link "Netflix Green Energy Data"
    And I should see the text "Pink Microsoft"
    And I select "Investment Management" from "edit-tid"
    And I should see the link "Investment Company Data"
    And I should not see the link "Microsoft Green Energy Data"
    And I should see the text "Lavender IC"
    And I select "Minority and Women Inclusion" from "edit-tid"
    And I should see the link "Tesla Green Energy Data"
    And I should not see the link "Microsoft Green Energy Data"
    And I should see the text "White Tesla"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for data
  Given "tags" terms:
    | name       |
    | data       |
    And I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file  | field_description_abstract | status |
      | Behat Test File | static file          | behat-form1.pdf   | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                               | field_tags | field_description_abstract | field_contact_name | field_contact_email | field_display_title                                                           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file having article type as Data and CorpFin as Division | data       | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file having article type as Data and Corporate Finance as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/corpfin/data/verify-pdf-file-having-article-type-data-and-corpfin-division/edit"
    And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
    And I publish it
    And I am not logged in
    And I am on "/data"
  Then I should see the link "Verify PDF file having article type as Data and Corporate Finance as Division"
  When I click "Verify PDF file having article type as Data and Corporate Finance as Division"
  Then I should be on "/files/behat-form1.pdf"
