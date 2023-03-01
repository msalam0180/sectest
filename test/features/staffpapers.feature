@list
Feature: Staff Papers List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Staff Papers List Page
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 0      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     |
      | Behat Test 3 | Netflix Green Energy Paper   | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
      | Behat Test 6 | Amazon Green Energy Paper    | Test 7 | 2019-07-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
  When I visit "/dera/staff-papers"
  Then I should see the heading "Staff Papers and Analyses"
    #list view should display link to article-staff papers with display title as text
    And I should see the link "Apple Green Energy Paper"
    #list view should not display draft items
    And I should not see the link "Google Green Energy Paper"
    And I should see the link "Facebook Green Energy Paper"
    And I should see the link "Netflix Green Energy Paper"
    And I should see the link "Tesla Green Energy Paper"
    #list view should display the correct Last Updated date
    And I should see the text "June 2015" in the "Tesla Green Energy Paper" row
    And I should see the text "Jan. 2020" in the "Apple Green Energy Paper" row
    And I should see the text "March 2018" in the "Facebook Green Energy Paper" row
    And I should see the text "July 2019" in the "Amazon Green Energy Paper" row
    #list view should display category
    And I should see the text "Studies and Reports" in the "Apple Green Energy Paper" row
    And I should see the text "Working Papers" in the "Facebook Green Energy Paper" row
    And I should see the text "White Papers" in the "Netflix Green Energy Paper" row
    And I should see the text "Economics Notes" in the "Microsoft Green Energy Paper" row
    #test show items per page and pagination
  When I select "5" from "edit-items-per-page"
  Then I should see the text "1 to 5 of 6 items"
    And I should see the link "Next"
    And I should see the link "Last"
  When I click "Last"
  Then I should see the text "6 to 6 of 6 items"

@api @javascript
Scenario: Staff Papers List Page Default Sorting
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     |
      | Behat Test 3 | Netflix Green Energy Paper   | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
  When I visit "/dera/staff-papers"
  Then "Apple Green Energy Paper" should precede "Google Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Paper" should precede "Netflix Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Paper" should precede "Tesla Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Staff Papers List Page by Date
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     |
      | Behat Test 3 | Netflix Green Energy Paper   | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
  When I visit "/dera/staff-papers"
    And I click the sort filter "Date"
  Then "Tesla Green Energy Paper" should precede "Microsoft Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Paper" should precede "Facebook Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Paper" should precede "Apple Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Date"
  Then "Apple Green Energy Paper" should precede "Google Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Paper" should precede "Netflix Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Paper" should precede "Tesla Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Staff Papers List Page by Title
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     |
      | Behat Test 3 | 'Netflix Green Energy Paper' | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
  When I visit "/dera/staff-papers"
    And I click the sort filter "Title"
  Then "Apple Green Energy Paper" should precede "Google Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Paper" should precede "Microsoft Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "'Netflix Green Energy Paper'" should precede "Tesla Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "'Netflix Green Energy Paper'" should precede "Microsoft Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Paper" should precede "Facebook Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Paper" should precede "Apple Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Staff Papers List Page by Type
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     |
      | Behat Test 3 | Netflix Green Energy Paper   | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             |
  When I visit "/dera/staff-papers"
  #Please note that Article Subtype Economic-Analyses will show up as Studies and Reports on the Staff Papers List Page
    And I click the sort filter "Type"
  #For Type sorting, secondary sorting was changed from Published Date to always Published Date Descending for SEC.gov 7.4
  Then "Google Green Energy Paper" should precede "Microsoft Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Apple Green Energy Paper" should precede "Netflix Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Paper" should precede "Tesla Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Type"
  Then "Tesla Green Energy Paper" should precede "Facebook Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Paper" should precede "Apple Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Paper" should precede "Microsoft Green Energy Paper" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Staff Papers List Page by Year and Type Selection
  Given "secarticle" content:
      | title        | field_display_title          | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart  | field_list_page_det_secarticle | field_description_abstract |
      | Behat Test 0 | Apple Green Energy Paper     | Test 1 | 2020-01-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economic-Analyses | Green Apple                    | Apple Abstract             |
      | Behat Test 1 | Google Green Energy Paper    | Test 2 | 2019-02-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   | Yellow Google                  | Google Abstract            |
      | Behat Test 2 | Facebook Green Energy Paper  | Test 3 | 2018-03-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WorkingPapers     | Blue Facebook                  | Facebook Abstract          |
      | Behat Test 3 | Netflix Green Energy Paper   | Test 4 | 2017-04-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-WhitePapers       | Red Netflix                    | Netflix Abstract           |
      | Behat Test 4 | Microsoft Green Energy Paper | Test 5 | 2016-05-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Economics-Notes   | Pink Microsoft                 | Microsoft Abstract         |
      | Behat Test 5 | Tesla Green Energy Paper     | Test 6 | 2015-06-17T17:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | Staff Papers-Other             | White Tesla                    | Tesla Abstract             |
  When I visit "/dera/staff-papers"
    And I select "2020" from "edit-year"
    And I should see the link "Apple Green Energy Paper"
    And I should see the text "Green Apple"
    And I should not see the link "Google Green Energy Paper"
    And I select "2019" from "edit-year"
    And I should see the link "Google Green Energy Paper"
    And I should not see the link "Tesla Green Energy Paper"
    And I should see the text "Yellow Google"
    And I select "2018" from "edit-year"
    And I should see the link "Facebook Green Energy Paper"
    And I should not see the link "Netflix Green Energy Paper"
    And I should see the text "Blue Facebook"
    And I select "2017" from "edit-year"
    And I should see the link "Netflix Green Energy Paper"
    And I should not see the link "Microsoft Green Energy Paper"
    And I should see the text "Red Netflix"
    And I select "2016" from "edit-year"
    And I should see the link "Microsoft Green Energy Paper"
    And I should not see the link "Telsa Green Energy Paper"
    And I should see the text "Pink Microsoft"
    And I select "2015" from "edit-year"
    And I should see the link "Tesla Green Energy Paper"
    And I should not see the link "Apple Green Energy Paper"
    And I should see the text "White Tesla"
    And I select "-View All-" from "edit-year"
  Then I select "Studies and Reports" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Apple Green Energy Paper"
    And I should not see the link "Telsa Green Energy Paper"
    And I select "Economics Notes" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Google Green Energy Paper"
    And I should see the link "Microsoft Green Energy Paper"
    And I should not see the link "Apple Green Energy Paper"
    And I select "Working Papers" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Facebook Green Energy Paper"
    And I should not see the link "Google Green Energy Paper"
    And I select "White Papers" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Netflix Green Energy Paper"
    And I should not see the link "Facebook Green Energy Paper"
    And I select "-View All-" from "edit-field-article-sub-type-secart-value"
    And I should see the link "Tesla Green Energy Paper"
    And I select "-View All-" from "edit-year"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for studies and papers
  Given I create "media" of type "static_file":
      | name              | field_media_file        | status |
      | Behat Test File 1 | behat-file_stfpaper.pdf | 1      |
    And "secarticle" content:
      | title                                                                                  | field_article_sub_type_secart | field_display_title                                                                    | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file having article type as Staff Papers and sub type as Studies and Papers | Studies and Reports           | Verify PDF file having article type as Staff Papers and sub type as Studies and Papers | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Staff Papers                  | Economic and Risk Analysis    | 123-KO               | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as Staff Papers and sub type as Studies and Papers" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File 1" on the "Use existing media" field
    And I wait for AJAX to finish
    And I publish it
  When I am not logged in
    And I am on "/dera/staff-papers"
  Then I should see the link "Verify PDF file having article type as Staff Papers and sub type as Studies and Papers"
  When I click "Verify PDF file having article type as Staff Papers and sub type as Studies and Papers"
  Then I should be on "/files/behat-file_stfpaper.pdf"
