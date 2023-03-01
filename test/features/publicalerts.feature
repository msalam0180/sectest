@pause @list
Feature: Public Alerts List Page
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Public Alerts List Page
  Given "secarticle" content:
    | title                     | field_display_title            | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test 0 | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test 1 | -3 month  | 0      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test 2 | +2 day    | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test 3 | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test 4 | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test 5 | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
  When I visit "/enforce/public-alerts"
  Then I should see the heading "Public Alert: Unregistered Soliciting Entities (PAUSE)"
  When I click "ui-id-2"
  Then I should see the heading "Fictitious Regulators"
  When I click "ui-id-3"
  Then I should see the heading "Impersonators of Genuine Firms"
  When I click "ui-id-1"
  Then I should see the heading "Unregistered Soliciting Entities"
  When I click on the element with css selector "div.button-box:nth-child(4) > a:nth-child(1) > span:nth-child(1)"
  Then I should be on "http://www.investor.gov/introduction-investing/getting-started/working-investment-professional/check-out-your-investment"
    And I visit "/enforce/public-alerts"
  When I click on the element with css selector "div.button-box:nth-child(5) > a:nth-child(1) > span:nth-child(1)"
  Then I should be on "https://www.investor.gov/protect-your-investments"
    And I visit "/enforce/public-alerts"
  When I click on the element with css selector "div.button-box:nth-child(6) > a:nth-child(1) > span:nth-child(1)"
  Then I should be on "https://www.investor.gov/sites/investorgov/files/2019-02/AskQuestions_brochure_508_9-20.pdf"
    And I visit "/enforce/public-alerts"
  When I click on the element with css selector "div.button-box:nth-child(7) > a:nth-child(1) > span:nth-child(1)"
  Then I should be on "https://www.investor.gov/protect-your-investments/fraud/types-fraud"
    And I visit "/enforce/public-alerts"
  When I click on the element with css selector "div.button-box:nth-child(8) > a:nth-child(1) > span:nth-child(1)"
  Then I should be on "https://www.investor.gov/protect-your-investments/fraud/how-avoid-fraud"
    And I visit "/enforce/public-alerts"
  #list view should display link to announcement with display title as text
    And I should see the link "123 Behat Public Alerts Test 0"
    And I should see "Fictitious Regulators" in the "123 Behat Public Alerts Test 0" row
    And I should see the link "123 Behat Public Alerts Test 2"
    And I should see "Unregistered Soliciting Entities" in the "123 Behat Public Alerts Test 2" row
    And I should see the link "123 Behat Public Alerts Test 3"
    And I should see "Fictitious Regulators" in the "123 Behat Public Alerts Test 3" row
    And I should see the link "123 Behat Public Alerts Test 4"
    And I should see "Impersonators of Genuine Firms" in the "123 Behat Public Alerts Test 4" row
    And I should see the link "123 Behat Public Alerts Test 5"
    And I should see "Unregistered Soliciting Entities" in the "123 Behat Public Alerts Test 5" row
  #list view should not display draft items
    And I should not see the link "123 Behat Public Alerts Test 1"

@api @javascript
Scenario: Default Sorting for Public Alerts List Page
  Given "secarticle" content:
    | title                     | field_display_title            | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test 0 | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test 1 | -3 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test 2 | +8 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test 3 | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test 4 | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test 5 | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
  When I visit "/enforce/public-alerts"
  Then "123 Behat Public Alerts Test 0" should precede "123 Behat Public Alerts Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 2" should precede "123 Behat Public Alerts Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 4" should precede "123 Behat Public Alerts Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Public Alerts List Page by Title
  Given "secarticle" content:
    | title                     | field_display_title            | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test 0 | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test 1 | -3 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test 2 | +8 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test 3 | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test 4 | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test 5 | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
  When I visit "/enforce/public-alerts"
  Then I click the sort filter "Name"
    And "123 Behat Public Alerts Test 5" should precede "123 Behat Public Alerts Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 3" should precede "123 Behat Public Alerts Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 1" should precede "123 Behat Public Alerts Test 0" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Name"
    And "123 Behat Public Alerts Test 0" should precede "123 Behat Public Alerts Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 2" should precede "123 Behat Public Alerts Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 4" should precede "123 Behat Public Alerts Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sort Public Alerts List Page by Category
  Given "secarticle" content:
    | title                     | field_display_title            | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test 0 | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test 1 | -3 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test 2 | +8 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test 3 | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test 4 | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test 5 | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
  When I visit "/enforce/public-alerts"
    And I click the sort filter "Category"
  Then "123 Behat Public Alerts Test 0" should precede "123 Behat Public Alerts Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 1" should precede "123 Behat Public Alerts Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 2" should precede "123 Behat Public Alerts Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Category"
  Then "123 Behat Public Alerts Test 2" should precede "123 Behat Public Alerts Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 1" should precede "123 Behat Public Alerts Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "123 Behat Public Alerts Test 0" should precede "123 Behat Public Alerts Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript @insulated
Scenario: Filter Public Alerts List Page by Category Selection
  Given "secarticle" content:
    | title                     | field_display_title            | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test 0 | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test 1 | -3 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test 2 | +8 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test 3 | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test 4 | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test 5 | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
  When I visit "/enforce/public-alerts"
    And I select "Fictitious Regulators" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
  Then I should see the link "123 Behat Public Alerts Test 0"
    And I should see the link "123 Behat Public Alerts Test 3"
    And I should not see the link "123 Behat Public Alerts Test 2"
  When I select "Impersonators of Genuine Firms" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
  Then I should see the link "123 Behat Public Alerts Test 1"
    And I should see the link "123 Behat Public Alerts Test 4"
    And I should not see the link "123 Behat Public Alerts Test 2"
  When I select "Unregistered Soliciting Entities" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
  Then I should see the link "123 Behat Public Alerts Test 2"
    And I should see the link "123 Behat Public Alerts Test 5"
    And I should not see the link "123 Behat Public Alerts Test 1"
  When I select "-View All-" from "edit-field-article-sub-type-secart-value"
    And I wait for AJAX to finish
  Then I should see the link "123 Behat Public Alerts Test 0"
    And I should see the link "123 Behat Public Alerts Test 1"
    And I should see the link "123 Behat Public Alerts Test 2"
    And I should see the link "123 Behat Public Alerts Test 3"
    And I should see the link "123 Behat Public Alerts Test 4"
    And I should see the link "123 Behat Public Alerts Test 5"

@api @javascript @insulated
Scenario: Filter Public Alerts List Page by Keyword
  Given "secarticle" content:
    | title                     | field_display_title                    | changed   | status | field_article_type_secarticle  | field_primary_division_office | field_article_sub_type_secart                |
    | 123 Bahat Public Alerts 0 | 123 Behat Public Alerts Test One       | +1 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 1 | 123 Behat Public Alerts Test Two       | -3 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 2 | 123 Behat Public Alerts Test Three     | +8 month  | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 3 | 123 Behat Public Alerts Test Four      | +11 month | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
    | 123 Bahat Public Alerts 4 | 123 Behat Public Alerts Test Five      | +90 day   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-ImpersonatorsofGenuineFirms    |
    | 123 Bahat Public Alerts 5 | 123 Behat Public Alerts Test Fifty-One | +2 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-UnregisteredSolicitingEntities |
    | 123 Bahat Public Alerts 6 | 123 Behat Public Alerts Test Fifty-Two | +1 year   | 1      | Public Alerts                  | Enforcement                   | Public Alerts-FictitiousRegulators           |
  When I visit "/enforce/public-alerts"
    And I fill in "listSearch" with "Fifty"
    And I wait for Ajax to finish
  Then I should see the text "123 Behat Public Alerts Test Fifty-One"
    And I should see the text "123 Behat Public Alerts Test Fifty-Two"
    And I should not see the text "123 Behat Public Alerts Test One"
    And I should not see the text "123 Behat Public Alerts Test Two"
    And I should not see the text "123 Behat Public Alerts Test Three"
    And I should not see the text "123 Behat Public Alerts Test Four"
    And I should not see the text "123 Behat Public Alerts Test Five"
  When I fill in "listSearch" with "One"
  Then the search results should show the link "123 Behat Public Alerts Test One"
    And the search results should show the link "123 Behat Public Alerts Test Fifty-One"
    And the search results should not show the link "123 Behat Public Alerts Test Two"
    And the search results should not show the link "123 Behat Public Alerts Test Three"
    And the search results should not show the link "123 Behat Public Alerts Test Four"
    And the search results should not show the link "123 Behat Public Alerts Test Five"
