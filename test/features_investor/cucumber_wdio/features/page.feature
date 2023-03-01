Feature: Create Pages
  As a Content Creator, I want to be able to create basic page
  So that visitors to investor.gov can learn about the investor

  @create_page @wdio
  Scenario: Full Screen Creating Page
    Given I set my screensize to desktop
    When I visit "/node/1"
     And I hide "#twitter-widget-0"
    Then I take full page screenshot
