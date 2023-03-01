Feature: Styles on Orders Decisions
  As a site visitor, I want to be able to view Litigation Releases List and Node page
  So that visitors to sec.gov can learn about Litigation Releases

  @stoporderslist @wdio
  Scenario: Orders List Page
    Given I set my screensize to desktop
    When I visit "/litigation/stoporders"
    Then I take screenshot of element "#main-wrapper"

  @stopordersnode @wdio
  Scenario: Orders Node Page
    Given I set my screensize to desktop
    When I visit "/litigation/stoporders/test"
    Then I take screenshot of element "#content-wrapper"
