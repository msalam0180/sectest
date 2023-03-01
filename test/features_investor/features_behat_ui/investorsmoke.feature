Feature: Smoke test on investor page
  This test is for smoke test purposes to check pages screenshots

  @ui @api @wdio
  Scenario Outline: Investor Smoke Test
    Given I am on "/"
    Then I take a screenshot on "investor" using "smoketest.feature" file with "@<tag>" tag

      Examples:
      | tag                                             |
      | youth-resources                                 |
      | saving-investing-resources-teachers             |
      | world-investor-week                             |
      | public-service-campaign                         |
      | glossary                                        |
      | about_us                                        |
      | contact_us                                      |
      | follow-us-social-media                          |
      | espanol                                         |
      | how-stock-markets-work                          |
      | role-sec                                        |
      | laws-govern-securities-industry                 |
      | how-avoid-fraud                                 |
      | asset-allocation                                |
      | researching-investments                         |
      | using-emma-researching-municipal-securities     |
      | assessing-your-risk-tolerance                   |
      | researching-investments                         |
      | what-are-mechanics-voting-either-person-or      |
      | submit-questions-complaints                     |
      | arbitration-mediation-clinics                   |
      | 403b-plan                                       |
      | roth-401k-plan                                  |
      | resources-victims-securities-law-violations     |
      | introduction-investing                          |
      | research-before-you-invest                      |
      | protect-your-investments                        |
      | additional-resources                            |
      | publications-research                           |
      | useful-websites                                 |
      | spotlight-initial-coin-offerings-digital-assets |
      | seniors                                         |
      | military                                        |
      | native-americans                                |
      | directors-take                                  |
      | librarian-resources-page                        |
      | additional-resources                            |
      | mutual-fund-analyzer                            |
      | 529-expense-analyzer                            |
      | retirement-estimator                            |
      | ballpark-etimate                                |
      | save-invest                                     |
      | invest-your-goals                               |
      | investment-products                             |
      | investment-professionals                        |
      | free-financial-planning-tools                   |
      | RMD_results                                     |
      | protectMainPage                                 |
      | researchingInvestments                          |
      | fiveQuestions                                   |
      | investmentProducts                              |
      | usingEdgar                                      |
      | researchBeforeYouInvest                         |
      | avoidInvestmentFraud                            |
      | typesOfFraud                                    |
      | victimResources                                 |
      | new_CIcalculator                                |
      | goal_calculator                                 |
      | saving_compound_interest                        |
      | saving_distribuion                              |
      | ci-calculator                                   |
      | savings-Goal-calculator                         |
      | rmd-calculator                                  |

# To match the baseline screenshot remove all Inclusions on Simple XML Sitemap configs.
@ui @api @wdio @javascript
  Scenario: Investor Sitemap XML
    Given I am logged in as a user with the "administrator" role
      And I am on "/admin/config/search/simplesitemap"
      And I press "Rebuild queue & generate"
      And I wait 5 seconds
    Then I take a screenshot on "investor" using "smoketest.feature" file with "@sitemap" tag
