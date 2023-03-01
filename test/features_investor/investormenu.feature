Feature: Menus On Investor Page
  As a Site Visitor, the user should be able to see menu on the home page.

@api @investor
Scenario Outline: Main Navigation Menus On Home Page
  Given I am on "/"
  Then I should see the link "<link>"
    And the hyperlink "<link>" should match the Drupal url "<url>"
  When I click "<link>"
  Then I should see the text "<text>"

  Examples:
    | link                          | url                            | text                          |
    | Introduction to Investing     | /introduction-investing        | Introduction to Investing     |
    | Financial Tools & Calculators | /free-financial-planning-tools | Free Financial Planning Tools |
    | Protect Your Investments      | /protect-your-investments      | Protect Your Investments      |
    | Additional Resources          | /additional-resources          | Additional Resources          |

@api @javascript @investor
Scenario Outline: Sixpack Menu Links On The Home Page
  Given I am on "/"
    And I wait for ajax to finish
  Then the hyperlink "<link>" should match the Drupal url "<url>"
  When I click "<link>" in the "sixpack_homepage" region
  Then I should see the text "<text>"

  Examples:
    | link                            | url                                                          | text                                                                                            |
    | About Investment Professionals  | /investment-professionals                                    | Investment Professionals                                                                        |
    | Investment Products             | /introduction-investing/investing-basics/investment-products | Investment Products                                                                             |
    | Understanding Fees              | /introduction-investing/getting-started/understanding-fees   | Understanding Fees                                                                              |
    | Investing Quizzes               | /additional-resources/spotlight/investing-quizzes            | Investing Quiz                                                                                  |
    | Financial Tools and Calculators | /free-financial-planning-tools                               | Required Minimum Distribution Calculator                                                        |
    | Crypto Assets                   | /additional-resources/spotlight/crypto-assets                | Learn about actions involving crypto assets that the SEC’s Division of Enforcement has brought. |

@api @javascript @investor
Scenario Outline: Default Menus on Investor Page
  Given I am on "/about-us"
  When I hover over the element "<selector>"
    And I click "<link-text>"
    And I wait 2 seconds
  Then I should see the text "<text>"

  Examples:
    | selector                            | link-text                                | text                                        |
    | #investor-main-menu > .menu-index-1 | Five Questions to Ask Before You Invest  | Five Questions to Ask Before You Invest     |
    | #investor-main-menu > .menu-index-1 | Understanding Fees                       | Understanding Fees                          |
    | #investor-main-menu > .menu-index-1 | Asset Allocation                         | Asset Allocation                            |
    | #investor-main-menu > .menu-index-1 | Assessing Your Risk Tolerance            | Assessing Your Risk Tolerance               |
    | #investor-main-menu > .menu-index-1 | Investing on Your Own                    | Investing on Your Own                       |
    | #investor-main-menu > .menu-index-1 | Working with an Investment Professional  | Working with an Investment Professional     |
    | #investor-main-menu > .menu-index-1 | Researching Investments                  | Researching Investments                     |
    | #investor-main-menu > .menu-index-1 | Save and Invest                          | Save and Invest                             |
    | #investor-main-menu > .menu-index-1 | Invest For Your Goals                    | Invest For Your Goals                       |
    | #investor-main-menu > .menu-index-1 | How Stock Markets Work                   | How Stock Markets Work                      |
    | #investor-main-menu > .menu-index-1 | Investment Products                      | Investment Products                         |
    | #investor-main-menu > .menu-index-1 | What is Risk?                            | What is Risk?                               |
    | #investor-main-menu > .menu-index-1 | Role of the SEC                          | Role of the SEC                             |
    | #investor-main-menu > .menu-index-1 | Glossary                                 | Glossary                                    |
    | #investor-main-menu > .menu-index-1 | Investor Alerts & Bulletins              | Investor Alerts and Bulletins               |
    | #investor-main-menu > .menu-index-1 | Publications and Research                | Publications and Research                   |
    | #investor-main-menu > .menu-index-1 | Useful Websites                          | Useful Websites                             |
    | #investor-main-menu > .menu-index-2 | Investment Professional Background Check | Check Out Your Investment Professional      |
    | #investor-main-menu > .menu-index-2 | Fund Analyzer                            | Mutual Fund Analyzer                        |
    | #investor-main-menu > .menu-index-2 | Retirement Ballpark E$timate             | Ballpark E$timate                           |
    | #investor-main-menu > .menu-index-2 | Social Security Retirement Estimator     | Retirement Estimator                        |
    | #investor-main-menu > .menu-index-2 | College Savings Calculator               | specific education savings goal             |
    | #investor-main-menu > .menu-index-2 | Compound Interest Calculator             | Compound Interest Calculator                |
    | #investor-main-menu > .menu-index-2 | Savings Goal Calculator                  | Savings Goal Calculator                     |
    | #investor-main-menu > .menu-index-2 | Required Minimum Distribution Calculator | Required Minimum Distribution Calculator    |
    | #investor-main-menu > .menu-index-3 | Types of Fraud                           | Types of Fraud                              |
    | #investor-main-menu > .menu-index-3 | How to Avoid Fraud                       | How to Avoid Fraud                          |
    | #investor-main-menu > .menu-index-3 | Resources for Victims                    | Resources for Victims                       |
    | #investor-main-menu > .menu-index-3 | Submit Questions and Complaints          | Submit Questions and Complaints             |
    | #investor-main-menu > .menu-index-3 | Arbitration and Mediation Clinics        | Arbitration and Mediation Clinics           |
    | #investor-main-menu > .menu-index-4 | Director's Take                          | Director's Take                             |
    | #investor-main-menu > .menu-index-4 | Crypto Assets                            | Crypto Assets                               |
    | #investor-main-menu > .menu-index-4 | Microcap Fraud                           | Microcap Fraud                              |
    | #investor-main-menu > .menu-index-4 | World Investor Week                      | World Investor Week                         |
    | #investor-main-menu > .menu-index-4 | First Job                                | First Job                                   |
    | #investor-main-menu > .menu-index-4 | Switching Jobs                           | Switching Jobs                              |
    | #investor-main-menu > .menu-index-4 | Employer-Sponsored Plans                 | Employer-Sponsored Plans                    |
    | #investor-main-menu > .menu-index-4 | Federal Government Plans                 | Federal Government Plans                    |
    | #investor-main-menu > .menu-index-4 | Managing Lifetime Income                 | Managing Lifetime Income                    |
    | #investor-main-menu > .menu-index-4 | Senior Specialist Designations           | Senior Specialist Designations              |
    | #investor-main-menu > .menu-index-4 | Social Security                          | Social Security                             |
    | #investor-main-menu > .menu-index-4 | Avoiding Retirement Fraud                | Avoiding Retirement Fraud                   |
    | #investor-main-menu > .menu-index-4 | Librarians                               | Information for Librarians                  |
    | #investor-main-menu > .menu-index-4 | Military                                 | Military                                    |
    | #investor-main-menu > .menu-index-4 | Native Americans                         | Native Americans                            |
    | #investor-main-menu > .menu-index-4 | Seniors                                  | Seniors                                     |
    | #investor-main-menu > .menu-index-4 | Teachers                                 | Saving And Investing Resources For Teachers |
    | #investor-main-menu > .menu-index-4 | Youth                                    | Youth Resources                             |

@api @javascript @investor
Scenario: New Menu Link on Home page
  Given I am logged in as a user with the "Site Builder" role
  When I am on "/admin/structure/menu/manage/main/add"
    And I fill in "Menu link title" with "BEHAT Menu"
    And I fill in "Link" with "http://www.sec.gov"
    And I fill in "Description" with "This is a test menu link"
    And I press "Save"
    And I visit "/"
  Then I should see the link "BEHAT Menu" in the "investor_menu" region
  When I visit "/admin/structure/menu/manage/main"
    And I click "Edit" in the "BEHAT Menu" row
    And I click "edit-delete"
    And I wait 1 seconds
    And I press "edit-submit"
    And I visit "/"
  Then I should not see the text "BEHAT Menu" in the "investor_menu" region

@api @javascript @investor
Scenario: Modify sixpack menu link
  Given I am logged in as a user with the "Site Builder" role
    And "article" content:
      | title                       | body                                               | status | moderation_state | nid    |
      | Investor Behat Test Article | Investor Behat Display Title http://www.finra.org/ | 1      | published        | 777772 |
    And I am on "/block/86"
    And I scroll "#edit-body-wrapper" into view
    And I click "Link"
    And I wait for ajax to finish
    And I fill in "attributes[href]" with "/node/777772"
    And I wait for ajax to finish
    And I click on the element with css selector "button.button"
    And I wait 2 seconds
    And I press "edit-submit"
    And I wait 2 seconds
    And I should see the text "Basic block Homepage links has been updated."
  When I am on "/"
    And I click "Crypto Assets" in the "sixpack_homepage" region
    And I wait for ajax to finish
  Then I should see the text "INVESTOR BEHAT TEST ARTICLE"
    And I should see the link "http://www.finra.org/"
    And I am on "/block/86"
    And I scroll "#edit-body-wrapper" into view
    And I click "Link"
    And I wait for ajax to finish
    And I fill in "attributes[href]" with "/additional-resources/spotlight/crypto-assets"
    And I wait for ajax to finish
    And I click on the element with css selector "button.button"
    And I wait 2 seconds
    And I press "edit-submit"
    And I wait 2 seconds
    And I should see the text "Basic block Homepage links has been updated."
  When I am on "/"
    And I click "Crypto Assets" in the "sixpack_homepage" region
    And I wait for ajax to finish
  Then I should see the text "SEC Crypto Assets and Cyber Enforcement Actions"
