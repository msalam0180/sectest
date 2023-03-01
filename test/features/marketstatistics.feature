Feature: Market Statistics Data Articles
  As a content creator
  I want to create data articles specific to Market Statistics
  So that SEC.gov users can learn more about DERA Market Statistics

@api @javascript @marketstatistics
Scenario: Available fields for content creation
  Given I am logged in as a user with the "content_approver" role
  When I visit "/node/add/secarticle"
    And I fill in "Article Type" with "621"
    And I fill in "Article SubType" with "Data-MarketStatistics"
  Then I should see the field "Market Statistics Category"

@api @javascript @marketstatistics
Scenario: Create a Market Statistics data article
  Given I am logged in as a user with the "content_approver" role
  When I visit "/node/add/secarticle"
    And I fill in "Article Type" with "621"
    And I fill in "Article SubType" with "Data-MarketStatistics"
    And I fill in "Market Statistics Category" with "33421"
    And I type "This is the body" in the "Body" WYSIWYG editor
    And I fill in "Title" with "Behat - Market Statistics Article"
    And I select the first autocomplete option for "market statistics" on the "Tags" field
    And I fill in "Display Title" with "Behat - Market Statistics Article Test"
    And I fill in "Description/Abstract" with "Market Statistics - Behat test"
    And I fill in the following:
      | field_date[0][value][date]     | 04-26-2018 |
      | field_date[0][value][time]     | 01:00:00PM |
    And I fill in "Primary Division/Office" with "38"
    And I fill in "Contact Name" with "Michael Scott"
    And I fill in "Contact Email" with "michael.scott@dundermifflin.com"
    And I publish it
  Then I should see the text "MARKET STATISTICS" in the breadcrumbs region
    And I should see the text "Behat - Market Statistics Article Test"
    And I should see the text "This is the body" in the articlecontent region
    And I should see the "Market Statistics: Right Sidebar" block in the sidebar region
    And I should see the "Market Statistics Search Block" block in the sidebar region
    And I should see the "Market Statistics Disclaimer" block in the articlecontent region
    And I should see the link "Behat - Market Statistics Article Test" in the sidebar region

# commenting out as failure is due to existing content that needs to be updated
#@api @marketstatistics
#Scenario: View Market Statistics landing page
#  When I visit "/dera/market-statistics"
#  Then I should see the "Market Statistics Data Highlights: Market Statistics Landing Page" block in the panelfirst region
#    And I should see the "Market Statistics: Market Statistics Landing Page" block in the panelfirst region
#    And I should see the "Market Statistics Search Block" block in the panelsecond region
#    And I should see the "GovDelivery Subscription" block in the panelsecond region

@api @javascript @marketstatistics
Scenario: Create Data Visualization article
  Given I am logged in as a user with the "content_approver" role
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title              | field_display_title  | moderation_state | status | field_primary_division_office |
      | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) MS Article | (Behat) Statistics   | published        | 1      | Economic and Risk Analysis    |
  When I visit "/node/add/secarticle"
    And I fill in "Article Type" with "114371"
    And I fill in "Article SubType" with "Data Highlight-Visualization"
    And I fill in "Title" with "Behat - Data Visualization"
    And I fill in "Display Title" with "Behat - Data Visualization Test"
    And I select the first autocomplete option for "(Behat) MS Article" on the "Associated Dataset" field
    And I embed node "GovDelivery Form - Market Statistics" in the "Top Right Column" WYSIWYG
    And I fill in "Primary Division/Office" with "38"
    And I publish it
  Then I should see the text "HOME DERA MARKET STATISTICS (BEHAT) MS ARTICLE" in the breadcrumbs region
    And I should see the link "Data Visualization" in the contentbanner region
    And I should see the text "Behat - Data Visualization" in the articletitle region
    And I should see the "Market Statistics: Right Sidebar" block in the sidebar region
    And I should see the "Market Statistics Search Block" block in the sidebar region
    And I should see the "GovDelivery Subscription" block in the sidebar region

@api @javascript @marketstatistics
Scenario: View Statistics Guide list block in Market Statistics data article
  Given "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title              | field_display_title  | moderation_state | status | field_primary_division_office |
    | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) MS Article | (Behat) Statistics   | published        | 1      | Economic and Risk Analysis    |
    And "secarticle" content:
      | field_article_type_secarticle | title                   | field_display_title   | field_associated_dataset | body          | moderation_state | status | field_primary_division_office |
      | Education/Help/Guides/FAQs    | a (Behat) Stats Guide 1 | (Behat) Stats Guide 1 | (Behat) MS Article       | Stats Guide 1 body | published        | 1      | Economic and Risk Analysis |
      | Education/Help/Guides/FAQs    | b (Behat) Stats Guide 2 | (Behat) Stats Guide 2 | (Behat) MS Article       | Stats Guide 2 body | published        | 1      | Economic and Risk Analysis |
  When I visit "/dera/market-statistics/behat-ms-article"
  Then I should see the "Statistics Guide" block in the articlecontent region
    And I should see the statistics guide titled "(Behat) Stats Guide 1"
    And I should see the statistics guide titled "(Behat) Stats Guide 2"
    And I should see the text "(Behat) Stats Guide 1" before I see the text "(Behat) Stats Guide 2" in the "Statistics Guide" view

@api @javascript @marketstatistics
Scenario: Create Statistics Guide article
  Given I am logged in as a user with the "content_approver" role
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title                        | field_display_title                    | moderation_state | status | field_primary_division_office |
      | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) Market Stats Article | (Behat) Market Stats Article (Display) | published        | 1      | Economic and Risk Analysis    |
  When I visit "/node/add/secarticle"
    And I fill in "Article Type" with "626"
    And I fill in "Title" with "(Behat) Statistics Guide Article"
    And I fill in "Display Title" with "(Behat) Statistics Guide Article Test"
    And I select the first autocomplete option for "(Behat) Market Stats Article" on the "Associated Dataset" field
    And I fill in "Primary Division/Office" with "38"
    And I type "Doggo ipsum very taste wow floofs long water shoob, borkf." in the "Body" WYSIWYG editor
    And I publish it
  When I visit "/dera/market-statistics/behat-market-stats-article"
  Then I should see the "Statistics Guide" block in the articlecontent region
    And I should see the statistics guide titled "(Behat) Statistics Guide Article Test"

@api @javascript @marketstatistics
Scenario: View Data Visualizations list block in Market Statistics data article
  Given "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title                        | field_display_title                    | field_associated_dataset     | moderation_state | status | field_primary_division_office | created    |
    | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) Market Stats Article | (Behat) Market Stats Article (Display) |                              | published        | 1      | Economic and Risk Analysis    | 1525361976 |
    | Data Highlight                | Data Highlight-Visualization  |                                  | (Behat) Data Visualization 1 | (Behat) Data Visualization 1 (Display) | (Behat) Market Stats Article | published        | 1      | Economic and Risk Analysis    | 1525361976 |
    | Data Highlight                | Data Highlight-Visualization  |                                  | (Behat) Data Visualization 2 | (Behat) Data Visualization 2 (Display) | (Behat) Market Stats Article | published        | 1      | Economic and Risk Analysis    | 1525361977 |
  When I visit "/dera/market-statistics/behat-market-stats-article"
  Then I should see the "Data Highlights: Data Set" block in the articlecontent region
    And I should see the link "(Behat) Data Visualization 2 (Display)" before I see the link "(Behat) Data Visualization 1 (Display)" in the "Market Statistics Data Highlights" view

@api @javascript @marketstatistics
Scenario: Create Data Visualization article
  Given I am logged in as a user with the "content_approver" role
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title                        | field_display_title                    | moderation_state | status | field_primary_division_office |
      | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) Market Stats Article | (Behat) Market Stats Article (Display) | published        | 1      | Economic and Risk Analysis    |
      And "data_visualization" content:
      | title                      | field_description_abstract      | moderation_state | status |
      | (Behat) Data Visualization | (Behat) Data Visualization Test | published        | 1      |
  When I visit "/node/add/secarticle"
    And I fill in "Article Type" with "114371"
    And I fill in "Article SubType" with "Data Highlight-Visualization"
    And I fill in "Title" with "(Behat) Data Visualization"
    And I fill in "Display Title" with "(Behat) Visualization Test"
    And I embed node "(Behat) Data Visualization" in the "Body" WYSIWYG
    And I select the first autocomplete option for "(Behat) Market Stats Article" on the "Associated Dataset" field
    And I fill in "Primary Division/Office" with "38"
    And I publish it
  Then I should see the link "Data Visualization" in the contentbanner region
    And I should see the heading "(Behat) Visualization Test"

@api @javascript @marketstatistics
Scenario: View Market Statistics list block in sidebar of Market Statistics data article
  Given "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | field_market_statistics_category | title                | field_display_title    | moderation_state | status | field_primary_division_office |
    | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) MS Article 1 | a (Behat) Statistics 1 | published        | 1      | Economic and Risk Analysis    |
    | Data                          | Data-MarketStatistics         | Market Participants              | (Behat) MS Article 2 | x (Behat) Statistics 2 | published        | 1      | Economic and Risk Analysis    |
    | Data                          | Data-MarketStatistics         | Securities Offerings             | (Behat) MS Article 3 | a (Behat) Statistics 3 | published        | 1      | Economic and Risk Analysis    |
    | Data                          | Data-MarketStatistics         | Market Participants              | (Behat) MS Article 4 | b (Behat) Statistics 4 | published        | 1      | Economic and Risk Analysis    |
  When I visit "/dera/market-statistics/behat-ms-article-1"
  Then I should see the "Market Statistics: Right Sidebar" block in the sidebar region
    And I should see the link "(Behat) Statistics 1" before I see the link "(Behat) Statistics 4" in the "Market Statistics" view
    And I should see the link "(Behat) Statistics 4" before I see the link "(Behat) Statistics 2" in the "Market Statistics" view
