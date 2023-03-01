Feature: Test IM Disclosure and Accounting Information Articles
  As a content creator
  I want to be able to create Disclosure and Accounting Information articles
  So that SEC.gov users can view them

  @api @imadi
  Scenario: View an ADI Article
    Given I am viewing an "secarticle" content:
      | field_article_type_secarticle | Accounting and Disclosure Information            |
      | field_article_sub_type_secart | Accounting and Disclosure Information-Accounting |
      | field_primary_division_office | Investment Management                            |
      | moderation_state              | published                                        |
      | title                         | Behat - Test ADI Article                         |
      | status                        | 1                                                |
      | body                          | This is the Test ADI body                        |
      | field_display_title           | Behat ADI Article                                |
    Then I should see the link "Accounting and Disclosure Information" in the contentbanner region
      And I should see the heading "Behat ADI Article"
      And I should see the text "This is the Test ADI body"

  @api @javascript @imadi
  Scenario: Default order of ADI list page
    Given "secarticle" content:
      | field_article_type_secarticle         | field_article_sub_type_secart                    | title         | field_display_title | moderation_state | status | field_primary_division_office | field_date          |
      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting | (Behat) ADI 1 | (Behat) DispT ADI 1 | published        | 1      | Investment Management         | 2019-04-23T13:00:03 |
      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting | (Behat) ADI 2 | (Behat) DispT ADI 2 | published        | 1      | Investment Management         | 2018-03-20T13:00:02 |
      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting | (Behat) ADI 3 | (Behat) DispT ADI 3 | published        | 1      | Investment Management         | 2018-12-23T13:00:01 |
    When I visit "/investment/accounting-and-disclosure-information"
    Then I should see the link "(Behat) DispT ADI 1" before I see the link "(Behat) DispT ADI 3" in the "Accounting and Disclosure Information" view
      And I should see the link "(Behat) DispT ADI 3" before I see the link "(Behat) DispT ADI 2" in the "Accounting and Disclosure Information" view
      And I should not see the link "(Behat) ADI 1"
      And I should not see the link "(Behat) ADI 2"
      And I should not see the link "(Behat) ADI 3"

  @api @javascript @imadi
  Scenario: View ADI article with link to Drupal node on list page
    Given I am logged in as a user with the "content_approver" role
    When I visit "/node/add/secarticle"
      And I fill in "Article Type" with "126246"
      And I fill in "Article SubType" with "Accounting and Disclosure Information-Accounting"
      And I fill in "Body" with "This is the body"
      And I fill in "Title" with "Behat - Expanded Use of Draft Registration Statement Review Procedures for Business Development Companies"
      And I fill in "Display Title" with "Expanded Use of Draft Registration Statement Review Procedures for Business Development Companies"
      And I fill in "Primary Division/Office" with "48"
      And I publish it
      And I am not logged in
      And I visit "/investment/accounting-and-disclosure-information"
    Then I should see the link "Expanded Use of Draft Registration Statement Review Procedures for Business Development Companies"

  @api @javascript @imadi
  Scenario: View ADI article with link to external resource on list page
    Given I am logged in as a user with the "content_approver" role
    When I visit "/node/add/secarticle"
      And I fill in "Article Type" with "126246"
      And I fill in "Article SubType" with "Accounting and Disclosure Information-Accounting"
      And I fill in "Title" with "Behat - Link to AWS content - External Resource"
      And I fill in "Display Title" with "Behat - Link to AWS content (display)"
      And I fill in "Primary Division/Office" with "48"
      And I fill in "URL" with "https://www.sec.gov/investment/im-guidance-2014-08.pdf" in the externalresource region
      And I fill in "Link text" with "Behat - Link to AWS content - External Resource" in the externalresource region
      And I publish it
      And I am not logged in
      And I visit "/investment/accounting-and-disclosure-information"
    Then I should see the link "Behat - Link to AWS content (display)"
      And I should not see the link "Behat - Link to AWS content - External Resource"

  @api @javascript @imadi
  Scenario: View ADI article with List Page Details link to external resource on list page
    Given I am logged in as a user with the "content_approver" role
    When I visit "/node/add/secarticle"
      And I fill in "Article Type" with "126246"
      And I fill in "Article SubType" with "Accounting and Disclosure Information-Accounting"
      And I fill in "Title" with "Behat - Link to AWS content - List Page Details"
      And I fill in "Display Title" with "Behat - Link to AWS content (display)"
      And I fill in "Primary Division/Office" with "48"
      And I type "Behat - Link to AWS content - List Page Details" in the "List Page Details" WYSIWYG editor
      And I press "Link" in the "List Page Details" WYSIWYG Toolbar
      And I select "https://" from "Protocol"
      And I fill in "URL*" with "www.sec.gov/investment/im-guidance-2014-08.pdf"
      And I click "OK"
      And I publish it
      And I am not logged in
      And I visit "/investment/accounting-and-disclosure-information"
    Then I should see the link "Behat - Link to AWS content (display)"
      And I should see the link "Behat - Link to AWS content - List Page Details"

  @api @javascript @imadi
  Scenario: Accounting And Disclosure Information View Page Shows Display Title In The List View
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/secarticle"
      And I select "Accounting and Disclosure Information" from "Article Type"
      And I select "Accounting" from "Article SubType"
      And I fill in "Title" with "OSSS-12336 title field with abstract field"
      And I fill in "Display Title" with "OSSS-12336 display title field should show in the list view"
      And I type "list page detail field should show if abstract field is not present" in the "List Page Details" WYSIWYG editor
      And I select "Investment Management" from "Primary Division/Office"
      And I publish it
      And I am not logged in
      And I am on "/investment/accounting-and-disclosure-information"
    Then I should see the link "OSSS-12336 display title field should show in the list view"
      And I should see the text "list page detail field should show if abstract field is not present"
    When I am logged in as a user with the "Content Approver" role
      And I am on "/admin/content/"
      And I click "Edit" in the "OSSS-12336 display title field should show in the list view" row
      And I fill in "Description/Abstract" with "abstract field should be visible if the list page detail is not filled or filled"
      And I publish it
      And I am not logged in
      And I am on "/investment/accounting-and-disclosure-information"
      And I reload the page
    Then I should see the link "OSSS-12336 display title field should show in the list view"
      And I should see the text "abstract field should be visible if the list page detail is not filled or filled"
      And I should see the text "Accounting" in the "OSSS-12336 display title field should show in the list view" row

  @api @javascript @imadi
  Scenario: Sort Accounting And Disclosure Information View Page By Category Title And Date
    Given "secarticle" content:
      | title               | field_display_title | field_description_abstract               | field_list_page_det_secarticle | field_publish_date  | status | field_article_type_secarticle         | field_article_sub_type_secart                                  | field_primary_division_office |
      | Behat Publication 0 | 1 Behat Test        | abstract field                           | The Sky is Gray                | 2020-01-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting               | Economic and Risk Analysis    |
      | Behat Publication 0 | 2 Behat Test        | abstract field                           | The Sky is Gray                | 2020-02-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Performance              | Economic and Risk Analysis    |
      | Behat Publication 0 | 3 Behat Test        | abstract field                           | The Sky is Gray                | 2020-03-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-PrincipalRisks           | Economic and Risk Analysis    |
      | Behat Publication 0 | 4 Behat Test        | abstract field                           | The Sky is Gray                | 2020-04-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-FilingProcedures         | Economic and Risk Analysis    |
      | Behat Publication 0 | 5 Behat Test        | abstract field                           | The Sky is Gray                | 2020-05-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-DistributionArrangements | Economic and Risk Analysis    |
      | Behat Publication 0 | 6 Behat Test        | abstract field                           | The Sky is Gray                | 2020-06-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting               | Economic and Risk Analysis    |
      | Behat Publication 0 | 7 Behat Test        | abstract field                           | The Sky is Gray                | 2020-07-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Performance              | Economic and Risk Analysis    |
      | Behat Publication 0 | 8 Behat Test        | abstract field with no list page details |                                | 2020-08-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-PrincipalRisks           | Economic and Risk Analysis    |
      | Behat Publication 0 | 9 Behat Test        | abstract field                           | The Sky is Gray                | 2020-09-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-FilingProcedures         | Economic and Risk Analysis    |
      | Behat Publication 0 | 10 Behat Test       |                                          | The Sky is Gray                | 2020-10-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-DistributionArrangements | Economic and Risk Analysis    |
    When I visit "/investment/accounting-and-disclosure-information"
    Then "Distribution Arrangements" should precede "Filing Procedures" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
      And "10 Behat Test" should precede "9 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "The Sky is Gray" should precede "abstract field" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/p"
      And "Oct. 17, 2020" should precede "Sept. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I click the sort filter "Title"
    Then "1 Behat Test" should precede "2 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "Accounting" should precede "Performance" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
    When I click the sort filter "Title"
    Then "10 Behat Test" should precede "9 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "Distribution Arrangements" should precede "Filing Procedures" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
    When I click the sort filter "Category"
    Then "Accounting" should precede "Distribution Arrangements" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
      And "Jan. 17, 2020" should precede "June 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I click the sort filter "Category"
    Then "Principal Risks" should precede "Performance" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
      And "March 17, 2020" should precede "Aug. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I click the sort filter "Last Updated"
    Then "Distribution Arrangements" should precede "Filing Procedures" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
      And "10 Behat Test" should precede "9 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "The Sky is Gray" should precede "abstract field" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/p"
      And "Oct. 17, 2020" should precede "Sept. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I click the sort filter "Last Updated"
    Then "Accounting" should precede "Performance" for the query "//td[contains(@class, 'views-field views-field-field-article-sub-type-secart is-active')]"
      And "1 Behat Test" should precede "2 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "Jan. 17, 2020" should precede "Feb. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"

  @api @javascript @imadi
  Scenario: Category Filter For Accounting And Disclosure Information View Page
    Given "secarticle" content:
      | title               | field_display_title | field_description_abstract               | field_list_page_det_secarticle | field_publish_date  | status | field_article_type_secarticle         | field_article_sub_type_secart                                  | field_primary_division_office |
      | Behat Publication 0 | 1 Behat Test        | abstract field                           | The Sky is Gray                | 2020-01-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting               | Economic and Risk Analysis    |
      | Behat Publication 0 | 2 Behat Test        | abstract field                           | The Sky is Gray                | 2020-02-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Performance              | Economic and Risk Analysis    |
      | Behat Publication 0 | 3 Behat Test        | abstract field                           | The Sky is Gray                | 2020-03-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-PrincipalRisks           | Economic and Risk Analysis    |
      | Behat Publication 0 | 4 Behat Test        | abstract field                           | The Sky is Gray                | 2020-04-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-FilingProcedures         | Economic and Risk Analysis    |
      | Behat Publication 0 | 5 Behat Test        | abstract field                           | The Sky is Gray                | 2020-05-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-DistributionArrangements | Economic and Risk Analysis    |
      | Behat Publication 0 | 6 Behat Test        | abstract field                           | The Sky is Gray                | 2020-06-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Accounting               | Economic and Risk Analysis    |
      | Behat Publication 0 | 7 Behat Test        | abstract field                           | The Sky is Gray                | 2020-07-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-Performance              | Economic and Risk Analysis    |
      | Behat Publication 0 | 8 Behat Test        | abstract field with no list page details |                                | 2020-08-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-PrincipalRisks           | Economic and Risk Analysis    |
      | Behat Publication 0 | 9 Behat Test        | abstract field                           | The Sky is Gray                | 2020-09-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-FilingProcedures         | Economic and Risk Analysis    |
      | Behat Publication 0 | 10 Behat Test       |                                          | The Sky is Gray                | 2020-10-17T17:00:00 | 1      | Accounting and Disclosure Information | Accounting and Disclosure Information-DistributionArrangements | Economic and Risk Analysis    |
    When I visit "/investment/accounting-and-disclosure-information"
      And I select "Accounting" from "category"
    Then "6 Behat Test" should precede "1 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "June 17, 2020" should precede "Jan. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I select "Distribution Arrangements" from "category"
    Then "10 Behat Test" should precede "5 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "The Sky is Gray" should precede "abstract field" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/p"
      And "Oct. 17, 2020" should precede "May 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I select "Performance" from "category"
    Then "7 Behat Test" should precede "2 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "July 17, 2020" should precede "Feb. 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I select "Principal Risks" from "category"
    Then "8 Behat Test" should precede "3 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "abstract field with no list page details" should precede "abstract field" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/p"
      And "Aug. 17, 2020" should precede "March 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
    When I select "Filing Procedures" from "category"
    Then "9 Behat Test" should precede "4 Behat Test" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]/a"
      And "Sept. 17, 2020" should precede "April 17, 2020" for the query "//td[contains(@class, 'views-field views-field-views-ifempty-1')]"
