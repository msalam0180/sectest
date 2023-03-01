Feature: Investor Home Page
  As a Site Visitor, the user should be able to navigate to investor.gov home page and will be able to access Utility menu, Header

@ui @wdio
Scenario: Element Screenshots of Sections
  Given I am on "/"
  Then I take a screenshot on "investor" using "landingpage.feature" file with "@official_gov_banner" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@header" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@global_menu" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@global_navigation_hover_1" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@global_navigation_hover_2" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@global_navigation_hover_3" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@global_navigation_hover_4" tag
    And I take a screenshot on "investor" using "landingpage.feature" file with "@footer" tag
