Feature: Featured Info
  As a visitor to investor.gov, I should be able to view and edit Featured Information block on Homepage

  @featured_info @wdio
  Scenario: Full Screen Featured Info
    Given I set my screensize to desktop
    When I visit "/HelloWorld1"
      And I remove "#block-footeremailsignup, #twitter-widget-0"
    Then I take full page screenshot
