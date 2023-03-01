Feature: Investor Calculators
  As a Content Creator, I want to be able to calculate using all the three calculators

  @ui @api @wdio
  Scenario Outline: Investor Calculators Test
    Given I am on "/"
    Then I take a screenshot on "investor" using "calculators.feature" file with "@<tag>" tag

    Examples:
      | tag                             |
      | new_savingsgoalcalculator       |
      | new_rmdcalculator               |
      | new_cicalculator                |
      | cicalculator_edit_year          |
      | savingsgoalcalculator_edit_year |
      | new_cigraph                     |
