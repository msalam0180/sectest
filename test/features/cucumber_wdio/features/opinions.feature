Feature: Styles on Opinions and Adjudicatory
  As a site visitor, I want to be able to view Opinions and Adjudicatory List and Node page
  So that visitors to sec.gov can learn about Opinions and Adjudicatory

  @opinionslist @wdio
  Scenario: Opinions and Adjudicatory List Page
    Given I set my screensize to desktop
    When I visit "/litigation/opinions"
    Then I take screenshot of element "#main-wrapper"

  @opinionsnode @wdio
  Scenario: Opinions and Adjudicatory Node Page
    Given I set my screensize to desktop
    When I visit "/litigation/opinions/test"
    Then I take screenshot of element "#content-wrapper"
