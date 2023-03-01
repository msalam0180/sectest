Feature: SEC Events
  As a Site Visitor, the user should be able to navigate to view events on SEC.gov

  @add_calendar @wdio
  Scenario: Add Calendar to Event
    Given I set my screensize to desktop
    When I visit "/news/upcoming-events/community-based-fraud-during-covid-19"
    Then I take screenshot of element "#main-wrapper"
