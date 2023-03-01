Feature: Financial Planning Tools on Investor Page
  As a site visitor, I should be able to navigate to the available financial planning calculator and estimator tools

@api @investor
Scenario Outline: External Financial Planning Tools
  Given I am on "/additional-resources"
  When I click "<link1>"
  Then I should see the text "<heading>"
    And I should see the link "<link2>"
    And the hyperlink "<link2>" should match the Drupal url "<url>"

  Examples:
    | link1                                | heading              | link2                                                                  | url                                                                        |
    | Retirement Ballpark E$timate         | BALLPARK E$TIMATE    | Please visit Choosetosave.org to use the Ballpark E$timate calculator. | https://tools.finra.org/retirement_calculator/                             |
    | Social Security Retirement Estimator | RETIREMENT ESTIMATOR | www.socialsecurity.gov/estimator                                       | http://www.socialsecurity.gov/estimator                                    |
    | Mutual Fund Analyzer                 | MUTUAL FUND ANALYZER | Please visit the FINRA site to use the Fund Analyzer                   | https://tools.finra.org/fund_analyzer/                                     |
    | 529 Expense Analyzer                 | 529 EXPENSE ANALYZER | Please visit the FINRA site to use the 529 Expense Analyzer            | http://apps.finra.org/Investor_Information/Smart/529/Calc/529_Analyzer.asp |

@api @javascript @investor
Scenario Outline: Blocks at the Bottom of the Calculator
  Given I am on "<link>"
  When I scroll to the bottom
  Then I should see the text "<text1>"
    And I should see the text "<text2>"
    And I should see the text "<text3>"

  Examples:
    | link                                                                                         | text1                        | text2                                    | text3                       |
    | /additional-resources/free-financial-planning-tools/compound-interest-calculator             | Savings Goal Calculator      | Required Minimum Distribution Calculator | MORE TOOLS TO HELP YOU SAVE |
    | /additional-resources/free-financial-planning-tools/savings-goal-calculator                  | Compound Interest Calculator | Required Minimum Distribution Calculator | MORE TOOLS TO HELP YOU SAVE |
    | /additional-resources/free-financial-planning-tools/required-minimum-distribution-calculator | Savings Goal Calculator      | Compound Interest Calculator             | MORE TOOLS TO HELP YOU SAVE |
