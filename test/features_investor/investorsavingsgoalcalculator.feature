Feature: Savings Goal Calculator
  As a site visitor, I want to calculate to approximate my saving goal based on age and the value of my accounts.

@api @javascript @investor
Scenario Outline: Savings Goal Calculations
  Given I am on "/additional-resources/free-financial-planning-tools/savings-goal-calculator"
  When I fill in "Savings Goal" with "<savingsgoal>"
    And I fill in "Initial Investment" with "<initialinvestment>"
    And I fill in "num_years" with "<yearstogrow>"
    And I fill in "Interest Rate" with "<interestrate>"
    And I select "<compoundfrequency>" from "Compound Frequency"
    And I press the "Calculate" button
    And I wait for AJAX to finish
    And I scroll to the bottom
  Then I should see the text "The Results Are In"
    And I should see the text "If you contribute <result> every month over the next <yearstogrow> years towards your goal, you will have <savingsgoal> in savings."
    And I should see the text "Total Savings"
  When I press the "Show Table" button
  Then I should see the text "<initialinvestment>" in the "Year 0" row
    And I should see the text "<savingsgoal>" in the "Year 10" row
    And I should see the text "Hide Table"

  Examples:
    | savingsgoal | initialinvestment | yearstogrow | interestrate | compoundfrequency | result  |
    | $50,000.00  | 500               | 10          | 2            | Annually          | $375.89 |
    | $50,000.00  | 500               | 10          | 2            | Semiannually      | $373.84 |
    | $50,000.00  | 500               | 10          | 2            | Monthly           | $372.13 |
    | $50,000.00  | 500               | 10          | 2            | Daily             | $371.80 |

@api @javascript @investor
Scenario: Savings Goal Calculations Required Fields and Reset
  Given I am on "/additional-resources/free-financial-planning-tools/savings-goal-calculator"
  When I press the "Calculate" button
    And I scroll "#savings-calculator-form" into view
    And I wait 2 seconds
    And I scroll "#savings-calc-wrapper" into view
  Then I should see the text "4 errors have been found:"
    And I should see an "#savings-calc-wrapper > div:nth-child(1) > div" element
    And I should see the text "Savings Goal field is required."
    And I should see the text "Initial Investment field is required."
    And I should see the text "Years to Grow field is required."
    And I should see the text "Estimated Interest Rate field is required."
  When I press the "Reset" button
    And I scroll "#savings-calc-wrapper" into view
  Then I should not see the text "4 errors have been found:"
    And I should not see an "#savings-calc-wrapper > div:nth-child(1) > div" element
    And I should not see the text "Savings Goal field is required."
    And I should not see the text "Initial Investment field is required."
    And I should not see the text "Years to Grow field is required."
    And I should not see the text "Estimated Interest Rate field is required."
  When I fill in "Savings Goal" with "98765"
    And I fill in "Initial Investment" with "1234"
    And I fill in "num_years" with "9"
    And I fill in "Interest Rate" with "1.23"
    And I select "Monthly" from "Compound Frequency"
    And I press the "Reset" button
  Then the "Savings Goal" field should not contain "$98,765"
    And the "Initial Investment" field should not contain "$1,234"
    And the "num_years" field should not contain "9"
    And the "Interest Rate" field should not contain "1.23"
   # Fore reference, '0' is the default designated value for Annually and '3' is the designated value for Daily
    And the "Compound Frequency" field should contain "0"
    And the "Compound Frequency" field should not contain "3"
  When I fill in "Savings Goal" with "98765"
    And I fill in "Initial Investment" with "1234"
    And I fill in "num_years" with "9"
    And I fill in "Interest Rate" with "1.23"
    And I select "Monthly" from "Compound Frequency"
    And I press the "Calculate" button
    And I scroll "#savings-calc-wrapper" into view
  Then I should not see the text "4 errors have been found:"
    And I should not see an "#savings-calc-wrapper > div:nth-child(1) > div" element
