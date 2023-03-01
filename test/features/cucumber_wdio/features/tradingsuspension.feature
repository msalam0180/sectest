Feature: Styles on Trading Suspension
  As a site visitor, I want to be able to view Trading Suspension List and Node page
  So that visitors to sec.gov can learn about trading suspension

  @tradingsuspensionlist @wdio
  Scenario: Trading Suspension List Page
    Given I set my screensize to desktop
    When I visit "/litigation/suspensions"
    Then I take screenshot of element "#main-wrapper"

  @tradingsuspensionnode @wdio
  Scenario: Trading Suspension Node Page
    Given I set my screensize to desktop
    When I visit "/litigation/suspensions/trading-suspension1"
    Then I take screenshot of element "#content-wrapper"
