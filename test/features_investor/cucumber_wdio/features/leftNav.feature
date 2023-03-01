Feature: Create Investor Article
  As a Content Creator, I want to be able to create articles so that visitors to investor.gov can learn about the investor

    @create_new_left_nav @wdio
    Scenario: Page Screenshot of Left Nav Element
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/investor-test"
      And I hide "#twitter-widget-0"
    Then I take current window screenshot and add text "Create_Left_Nav" to filename
