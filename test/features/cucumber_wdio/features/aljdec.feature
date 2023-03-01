Feature: Styles on ALJ Initial Decisions
  As a site visitor, I want to be able to view ALJ Initial Decisions List and Node page
  So that visitors to sec.gov can learn about ALJ Initial Decisions

  @aljdeclist @wdio
  Scenario: ALJ Initial Decisions List Page
    Given I set my screensize to desktop
    When I visit "/alj/aljdec"
    Then I take screenshot of element "#main-wrapper"

  @aljdecnode @wdio
  Scenario: ALJ Initial Decisions Node Page
    Given I set my screensize to desktop
    When I visit "/alj/aljdec/test"
    Then I take screenshot of element "#content-wrapper"
