Feature: Article Content Type
  As a Content Creator
  I want to be able to create articles
  So that visitors to SEC.gov can learn about the secgov

  @api
  Scenario: Test the ability to View an Article
    Given I am viewing an "secarticle" content:
      | field_article_type_secarticle | Other             |
      | field_primary_division_office | Agency-wide       |
      | moderation_state              | published         |
      | title                         | This is the title |
      | status                        | 1                 |
      | body                          | This is the body  |
      | field_display_title           | My test article   |
    Then I should see the heading "My test article"
      And I should see the text "This is the body"

  @api
  Scenario: Test the ability to generate an Article URL
    Given I am viewing an "secarticle" content:
      | field_article_type_secarticle | Announcement        |
      | field_primary_division_office | Corporation Finance |
      | moderation_state              | published           |
      | title                         | This is the title   |
      | status                        | 1                   |
      | body                          | This is the body    |
      | field_display_title           | My test article     |
    When I visit "corpfin/announcement/title"
    Then I should see the heading "My test article"
      And I should see the text "This is the body"
      And I should see the link "Corporation Finance" in the navigation region
      And I should see the text "Announcement" in the contentbanner region

  @api
  Scenario: Create article through the UI
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/add/node"
      And I follow "Article"
      And I fill in "Article Type" with "651"
      And I fill in "Title" with "Behat Test Article"
      And I fill in "Display Title" with "Behat Display Title"
      And I select "Corporation Finance" from "Primary Division/Office"
      And I publish it
    Then I should see the heading "Behat Display Title"

  @api
  Scenario Outline: Mandatory fields populated when creating articles
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/secarticle"
      And I select "<article type>" from "Article Type"
      And I fill in "Title" with "<title>"
      And I fill in "Display Title" with "<display title>"
      And I select "<primary division/office>" from "Primary Division/Office"
      And I click the input with the value "Save and Create New Draft"
    Then I should not see "<results>"

    Examples:
      | article type       | title | display title | primary division/office | results        |
      | Other              | test  | display test  | Acquisitions            | Create Article |
      | - Select a value - | null  | null          | - Select a value -      | SEC Emblem     |
      | - Select a value - | test  | display test  | Acquisitions            | SEC Emblem     |
      | Other              | null  | display test  | Acquisitions            | SEC Emblem     |
      | Other              | test  | null          | Acquisitions            | SEC Emblem     |
      | Other              | test  | display test  | - Select a value -      | SEC Emblem     |

  @api
  Scenario Outline: Mandatory fields populated when creating articles 2
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/secarticle"
      And I select "<Type>" from "Article Type"
      And I fill in "Title" with "<Title>"
      And I fill in "Display Title" with "<DisplayTitle>"
      And I select "<Division>" from "Primary Division/Office"
      And I click the input with the value "Save and Create New Draft"
    Then I should see the text "<Results>"

    Examples:
      | Type               | Title | DisplayTitle | Division           | Results                                   |
      | - Select a value - | test  | display test | Acquisitions       | Article Type field is required            |
      | Other              |       | display test | Acquisitions       | Title field is required                   |
      | Other              | test  |              | Acquisitions       | Display Title field is required           |
      | Other              | test  | display test | - Select a value - | Primary Division/Office field is required |

  @api
  Scenario Outline: Mandatory fields populated when creating articles3
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/secarticle"
      And I select "<article type>" from "Article Type"
      And I fill in "Title" with "<title>"
      And I fill in "Display Title" with "<display title>"
      And I select "<primary division/office>" from "Primary Division/Office"
      And I click the input with the value "Save and Create New Draft"
    Then I should not see "<results>"

    Examples:
      | article type | title | display title | primary division/office | results    |
      | Other        |       | display test  | Acquisitions            | SEC Emblem |

  @api
  Scenario Outline: Article Left Navigation
    Given I am viewing an "secarticle" content:
      | title                         | Test              |
      | body                          | This is the body. |
      | field_article_type_secarticle | <Type>            |
      | field_article_sub_type_secart | <SubType>         |
      | field_left_nav_override       |                   |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_display_title           | My test article   |
      | field_primary_division_office | Enforcement       |
    Then I should see the text "<Text>" in the "navigation" region

    Examples:
      | Type                          | SubType                                                 | Text                           |
      | Academic Publications         |                                                         | Enforcement                    |
      | Agendas                       |                                                         | Newsroom                       |
      | Announcement                  |                                                         | Enforcement                    |
      | Award Claim                   |                                                         | Enforcement                    |
      | Biographies                   |                                                         | Enforcement                    |
      | Contact Information           |                                                         | Enforcement                    |
      | Data                          |                                                         | About the SEC                  |
      | Data                          | Data-BrokerDealers                                      | About the SEC                  |
      | Data                          | Data-Enforcement                                        | About the SEC                  |
      | Data                          | Data-FundsandAdvisers                                   | About the SEC                  |
      # The type below does not exist - it may have been deleted
      | Data                          | Data-InvestmentCompanies                                | About the SEC                  |
      | Data                          | Data-InvestorComplaints                                 | About the SEC                  |
      | Data                          | Data-MarketStructure                                    | Market Structure               |
      | Data                          | Data-Other                                              | About the SEC                  |
      | Data                          | Data-PublicCompanies                                    | About the SEC                  |
      | Data Highlight                |                                                         | Enforcement                    |
      | Education/Help/Guides/FAQs    |                                                         | Enforcement                    |
      | Fact Sheets                   |                                                         | Newsroom                       |
      | Fast Answers                  |                                                         | Investor Information           |
      | Forms                         |                                                         | EDGAR - Information for Filers |
      | Investor Alerts and Bulletins |                                                         | Investor Information           |
      | Laws                          |                                                         | About the SEC                  |
      | Other                         |                                                         | Enforcement                    |
      | Reports and Publications      |                                                         | About the SEC                  |
      | Reports and Publications      | Reports and Publications-AnnualReports                  | About the SEC                  |
      | Reports and Publications      | Reports and Publications-BudgetReports                  | About the SEC                  |
      | Reports and Publications      | Reports and Publications-BuyAmericanAct                 | About the SEC                  |
      | Reports and Publications      | Reports and Publications-ConferenceSpending             | About the SEC                  |
      | Reports and Publications      | Reports and Publications-FAIRAct                        | About the SEC                  |
      | Reports and Publications      | Reports and Publications-FederalEmployeeViewpointSurvey | About the SEC                  |
      | Reports and Publications      | Reports and Publications-InternalSupervisoryControls    | About the SEC                  |
      | Reports and Publications      | Reports and Publications-InvestorPublications           | Investor Information           |
      | Reports and Publications      | Reports and Publications-Other                          | Enforcement                    |
      | Reports and Publications      | Reports and Publications-SelectSECandMarketData         | About the SEC                  |
      | Reports and Publications      | Reports and Publications-ServiceContractInventory       | About the SEC                  |
      | Reports and Publications      | Reports and Publications-SpecialStudies                 | About the SEC                  |
      | Reports and Publications      | Reports and Publications-StrategicPlan                  | About the SEC                  |
      | Staff Papers                  |                                                         | Enforcement                    |
      | Sunshine Act Notices          |                                                         | Enforcement                    |

  @api
  Scenario: Article Left Nav Override
    Given I am viewing an "secarticle" content:
      | field_article_type_secarticle | Other             |
      | field_primary_division_office | Agency-wide       |
      | moderation_state              | published         |
      | title                         | This is the title |
      | status                        | 1                 |
      | body                          | This is the body  |
      | field_display_title           | My test article   |
      | field_left_nav_override       | Corpfin           |
    Then I should see the heading "My test article"
      And I should see the text "This is the body"
      And I should see the text "Corporation Finance" in the "navigation" region

  @api
  Scenario Outline: Article URLs
    Given "division_office" terms:
      | name              | field_abbreviated |
      | BEHAT             | bht               |
      | Office of Justice | ooj               |
      And "secarticle" content:
      | title             | body       | field_article_type_secarticle | field_article_sub_type_secart | field_primary_division_office | status |
      | BEHAT URL pattern | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      |
    When I visit "<URL>"
    Then the response status code should be 200

    Examples:
      | Division          | Type                          | SubType                                                 | URL                                                                               |
      | BEHAT             | Academic Publications         |                                                         | /bht/academic-publications/behat-url-pattern                                      |
      | Office of Justice | Agendas                       |                                                         | /agendas/behat-url-pattern                                                        |
      | Office of Justice | Announcement                  |                                                         | /ooj/announcement/behat-url-pattern                                               |
      | BEHAT             | Contact Information           |                                                         | /bht/contact-information/behat-url-pattern                                        |
      | Office of Justice | Data                          | Data-BrokerDealers                                      | /ooj/data/broker-dealers/behat-url-pattern                                        |
      | Office of Justice | Data                          | Data-Enforcement                                        | /ooj/data/enforcement/behat-url-pattern                                           |
      | Office of Justice | Data                          | Data-FundsandAdvisers                                   | /ooj/data/funds-and-advisers/behat-url-pattern                                    |
      | Office of Justice | Data                          | Data-InvestmentCompanies                                | /ooj/data/investment-companies/behat-url-pattern                                  |
      | Office of Justice | Data                          | Data-InvestorComplaints                                 | /ooj/data/investor-complaints/behat-url-pattern                                   |
      | Office of Justice | Data                          | Data-MarketStructure                                    | /ooj/data/market-structure/behat-url-pattern                                      |
      | Office of Justice | Data                          | Data-Other                                              | /ooj/data/behat-url-pattern                                                       |
      | Office of Justice | Data                          | Data-PublicCompanies                                    | /ooj/data/public-companies/behat-url-pattern                                      |
      | Office of Justice | Education/Help/Guides/FAQs    |                                                         | /ooj/educationhelpguidesfaqs/behat-url-pattern                                    |
      | Office of Justice | Fact Sheets                   |                                                         | /ooj/fact-sheets/behat-url-pattern                                                |
      | Office of Justice | Fast Answers                  |                                                         | /answers/behat-url-pattern                                                        |
      | Office of Justice | Forms                         |                                                         | /about/forms/behat-url-pattern                                                    |
      | Office of Justice | Investor Alerts and Bulletins |                                                         | /ooj/investor-alerts-and-bulletins/behat-url-pattern                              |
      | Office of Justice | Laws                          |                                                         | /ooj/laws/behat-url-pattern                                                       |
      | Behat             | Other                         |                                                         | /bht/behat-url-pattern                                                            |
      | Office of Justice | Reports and Publications      | Reports and Publications-AnnualReports                  | /ooj/reports-and-publications/annual-reports/behat-url-pattern                    |
      | Office of Justice | Reports and Publications      | Reports and Publications-BudgetReports                  | /ooj/reports-and-publications/budget-reports/behat-url-pattern                    |
      | Office of Justice | Reports and Publications      | Reports and Publications-BuyAmericanAct                 | /ooj/reports-and-publications/buy-american-act/behat-url-pattern                  |
      | Office of Justice | Reports and Publications      | Reports and Publications-ConferenceSpending             | /ooj/reports-and-publications/conference-spending/behat-url-pattern               |
      | Office of Justice | Reports and Publications      | Reports and Publications-FAIRAct                        | /ooj/reports-and-publications/fair-act/behat-url-pattern                          |
      | Office of Justice | Reports and Publications      | Reports and Publications-FederalEmployeeViewpointSurvey | /ooj/reports-and-publications/federal-employee-viewpoint-survey/behat-url-pattern |
      | Office of Justice | Reports and Publications      | Reports and Publications-InternalSupervisoryControls    | /ooj/reports-and-publications/internal-supervisory-controls/behat-url-pattern     |
      | Office of Justice | Reports and Publications      | Reports and Publications-InvestorPublications           | /ooj/reports-and-publications/investor-publications/behat-url-pattern             |
      | Office of Justice | Reports and Publications      | Reports and Publications-Other                          | /ooj/reports-and-publications/behat-url-pattern                                   |
      | Office of Justice | Reports and Publications      | Reports and Publications-SelectSECandMarketData         | /ooj/reports-and-publications/select-sec-and-market-data/behat-url-pattern        |
      | Office of Justice | Reports and Publications      | Reports and Publications-ServiceContractInventory       | /ooj/reports-and-publications/service-contract-inventory/behat-url-pattern        |
      | Office of Justice | Reports and Publications      | Reports and Publications-SpecialStudies                 | /ooj/reports-and-publications/special-studies/behat-url-pattern                   |
      | Office of Justice | Reports and Publications      | Reports and Publications-StrategicPlan                  | /ooj/reports-and-publications/strategic-plan/behat-url-pattern                    |

  #Version Management Scripts
  @api
  Scenario: Revision tab is created for content nodes
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Data                          | Data-MarketStructure          | published        | This is the BEHAT title   | This is the BEHAT display title   | 1      | This is the body     | Corporation Finance           |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Agency-Wide                   |
      And I am logged in as a user with the "Content Approver" role
    When I am on "/admin/content/search"
      And I select "Data" from "Article Type"
      And I select "Market Structure" from "Article SubType"
      And I press "Filter"
      And I click "Edit" in the "This is the BEHAT title" row
    Then I should see "Revisions"

  @api @javascript
  Scenario: Review tab when the content has been edited
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Data                          | Data-MarketStructure          | published        | This is the BEHAT title   | This is the BEHAT display title   | 1      | This is the body     | Corporation Finance           |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Agency-Wide                   |
      And I am logged in as a user with the "Content Approver" role
    When I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is the NOT the title" row
      And I fill in "This is Edited title" for "Title"
      And I publish it
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title" row
    Then I should see the link "Revisions"

  @api @javascript
  Scenario: Reverting to the previous version
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Agency-Wide                   |
      And I am logged in as a user with the "Content Approver" role
    When I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is the NOT the title" row
      And I fill in "This is Edited title" for "Title"
      And I publish it
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title" row
      And I click "Revisions"
      And I click "Revert" in the "Anonymous" row
      And I press "Revert"
    Then I should see the text "Article This is the NOT the title has been reverted to the revision from"
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I should see the link "This is the NOT the title"
      And I should not see the link "This is Edited title"

  @api @javascript
  Scenario: Multiple edits - Reverting to the previous version
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Agency-Wide                   |
      And I am logged in as a user with the "Content Approver" role
    #First Revision
    When I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is the NOT the title" row
      And I fill in "This is Edited title001" for "Title"
      And I publish it
      #Second Revision
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title001" row
      And I fill in "This is Edited title002" for "Title"
      And I publish it
      #Third Revision
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title002" row
      And I fill in "This is Edited title003" for "Title"
      And I publish it
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title003" row
      And I click "Revisions"
      And I click "Revert"
      And I press "Revert"
    Then I should see the text "has been reverted to the revision from"
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I should see the link "This is Edited title002"
      And I should not see the link "This is Edited title003"
      And I should not see the link "This is Edited title001"
      And I should not see the link "This is the NOT the title"

  @api @javascript
  Scenario: Reverting to the first version - multiple versions
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Agency-Wide                   |
      And I am logged in as a user with the "Content Approver" role
    #First Revision
    When I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is the NOT the title" row
      And I fill in "This is Edited title001" for "Title"
      And I publish it
      #Second Revision
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title001" row
      And I fill in "This is Edited title002" for "Title"
      And I publish it
      #Third Revision
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title002" row
      And I fill in "This is Edited title003" for "Title"
      And I publish it
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "This is Edited title003" row
      And I click "Revisions"
      And I click "Revert" in the "Anonymous" row
      And I press "Revert"
    Then I should see the text "has been reverted to the revision from"
      And I am on "/admin/content/search"
      And I select "Other" from "Article Type"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait for ajax to finish
      And I should not see the link "This is Edited title002"
      And I should not see the link "This is Edited title003"
      And I should not see the link "This is Edited title001"
      And I should see the link "This is the NOT the title"
  #In case of 3 or more versions, I am only able to revert to the first or the second-to-last version of the content. I am unable to revert to any specific version between those.Scripts need to be added for that.

  @api
  Scenario Outline: Validate Article Displaying Publish Date
    Given I am viewing an "secarticle" content:
      | title                         | Test              |
      | body                          | This is the body. |
      | field_article_type_secarticle | <Type>            |
      | field_article_sub_type_secart | <SubType>         |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_display_title           | My test article   |
      | field_primary_division_office | Agency-Wide       |
      | field_publish_date            | <date>            |
    Then I should see the text "My test article"
      And I should see the text "<apdate>"

    Examples:
      | Type                          | SubType                                                 | date                | apdate         |
      | Data                          |                                                         | 2020-01-01 12:00:00 | January 2020   |
      | Data                          | Data-BrokerDealers                                      | 2020-02-01 12:00:00 | February 2020  |
      | Data                          | Data-Enforcement                                        | 2020-03-01 12:00:00 | March 2020     |
      | Data                          | Data-FundsandAdvisers                                   | 2020-04-01 12:00:00 | April 2020     |
      | Data                          | Data-InvestmentCompanies                                | 2020-05-01 12:00:00 | May 2020       |
      | Data                          | Data-InvestorComplaints                                 | 2020-06-01 12:00:00 | June 2020      |
      | Data                          | Data-MarketStructure                                    | 2020-07-01 12:00:00 | July 2020      |
      | Data                          | Data-Other                                              | 2020-08-01 12:00:00 | August 2020    |
      | Data                          | Data-PublicCompanies                                    | 2020-09-01 12:00:00 | September 2020 |
      | Reports and Publications      |                                                         | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Reports and Publications      | Reports and Publications-AnnualReports                  | 2020-02-01 12:00:00 | Feb. 1, 2020   |
      | Reports and Publications      | Reports and Publications-BudgetReports                  | 2020-03-01 12:00:00 | March 1, 2020  |
      | Reports and Publications      | Reports and Publications-BuyAmericanAct                 | 2020-04-01 12:00:00 | April 1, 2020  |
      | Reports and Publications      | Reports and Publications-ConferenceSpending             | 2020-05-01 12:00:00 | May 1, 2020    |
      | Reports and Publications      | Reports and Publications-FAIRAct                        | 2020-06-01 12:00:00 | June 1, 2020   |
      | Reports and Publications      | Reports and Publications-FederalEmployeeViewpointSurvey | 2020-07-01 12:00:00 | July 1, 2020   |
      | Reports and Publications      | Reports and Publications-InternalSupervisoryControls    | 2020-08-01 12:00:00 | Aug. 1, 2020   |
      | Reports and Publications      | Reports and Publications-InvestorPublications           | 2020-09-01 12:00:00 | Sept. 1, 2020  |
      | Reports and Publications      | Reports and Publications-Other                          | 2020-10-01 12:00:00 | Oct. 1, 2020   |
      | Reports and Publications      | Reports and Publications-SelectSECandMarketData         | 2020-11-01 12:00:00 | Nov. 1, 2020   |
      | Reports and Publications      | Reports and Publications-ServiceContractInventory       | 2020-12-01 12:00:00 | Dec. 1, 2020   |
      | Reports and Publications      | Reports and Publications-SpecialStudies                 | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Reports and Publications      | Reports and Publications-StrategicPlan                  | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  |                                                         | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  | Staff Papers-Economic-Analyses                          | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  | Staff Papers-Economics-Notes                            | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  | Staff Papers-Other                                      | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  | Staff Papers-WhitePaper                                 | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Staff Papers                  | Staff Papers-WorkingPapers                              | 2020-01-01 12:00:00 | Jan. 1, 2020   |
      | Investor Alerts and Bulletins |                                                         | 2020-01-01 12:00:00 | Jan. 1, 2020   |

  @api @javascript
  Scenario Outline: Validate Article without Displaying Publish Date
    Given I am viewing an "secarticle" content:
      | title                         | Test              |
      | body                          | This is the body. |
      | field_article_type_secarticle | <Type>            |
      | field_article_sub_type_secart | <SubType>         |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_display_title           | My test article   |
      | field_primary_division_office | Agency-Wide       |
      | field_publish_date            | <date>            |
    Then I should not see the text "<apdate>"

    Examples:
      | Type                       | SubType | date                | apdate       |
      | Academic Publications      |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Agendas                    |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Announcement               |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Award Claim                |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Biographies                |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Contact Information        |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Data Highlight             |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Education/Help/Guides/FAQs |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Fact Sheets                |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Fast Answers               |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Forms                      |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Laws                       |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Other                      |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |
      | Sunshine Act Notices       |         | 2020-01-01 12:00:00 | Jan. 1, 2020 |

  @api @javascript
  Scenario: Modify Article
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/secarticle"
      And I select "Forms" from "Article Type"
      And I fill in "Title" with "Title OSSS 11868"
      And I fill in "Display Title" with "Display Title OSSS 11868"
      And I select "Agency-Wide" from "Primary Division/Office"
      And I publish it
    Then I should see the link "Forms"
      And I should see the heading "Display Title OSSS 11868"
    When I am on "/admin/content/search"
      And I click "Edit" in the "Title OSSS 11868" row
      And I fill in the following:
      | field_publish_date[0][value][date] | 01-01-2020 |
      | field_publish_date[0][value][time] | 13:00:00PM |
      | field_date[0][value][date]         | 07-31-2019 |
      | field_date[0][value][time]         | 13:00:00PM |
      And I fill in "Release Number" with "12345"
      And I publish it
    Then I should see the heading "Display Title OSSS 11868"
      And I should see the text "12345"
      And I should see the text "July 31, 2019"
    But I should not see the text "This page is temporarily unavailable"

  @api @javascript
  Scenario: Article Selection Of No Menu Option
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/admin/structure/menu"
    Then I should not see the text "No Menu"
      And I scroll to the bottom
    When I click "Next"
    Then I should not see the text "No Menu"
    When I am logged in as a user with the "Content Approver" role
      And I visit "/node/add/secarticle"
      And I select "Other" from "Article Type"
      And I fill in "Title" with "Testing Ticket 13643"
      And I fill in "Display Title" with "No Menu Option has been added"
      And I select "Enforcement" from "Primary Division/Office"
      And I select "Enforcement" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"
      And I wait 1 seconds
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "No Menu" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should not see the text "Enforcement Manual"
      And I should not see the text "Public Alerts"
      And I should not see the text "Federal Court Actions"
      And I wait 1 seconds
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "Enforcement" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"

  @api
  Scenario: Verify Duplicate Article Content is Not Showing in the Content Dashboard When Multiple Speakers is selected
    Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title             | field_display_title             | status | body             | field_primary_division_office |
      | Announcement                  | Data-MarketStructure          | published        | Behat for Article | This is the BEHAT display title | 1      | This is the body | Corporation Finance           |
      And "secperson" content:
        | title      | field_first_name_secperson | field_last_name_secperson | body                         | field_enable_biography_page | status |
        | John Behat | John                       | Behat                     | John started working in 2017 | 0                           | 1      |
        | Jane Behat | Jane                       | Behat                     | Jane started working in 2018 | 0                           | 1      |
    When I am logged in as a user with the "Content Approver" role
      And I am on "/admin/content/search"
      And I fill in "Behat for Article" for "Title"
      And I press "Filter"
    Then I should see the text "Displaying 1 - 1 of 1"
      And I click "Edit" in the "Behat for Article" row
      And I select "John Behat" from "Speaker"
      And I additionally select "Jane Behat" from "Speaker"
      And I publish it
    When I am on "/admin/content/search"
      And I fill in "Behat for Article" for "Title"
      And I press "Filter"
    Then I should see the text "Displaying 1 - 1 of 1"

  @api @javascript
  Scenario: Validate Paper Block When Linking Article Using Speaker
    Given "secperson" content:
      | title       | field_first_name_secperson | field_last_name_secperson | status |
      | BEHATPerson | Person                     | Name                      | 1      |
      And I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
      And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | field_person | field_article_sub_type_secart | moderation_state | title             | field_display_title             | status | body             | field_primary_division_office |
      | Staff Papers                  | Behat File              | BEHATPerson  | Data-MarketStructure          | published        | Behat for Article | This is the BEHAT display title | 1      | This is the body | Corporation Finance           |
      | Staff Papers                  | Behat File              | BEHATPerson  | Data-MarketStructure          | published        | Behat for Article | This is the BEHAT display title | 1      |                  | Corporation Finance           |
    When I am logged in as a user with the "Content Approver" role
      And I am on "/biography/behatperson"
    Then I should see "Paper"
      And I should see "This is the BEHAT display title (PDF)"
      And I should see "This is the BEHAT display title"

  @api @javascript
  Scenario: Confirm Amicus Page View
    Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
      And "secarticle" content:
        | field_article_type_secarticle | field_media_file_upload | moderation_state | title              | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
        | Amicus Brief                  | Behat File              | published        | Behat for Article1 | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      |                     |
        | Amicus Brief                  |                         | published        | Behat for Article2 | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details2     | 2019-07-25T17:00:00 |
        | Amicus Brief                  |                         |                  | Behat for Article3 | No Show             | 0      | Normal 1text     | Enforcement                   | 2018-11-15T17:00:00 | This is list page detail3s     |                     |
    When I am on "/litigation/amicusbriefs"
    Then I should see the heading "Commission Amicus / Friend of the Court Briefs"
      And I should see the text "This page provides links to some of the legal briefs the Commission's staff submitted in various court actions. See also:"
      And I should see the link "Enforcement" in the navigation region
      And I should see the link "Commission Appellate Court Briefs"
      And I should see the link "Request for Commission Amicus Participation in a Pending Case"
      And "May 2020" should precede "July 2019" for the query "//td[contains(@class, 'views-field-field-publish-date')]"
      And I should see "BEHAT Link Title (PDF)" in the "May 2020" row
      And I should not see "This is the body" in the "May 2020" row
      And I should see "This is list page details" in the "May 2020" row
      And I should see "Basic Article Title" in the "July 2019" row
      And I should not see "Normal text" in the "July 2019" row
      And I should see "This is list page details2" in the "July 2019" row
      And I should not see the text "No Show"
      And I should see the text "1 to 2 of 2 items"
    When I click "BEHAT Link Title (PDF)"
    Then I should be on "/files/behat-file_corpfin.pdf"
    When I move backward one page
      And I click "Basic Article Title"
    Then I should see the heading "Basic Article Title"
      And I should see the text "Normal text"
      And I should see the text "July 25, 2019" in the "node_page_modified_date" region
