@list
Feature: Market Structure List Page
        As a visitor to SEC.gov
        I want to be able to view and sort through the information on List Pages
        So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Market Structure List Page
  Given "secarticle" content:
    | title        | field_display_title         | body   | changed             | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_publish_date  | field_list_page_det_secarticle | field_date          |
    | Behat Test 0 | Apple Green Energy Data     | Test 1 | now                 | 1      | Data                          | Acquisitions                  | Data-MarketStructure          |                     | Market Activity Data Series    |                     |
    | Behat Test 1 | Google Green Energy Data    | Test 2 | -1 month            | 0      | Data                          | Enforcement                   | Data-MarketStructure          |                     | Quote Life Data Series         |                     |
    | Behat Test 2 | Facebook Green Energy Data  | Test 3 | -2 month            | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |                     | Behat Activity Data Series     |                     |
    | Behat Test 3 | Netflix Green Energy Data   | Test 4 | +1 month            | 1      | Data                          | Credit Ratings                | Data-MarketStructure          |                     | Jira Activity Data Series      |                     |
    | Behat Test 4 | Microsoft Green Energy Data | Test 5 |                     | 1      | Data                          | General Counsel               | Data-MarketStructure          | 2018-12-05T17:00:00 | HP ALM Activity Data Series    | 2019-12-05T17:00:00 |
    | Behat Test 5 | Tesla Green Energy Data     | Test 6 | 2018-07-05T17:00:00 | 1      | Data                          | Minority and Women Inclusion  | Data-MarketStructure          | 2018-03-05T17:00:00 | Gitlab Activity Data Series    | 2019-03-05T17:00:00 |
    | Behat Test 6 | Amazon Green Energy Data    | Test 7 | +3 month            | 1      | Data                          | Credit Ratings                | Data-MarketStructure          |                     | Behat Activity Data Series     |                     |
    | Behat Test 7 | Oracle Green Energy Data    | Test 8 | +4 week             | 1      | Data                          | Credit Ratings                | Data-MarketStructure          |                     | Behat Activity Data Series     |                     |
  When I visit "/marketstructure/data"
  Then I should see the heading "Market Structure Data Downloads"
    #list view should display link to article-data with display title as text
    And I should see the link "Apple Green Energy Data"
    #list view should not display draft items
    And I should not see the link "Google Green Energy Data"
    And I should see the link "Facebook Green Energy Data"
    And I should see the link "Netflix Green Energy Data"
    And I should see the link "Tesla Green Energy Data"
    #list view should display the correct Last Updated date which is to use modified date if specified
    And I should see the text "March 2019" in the "Tesla Green Energy Data" row
    And I should see the text "Dec. 2019" in the "Microsoft Green Energy Data" row
    #list view should display category
    And I should see the text "Market Activity Data Series" in the "Apple Green Energy Data" row
    And I should see the text "Behat Activity Data Series" in the "Facebook Green Energy Data" row
    And I should see the text "HP ALM Activity Data Series" in the "Microsoft Green Energy Data" row
    And I should see the text "Gitlab Activity Data Series" in the "Tesla Green Energy Data" row
    #test show items per page and pagination
    And I select "5" from "edit-items-per-page"
  Then I should see the text "1 to 5 of 7 items"
    And I should see the link "Next"
    And I should see the link "Last"
    And I click "Last"
    And I should see the text "6 to 7 of 7 items"

@api @javascript
Scenario: Market Structure List Page Default Sorting
  Given "secarticle" content:
    | title        | field_display_title           | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat Test 0 | Apple Green Energy Report     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat Test 1 | Google Green Energy Report    | Test 2 | -3 month | 1      | Data                          | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat Test 2 | Facebook Green Energy Report  | Test 3 | -1 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Behat Activity Data Series     |
    | Behat Test 3 | Netflix Green Energy Report   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-MarketStructure          | Jira Activity Data Series      |
    | Behat Test 4 | Microsoft Green Energy Report | Test 5 | -2 month | 1      | Data                          | General Counsel               | Data-MarketStructure          | HP ALM Activity Data Series    |
    | Behat Test 5 | Tesla Green Energy Report     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-MarketStructure          | Gitlab Activity Data Series    |
  When I visit "/marketstructure/data"
  Then "Netflix Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Market Structure List Page by Last Updated
  Given "secarticle" content:
    | title        | field_display_title           | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat Test 0 | Apple Green Energy Report     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat Test 1 | Google Green Energy Report    | Test 2 | -4 month | 1      | Data                          | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat Test 2 | Facebook Green Energy Report  | Test 3 | -1 month | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Behat Activity Data Series     |
    | Behat Test 3 | Netflix Green Energy Report   | Test 4 | +1 month | 1      | Data                          | Credit Ratings                | Data-MarketStructure          | Jira Activity Data Series      |
    | Behat Test 4 | Microsoft Green Energy Report | Test 5 | -3 month | 1      | Data                          | General Counsel               | Data-MarketStructure          | HP ALM Activity Data Series    |
    | Behat Test 5 | Tesla Green Energy Report     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-MarketStructure          | Gitlab Activity Data Series    |
  When I am on "/marketstructure/data"
    And I click the sort filter "Last Updated"
  Then "Tesla Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Apple Green Energy Report" should precede "Netflix Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Last Updated"
  Then "Netflix Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Facebook Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Market Structure List Page by Title
  Given "secarticle" content:
    | title        | field_display_title           | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat Test 0 | Apple Green Energy Report     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat Test 1 | Google Green Energy Report    | Test 2 | -5 day   | 1      | Data                          | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat Test 2 | Facebook Green Energy Report  | Test 3 | -2 day   | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Behat Activity Data Series     |
    | Behat Test 3 | Netflix Green Energy Report   | Test 4 | +1 day   | 1      | Data                          | Credit Ratings                | Data-MarketStructure          | Jira Activity Data Series      |
    | Behat Test 4 | Microsoft Green Energy Report | Test 5 | -1 month | 1      | Data                          | General Counsel               | Data-MarketStructure          | HP ALM Activity Data Series    |
    | Behat Test 5 | Tesla Green Energy Report     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-MarketStructure          | Gitlab Activity Data Series    |
  When I am on "/marketstructure/data"
    And I click the sort filter "Title"
  Then "Apple Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Netflix Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Title"
    And "Netflix Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Market Structure List Page by Category
  Given "secarticle" content:
    | title        | field_display_title           | body   | changed  | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat Test 0 | Apple Green Energy Report     | Test 1 | now      | 1      | Data                          | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat Test 1 | Google Green Energy Report    | Test 2 | -5 day   | 1      | Data                          | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat Test 2 | Facebook Green Energy Report  | Test 3 | -2 day   | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Behat Activity Data Series     |
    | Behat Test 3 | Netflix Green Energy Report   | Test 4 | +1 day   | 1      | Data                          | Credit Ratings                | Data-MarketStructure          | Jira Activity Data Series      |
    | Behat Test 4 | Microsoft Green Energy Report | Test 5 | -1 month | 1      | Data                          | General Counsel               | Data-MarketStructure          | HP ALM Activity Data Series    |
    | Behat Test 5 | Tesla Green Energy Report     | Test 6 | -5 month | 1      | Data                          | Minority and Women Inclusion  | Data-MarketStructure          | Gitlab Activity Data Series    |
  When I am on "/marketstructure/data"
    And I click the sort filter "Category"
  Then "Facebook Green Energy Report" should precede "Tesla Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Microsoft Green Energy Report" should precede "Netflix Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Apple Green Energy Report" should precede "Google Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Category"
    And "Netflix Green Energy Report" should precede "Microsoft Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Tesla Green Energy Report" should precede "Facebook Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Google Green Energy Report" should precede "Apple Green Energy Report" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for market structure
  Given "tags" terms:
    | name       |
    | data       |
    And I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file  | field_description_abstract | status |
      | Behat Test File | static file          | behat-form1.pdf   | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                                        | field_article_sub_type_secart | field_description_abstract | field_contact_name | field_contact_email | field_display_title                                                          | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_tags | field_act              |
      | Verify PDF file having article type as Data and sub type as Market Structure | Market Structure              | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file having article type as Data and sub type as Market Structure | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Agency-Wide                   | 123-KO               | data       | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as Data and sub type as Market Structure" row
    And I wait 2 seconds
    And I select "Market Structure" from "Article SubType"
    And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
    And I wait for AJAX to finish
    And I publish it
  When I am on "/marketstructure/downloads.html"
    And I should see the link "Verify PDF file having article type as Data and sub type as Market Structure"
    And I click "Verify PDF file having article type as Data and sub type as Market Structure"
    And I wait 2 seconds
  Then I should be on "/files/behat-form1.pdf"
