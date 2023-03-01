Feature: Styles on ALJ Orders
  As a site visitor, I want to be able to view ALJ Orders List and Node page
  So that visitors to sec.gov can learn about ALJ Orders

  @aljorderslist @wdio
  Scenario: ALJ Orders List Page
    Given I set my screensize to desktop
    When I visit "/alj/aljorders"
    Then I take screenshot of element "#main-wrapper"

  @aljordersnode @wdio
  Scenario: ALJ Orders Node Page
    Given I set my screensize to desktop
    When I visit "/alj/aljorders/test"
    Then I take screenshot of element "#content-wrapper"
