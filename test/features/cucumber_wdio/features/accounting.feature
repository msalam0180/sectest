Feature: Styles on Accounting and Auditing
  As a site visitor, I want to be able to view Accounting and Auditing List and Node page
  So that visitors to sec.gov can learn about Accounting and Auditing

  @accountinglist @wdio
  Scenario: Orders List Page
    Given I set my screensize to desktop
    When I visit "/divisions/enforce/friactions"
    Then I take screenshot of element "#main-wrapper"