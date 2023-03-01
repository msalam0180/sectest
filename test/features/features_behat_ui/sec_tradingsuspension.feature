Feature: Trading Suspension List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Trading Suspension Pages Screenshot
  Given "release" content:
    | title               | field_release_type  | field_release_number | field_respondents | moderation_state | field_publish_date  | status |
    | Trading Suspension1 | Trading Suspensions | 34-12345             | Allen             | published        | 2021-02-02 12:00:00 | 1      |
    | Trading Suspension2 | Trading Suspensions | 34-23456             | Beverly hidden    | draft            | -2 days             | 0      |
    | Trading Suspension3 | Trading Suspensions | 34-34567             | Caroline          | published        | 2021-05-03 12:00:00 | 1      |
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/litigation/suspensions/edit"
    And I wait 2 seconds
  Then I select "Show Default Quick Links" from "field_quick_links"
    And I press "Save"
  Then I take a screenshot on "sec" using "tradingsuspension.feature" file with "@tradingsuspensionlist" tag
  Then I take a screenshot on "sec" using "tradingsuspension.feature" file with "@tradingsuspensionnode " tag
