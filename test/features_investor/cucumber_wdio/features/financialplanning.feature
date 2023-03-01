Feature: Financial Planning Tools on Investor Page
  As a site visitor, I should be able to navigate to the available financial planning calculator and estimator tools

    @goal_calculator @wdio
    Scenario: Full Screenshot of Saving Goal Calculator
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/compound-interest-calculator"
      And I remove "#twitter-widget-0"
    Then I take full page screenshot

    @saving_compound_interest @wdio
    Scenario: Full Screenshot of Saving Compound Interest
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/savings-goal-calculator"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

    @tablet_saving_compound_interest @wdio
    Scenario: Full Screenshot of Saving Compound Interest
    Given I set my screensize to tablet
    When I visit "/financial-tools-calculators/calculators/savings-goal-calculator"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

    @mobile_saving_compound_interest @wdio
    Scenario: Full Screenshot of Saving Compound Interest
    Given I set my screensize to mobile
    When I visit "/financial-tools-calculators/calculators/savings-goal-calculator"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

    @saving_distribution @wdio
    Scenario: Full Screenshot of Saving required minimum distribution
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/required-minimum-distribution-calculator"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot
