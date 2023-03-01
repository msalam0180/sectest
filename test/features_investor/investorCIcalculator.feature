Feature: Compound Interest Calculator
  As a User I want to calculate to approximate the money can grow using the power of compound interest.
  #DI-2116 Bug created to fix value for negative contributions

@api @javascript @investor
Scenario Outline: CI Calculations
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
  When I fill in "Initial Investment" with "<initial_investment>"
    And I fill in "Monthly Contribution" with "<monthly_contribution>"
    And I fill in "Length of Time in Years" with "<time_in_years>"
    And I fill in "Estimated Interest Rate" with "<interest_rate>"
    And I fill in "Interest rate variance range" with "<Interest_variance_range>"
    And I select "<compound_frequency>" from "Compound Frequency"
    And I press the "Calculate" button
    And I wait for ajax to finish
    And I scroll to the bottom
  Then I should see the text "The Results Are In"
    And I should see the text "In <time_in_years> years, you will have <result>"
    And I should see the text "Total Savings"
  When I press the "Show Table" button
    And I wait for ajax to finish
  Then I should see the text "<initial_investment>" in the "Year 0" row
    And I should see the text "<result>" in the "Year 10" row
    And I should see the text "<result2>" in the "Year 10" row
    And I should see the text "<result3>" in the "Year 10" row
    And I should see the text "Hide Table"

  Examples:
    | initial_investment | monthly_contribution | time_in_years | interest_rate | Interest_variance_range | compound_frequency | result      | result2     | result3     |
    | $50,000.00         | 100                  | 10            | 5             | 0.5                     | Annually           | $96,538.20  | $92,394.32  | $100,857.65 |
    | $50,000.00         | 100                  | 10            | 5             | 0.5                     | Semiannually       | $97,257.62  | $92,972.37  | $101,739.86 |
    | $50,000.00         | 100                  | 10            | 5             | 0.5                     | Quarterly          | $97,627.84  | $93,268.89  | $102,195.36 |
    | $50,000.00         | 100                  | 10            | 5             | 0.5                     | Monthly            | $97,878.70  | $93,469.45  | $102,504.58 |
    | $50,000.00         | 100                  | 10            | 5             | 0.5                     | Daily              | $98,001.20  | $93,567.27  | $102,655.74 |
    | $50,000.00         | -1000                | 10            | 5             | 0.5                     | Daily              | $-73,246.31 | $-73,124.88 | $-73,307.75 |

@api @javascript @investor
Scenario: CI Calculator Required Fields and Reset
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
    And I fill in "Monthly Contribution" with "217"
    And I fill in "Interest rate variance range" with "1.26"
    And I select "Semiannually" from "Compound Frequency"
  When I press the "Calculate" button
    And I scroll "#calculator_wrapper" into view
    And I wait 2 seconds
  Then I should see the text "Initial Investment field is required."
    And I should see the text "Length of Time in Years field is required."
    And I should see the text "Estimated Interest Rate field is required."
  When I press the "Reset" button
  Then I should not see the text "Initial Investment field is required."
    And I should not see the text "Length of Time in Years field is required."
    And I should not see the text "Estimated Interest Rate field is required."
    And the "Monthly Contribution" field should not contain "$217"
    And the "Interest rate variance range" field should not contain "1.26"
    # Fore reference, '0' is the default designated value for Annually and '1' is the designated value for Semiannually
    And the "Compound Frequency" field should contain "0"
    And the "Compound Frequency" field should not contain "1"
  When I fill in "Initial Investment" with "9123"
    And I fill in "Length of Time in Years" with "13"
    And I fill in "Estimated Interest Rate" with "1.23"
    And I press the "Reset" button
  Then the "Initial Investment" field should not contain "$9,123"
    And the "Length of Time in Years" field should not contain "13"
    And the "Estimated Interest Rate" field should not contain "1.23"

@api @javascript @investor
Scenario: No Error Message Box Shows On Top After CI Calculator Reset
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
  When I press the "Calculate" button
    And I wait 1 seconds
  Then I should see an "#compound-interest-calc-wrapper > div:nth-child(1) > div" element
    And I should see the text "3 errors have been found: Initial InvestmentLength of Time in YearsEstimated Interest Rate"
  When I press the "Reset" button
    And I scroll to the top
  Then I should not see the text "3 errors have been found: Initial InvestmentLength of Time in YearsEstimated Interest Rate"
    And I should not see an "#compound-interest-calc-wrapper > div:nth-child(1) > div" element
  When I fill in "Initial Investment" with "9123"
    And I fill in "Length of Time in Years" with "13"
    And I fill in "Estimated Interest Rate" with "1.23"
    And I press the "Calculate" button
    And I scroll to the top
  Then I should not see the text "3 errors have been found: Initial InvestmentLength of Time in YearsEstimated Interest Rate"
    And I should not see an "#compound-interest-calc-wrapper > div:nth-child(1) > div" element

@api @javascript @investor
Scenario: Verification of Minimum Length Of Time
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
  When I fill in "Initial Investment" with "1000"
    And I fill in "Monthly Contribution" with "500"
    And I fill in "Length of Time in Years" with ".5"
    And I fill in "Estimated Interest Rate" with "1.5"
    And I fill in "Interest rate variance range" with ".5"
    And I select "Annually" from "Compound Frequency"
    And I press the "Calculate" button
    And I wait for ajax to finish
  Then I should see the text "Years to grow must be 1 or above."
  When I press the "Reset" button
  Then I should not see the text "Years to grow must be 1 or above."

@api @javascript @investor
Scenario: Results Graph Still Displays Once Input Error Is Cleared
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
  When I fill in "Initial Investment" with "1000"
    And I fill in "Monthly Contribution" with "50"
    And I fill in "Length of Time in Years" with "10"
    And I fill in "Estimated Interest Rate" with "101"
    And I fill in "Interest rate variance range" with "0.5"
    And I select "Annually" from "Compound Frequency"
    And I press the "Calculate" button
    And I wait for ajax to finish
  Then I should see the text "Interest Rate must be below 100%"
  #Correct the interest to fix validation error
  When I fill in "Estimated Interest Rate" with "5"
    And I press the "Calculate" button
    And I wait for ajax to finish
  #Assert that chart/graph now renders
  Then I should see the text "The Results Are In"
    And I should see the text "In 10 years, you will have $9,175.63"
    And I scroll "#calculator_results_chart" into view
    And I should see the text "Total Savings"

@api @javascript @investor
Scenario Outline: CI Calculator Fractional Year Calculation
  Given I am on "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
  When I fill in "Initial Investment" with "<initialinvestment>"
    And I fill in "Monthly Contribution" with "<monthlycontribution>"
    And I fill in "Length of Time in Years" with "<timeinyears>"
    And I fill in "Estimated Interest Rate" with "<interestrate>"
    And I fill in "Interest rate variance range" with "<Interestvariancerange>"
    And I select "<compoundfrequency>" from "Compound Frequency"
    And I press the "Calculate" button
    And I wait for ajax to finish
    And I scroll to the bottom
  Then I should see the text "The Results Are In"
    And I should see the text "In <timeinyears> years, you will have <result>"
    And I should see the text "Total Savings"
  When I press the "Show Table" button
    And I wait for ajax to finish
  Then I should see the text "<initialinvestment>" in the "Year 0" row
    And I should see the text "<result>" in the "Year 11" row
    And I should see the text "<result2>" in the "Year 11" row
    And I should see the text "<result3>" in the "Year 11" row
    And I should see the text "Hide Table"

  Examples:
     | initialinvestment | monthlycontribution | timeinyears    | interestrate | Interestvariancerange | compoundfrequency | result      | result2     | result3     |
     | $50,000.00        | 100                 | 10.25          | 5            | 0.5                   | Annually          | $98,017.48  | $93,711.73  | $102,510.73 |
     | $50,000.00        | 100                 | 10.5           | 5            | 0.5                   | Semiannually      | $100,289.06 | $95,664.25  | $105,137.71 |
     | $50,000.00        | 100                 | 10.64          | 5            | 0.5                   | Quarterly         | $101,557.97 | $96,753.41  | $106,607.57 |
     | $50,000.00        | 100                 | 10.99          | 5            | 0.5                   | Monthly           | $104,050.34 | $98,932.05  | $109,445.31 |
     | $50,000.00        | 100                 | 10.01          | 5            | 0.5                   | Daily             | $98,062.21  | $93,621.38  | $102,724.22 |
     | $50,000.00        |-1000                | 10.12          | 5            | 0.5                   | Daily             | $-75,131.31 | $-74,964.61 | $-75,237.80 |
