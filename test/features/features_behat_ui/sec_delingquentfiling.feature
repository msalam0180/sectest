Feature: Delinquent Filing List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Validating Delinquent List View Page
  Given "release" content:
    | title           | body         | field_release_type                | field_release_number         | field_respondents | moderation_state | field_publish_date | field_delinquent_filings |
    | ReleaseContent1 | detail body1 | Administrative Proceedings        | 34-12345, 34-54879, 34-88491 | Allen             | published        | 01-01-2021           | 1                        |
    | ReleaseContent2 | detail body2 | ALJ Initial Decisions             | 34-23456                     | Beverly           | published        | 15-01-2021         | 1                        |
    | ReleaseContent3 | detail body3 | ALJ Orders                        | 34-34567                     | Caroline          | published        | 03-03-2021         | 1                        |
    | ReleaseContent4 | detail body4 | Litigation Releases               | 34-45678                     | David             | published        | 01-01-2021         | 1                        |
    | ReleaseContent5 | detail body5 | Opinions and Adjudicatory Orders  | 34-56789                     | Edward            | published        | 15-01-2021         | 1                        |
    | ReleaseContent6 | detail body6 | Stop Orders                       | 34-67890                     | Franky            | published        | 03-03-2021         | 1                        |
    | ReleaseContent7 | detail body7 | Trading Suspensions               | 34-78901                     | Grover            | published        | 02-02-2020         | 1                        |
    | ReleaseContent8 | detail body8 | Trading Suspensions               | 34-78901                     | Hanry             | published        | 15-02-2020         | 1                        |
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Show Default Quick Links" from "field_quick_links"
    And I press "Save"
  Then I take a screenshot on "sec" using "delinquentfilings.feature" file with "@delinquent_list" tag
