Feature: Smoke test on investor page
  This test is for smoke test purposes to check pages are loading without 404's.

@api @investor
Scenario Outline: Quick Smoke Test
  Given I am on "<link>"
  Then I should not see the text "PAGE NOT FOUND"

  Examples:
    | link                                                                                                  |
    | /additional-resources/specialized-resources/youth-resources                                           |
    | /additional-resources/information/saving-and-investing-resources-teachers                             |
    | /additional-resources/spotlight/world-investor-week                                                   |
    | /introduction-investing/investing-basics/glossary                                                     |
    | /about-us                                                                                             |
    | /contact-us                                                                                           |
    | /follow-us-social-media                                                                               |
    | /informacion-en-espanol                                                                               |
    | /introduction-investing/basics/how-stock-markets-work                                                 |
    | /introduction-investing/basics/role-sec                                                               |
    | /introduction-investing/basics/role-sec/laws-govern-securities-industry                               |
    | /protect-your-investments/fraud/how-avoid-fraud                                                       |
    | /introduction-investing/basics/role-sec/laws-govern-securities-industry#invadvact1940                 |
    | /research-before-you-invest/research/asset-allocation                                                 |
    | /research-before-you-invest/research/researching-investments                                          |
    | /researching-managing-investments/researching-investments/using-emma-researching-municipal-securities |
    | /researching-managing-investments/researching-investments/ask-check                                   |
    | /research-before-you-invest/research/assessing-your-risk-tolerance                                    |
    | /research-before-you-invest/research/shareholder-voting/what-are-mechanics-voting-either-person-or    |
    | /protect-your-investments/seek-help/submit-questions-complaints                                       |
    | /protect-your-investments/seek-help/arbitration-mediation-clinics                                     |
    | /additional-resources/general-resources/glossary/403b-plan                                            |
    | /additional-resources/general-resources/glossary/roth-401k-plan                                       |
    | /protect-your-investments/fraud/resources-victims-securities-law-violations                           |
    | /introduction-investing                                                                               |
    | /research-before-you-invest                                                                           |
    | /protect-your-investments                                                                             |
    | /additional-resources                                                                                 |
    | /additional-resources/general-resources/publications-research                                         |
    | /additional-resources/general-resources/useful-websites                                               |
    | /additional-resources/spotlight/crypto-assets                                                         |
    | /seniors                                                                                              |
    | /additional-resources/specialized-resources/military                                                  |
    | /additional-resources/specialized-resources/native-americans                                          |
    | /additional-resources/specialized-resources/directors-take                                            |
    | /additional-resources/information/librarian-resources-page                                            |
    | /additional-resources/free-financial-planning-tools/mutual-fund-analyzer                              |
    | /additional-resources/free-financial-planning-tools/529-expense-analyzer                              |
    | /additional-resources/free-financial-planning-tools/retirement-estimator                              |
    | /additional-resources/free-financial-planning-tools/ballpark-etimate                                  |
    | /additional-resources/free-financial-planning-tools/savings-goal-calculator                           |
    | /additional-resources/free-financial-planning-tools/compound-interest-calculator                      |
    | /additional-resources/free-financial-planning-tools/required-minimum-distribution-calculator          |
    | /introduction-investing/basics/save-invest                                                            |
    | /introduction-investing/basics/invest-your-goals                                                      |
    | /introduction-investing/basics/how-stock-markets-work                                                 |
    | /introduction-investing/basics/investment-products                                                    |
