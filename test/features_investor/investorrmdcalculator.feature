Feature: Required Minimum Distribution Calculator
  As a site visitor, I want to calculate to approximate required minimum distribution based on age and the value of my accounts.

@api @javascript @investor
Scenario Outline: RMD Calculations
  Given I am on "/additional-resources/free-financial-planning-tools/required-minimum-distribution-calculator"
  When I fill in "Previous Year-End Account Balance" with "<previousyear>"
    And I select "<age_at_year_end>" from "Age at Year-End"
    And I scroll to the bottom
    And I press the "Calculate" button
    And I wait for ajax to finish
    And I scroll to the bottom
    And I should see the text "Results"
    And I wait for ajax to finish
  Then I should see the text "<withdrawal_factor>"
    And I should see the text "<required_minimum_distribution>"

  Examples:
     | previousyear | age_at_year_end | withdrawal_factor | required_minimum_distribution |
     | 5000000      | 73              | 26.5              | $188,679.25                   |
     | 400000       | 83              | 17.7              | $22,598.87                    |
     | 350000       | 94              | 9.5               | $36,842.11                    |
     | 250000       | 105             | 4.6               | $54,347.83                    |
     | 105000       | 116             | 2.8               | $37,500.00                    |
     | 90000        | 120+            | 2                 | $45,000.00                    |

@api @javascript @investor
Scenario: RMD Calculation Required Fields and Reset
  Given I am on "/additional-resources/free-financial-planning-tools/required-minimum-distribution-calculator"
  When I press the "Calculate" button
    And I wait 2 seconds
    And I scroll "#rmd-calculator-form" into view
  Then I should see the text "2 errors have been found:"
    And I should see the text "Previous Year-End Account Balance field is required."
    And I should see the text "Age at Year-End field is required."
    And I should see an "#rmd-calc-wrapper > div:nth-child(1) > div" element
  When I press the "Reset" button
    And I scroll "#rmd-calculator-form" into view
    And I wait 2 seconds
  Then I should not see the text "2 errors have been found:"
    And I should not see the text "Previous Year-End Account Balance field is required."
    And I should not see the text "Age at Year-End field is required."
    And I should not see an "#rmd-calc-wrapper > div:nth-child(1) > div" element
  When I fill in "Previous Year-End Account Balance" with "14895"
    And I select "76" from "Age at Year-End"
    And I press the "Reset" button
  Then the "Previous Year-End Account Balance" field should not contain "$14,895"
    And the "Age at Year-End" field should not contain "76"
    But the "Age at Year-End" field should contain ""
  When I fill in "Previous Year-End Account Balance" with "14895"
    And I select "76" from "Age at Year-End"
    And I press the "Calculate" button
    And I scroll "#rmd-calculator-form" into view
  Then I should not see an "#rmd-calc-wrapper > div:nth-child(1) > div" element
    And I should not see the text "2 errors have been found:"

@api
Scenario: Verify Age at Year-End Drop Down List does not contain unwanted values
  When I am on "/financial-tools-calculators/calculators/required-minimum-distribution-calculator"
  Then the "select" element should not contain "72"
