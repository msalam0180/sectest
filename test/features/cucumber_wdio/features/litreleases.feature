Feature: Styles on Litigation Releases Decisions
  As a site visitor, I want to be able to view Litigation Releases List and Node page
  So that visitors to sec.gov can learn about Litigation Releases

  @litreleaseslist @wdio
  Scenario: Litigation Releases List Page
    Given I set my screensize to desktop
    When I visit "/litigation/litreleases"
    Then I take screenshot of element "#main-wrapper"

  @litreleasesnode @wdio
  Scenario: Litigation Releases Node Page
    Given I set my screensize to desktop
    When I visit "/litigation/litreleases/test"
    Then I take screenshot of element "#content-wrapper"
