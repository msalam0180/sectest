Feature: Calculators
  As a visitor to the Investor.gov site, I want to calculate to approximate the money can grow using the power of compound interest.

  @new_cicalculator @wdio
  Scenario: Full Screenshot of CI Calculator
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/compound-interest-calculator"
      And I type "150" in "#edit-principal"
      And I type "100" in "#edit-addition"
      And I type "10" in "#edit-num-years"
      And I type "1.5" in "#edit-interest-rate"
      And I type "1" in "#edit-interest-rate-variance"
      And I click on "#edit-compound-interest"
      And I click on "#edit-compound-interest > option:nth-child(3)"
      And I wait for "3" seconds
      And I click on "#edit-submit"
      And I wait for "10" seconds
      And I click on "#toggle_table"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "CI_Calculations" to filename

  @new_savingsgoalcalculator @wdio
  Scenario: Full Screenshot of Savings Goal Calculator
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/savings-goal-calculator"
      And I type "100000" in "#edit-end-amount"
      And I type "1000" in "#edit-principal"
      And I type "10" in "#edit-num-years"
      And I type "1.5" in "#edit-interest-rate"
      And I click on "#edit-compound-interest"
      And I click on "#edit-compound-interest > option:nth-child(3)"
      And I wait for "3" seconds
      And I click on "#edit-submit"
      And I wait for "10" seconds
      And I click on "#toggle_table"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "Savings_Goal_Calculations" to filename

  @new_rmdcalculator @wdio
  Scenario: Full Screenshot of RMD Calculator
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/required-minimum-distribution-calculator"
      And I type "100000" in "#edit-account-balance"
      And I click on "#edit-age"
      And I click on "#edit-age > option:nth-child(6)"
      And I wait for "3" seconds
      And I click on "#edit-submit"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "RMD_Calculations" to filename

  @cicalculator_edit_year @wdio
  Scenario: Full Screenshot of CI Calculator Year Edited
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/compound-interest-calculator"
      And I type "150" in "#edit-principal"
      And I type "100" in "#edit-addition"
      And I type "10" in "#edit-num-years"
      And I type "1.5" in "#edit-interest-rate"
      And I type "1" in "#edit-interest-rate-variance"
      And I click on "#edit-compound-interest"
      And I click on "#edit-compound-interest > option:nth-child(3)"
      And I wait for "3" seconds
      And I click on "#edit-submit"
      And I wait for "3" seconds
      And I type "5" in "#edit-num-years"
      And I click on "#edit-submit"
      And I wait for "3" seconds
      And I click on "#toggle_table"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "CI_Calculations_edit_year" to filename

  @savingsgoalcalculator_edit_year @wdio
  Scenario: Full Screenshot of Savings Goal Calculator Year Edited
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/savings-goal-calculator"
      And I type "100000" in "#edit-end-amount"
      And I type "1000" in "#edit-principal"
      And I type "10" in "#edit-num-years"
      And I type "1.5" in "#edit-interest-rate"
      And I click on "#edit-compound-interest"
      And I click on "#edit-compound-interest > option:nth-child(3)"
      And I wait for "3" seconds
      And I click on "#edit-submit"
      And I wait for "3" seconds
      And I type "5" in "#edit-num-years"
      And I click on "#edit-submit"
      And I wait for "3" seconds
      And I click on "#toggle_table"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "Savings_Goal_Calculations_edit_year" to filename

  @new_cigraph @wdio
  Scenario: Full Screenshot of CI Calculator Results graph
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/compound-interest-calculator"
      And I type "1000" in "#edit-principal"
      And I type "50" in "#edit-addition"
      And I type "10" in "#edit-num-years"
      And I type "101" in "#edit-interest-rate"
      And I type "0.5" in "#edit-interest-rate-variance"
      And I click on "#edit-submit"
      And I wait for "5" seconds
    #Correct the interest to fix validation error
    When I type "5" in "#edit-interest-rate"
      And I click on "#edit-submit"
      And I wait for "5" seconds
      And I scroll to "#calculator_results_chart"
      And I click on "#toggle_table"
      And I hide ".color-blue, .color-red, .color-gray, #twitter-widget-0, .block-title-iapd-widget-block,.site-footer, #at4-share, a.back-to-top"
    Then I take full page screenshot and add text "CI_graph" to filename
