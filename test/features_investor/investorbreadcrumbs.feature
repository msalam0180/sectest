Feature: Bread Crumbs on Investor Page
As a site visitor, I should be able to navigate to the pages easily using bread crumbs

@api @investor
Scenario Outline: Bread Crumbs
  Given I am on "/"
  When I visit "<link>"
  Then I should see the text "<heading1>"
    And I should see the link "<crumb1>" in the "bread_crumbs" region
    And I should see the link "<crumb2>" in the "bread_crumbs" region
    And I should see the link "<crumb3>" in the "bread_crumbs" region
  When I click "<crumb2>" in the "bread_crumbs" region
  Then I should see the text "<heading2>"

  Examples:
    | link                                                                                                  | heading1                                               | crumb1 | crumb2                    | crumb3                    | heading2                  |
    | /protect-your-investments/fraud/types-fraud/ponzi-scheme                                              | Ponzi Scheme                                           | Home   | Protect Your Investments  | Types of Fraud            | Protect Your Investments  |
    | /introduction-investing/retirement-plans/employer-sponsored-plans/403b-457b-plans                     | 403(b) and 457(b) Plans                                | Home   | Additional Resources      | Employer-Sponsored Plans  | Introduction to Investing |
    | /introduction-investing/retirement-plans/employer-sponsored-plans/pension-plans                       | Pension Plans                                          | Home   | Additional Resources      | Employer-Sponsored Plans  | Introduction to Investing |
    | /introduction-investing/general-resources/publications-and-research/sec-research                      | SEC Research                                           | Home   | Introduction to Investing | Publications and Research | Introduction to Investing |
    | /protect-your-investments/fraud/types-fraud/pyramid-schemes                                           | Pyramid Schemes                                        | Home   | Protect Your Investments  | Types of Fraud            | Protect Your Investments  |
    | /additional-resources/general-resources/useful-websites/public-alert-unregistered-soliciting-entities | Public Alert: Unregistered Soliciting Entities (PAUSE) | Home   | Introduction to Investing | Useful Websites           | Additional Resources      |
    | /protect-your-investments/fraud/resources-victims-securities-law-violations                           | Resources for Victims of Securities Law Violations     | Home   | Protect Your Investments  |                           | Introduction to Investing |
    | /additional-resources/spotlight/world-investor-week                                                   | World Investor Week                                    | Home   | Additional Resources      |                           | Additional Resources      |
    | /additional-resources/specialized-resources/caring-loved-ones/diminished-capacity                     | Diminished Capacity                                    | Home   | Additional Resources      |                           | Additional Resources      |
    | /introduction-investing/basics/investment-products/bonds                                              | Bonds                                                  | Home   | Introduction to Investing | Investment Products       | Introduction to Investing |
    | /introduction-investing/basics/investment-products/variable-annuities                                 | Variable Annuities                                     | Home   | Introduction to Investing | Investment Products       | Introduction to Investing |
    | /financial-tools-calculators/calculators/compound-interest-calculator                                 | Compound Interest Calculator                           | Home   |                           |                           |                           |
    | /financial-tools-calculators/financial-tools/mutual-fund-analyzer                                     | Mutual Fund Analyzer                                   | Home   |                           |                           |                           |
    | /financial-tools-calculators/financial-tools/529-expense-analyzer                                     | 529 Expense Analyzer                                   | Home   |                           |                           |                           |
    | /introduction-investing/investing-basics/investment-products/international-investing                  | International Investing                                | Home   | Introduction to Investing | Investment Products       |                           |
