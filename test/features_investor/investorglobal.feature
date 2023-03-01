Feature: Global Items
As a site visitor and user, I want to see global things so I can know where I am

@api @javascript @investor
Scenario Outline: Verify All Footer Links On The Home Page
  Given I am on "/"
  When I scroll to the bottom
  Then I should see the link "<link>" in the "<area>" region
    And I click "<link>"

  Examples:
    | link                            | area    | text                                     |
    | Disclaimer                      | footer2 | Disclaimer                               |
    | Privacy                         | footer2 | SEC Web Site Privacy and Security Policy |
    | Plain Writing                   | footer2 | Plain Writing Initiative                 |
    | FOIA                            | footer2 | The Office of FOIA Services              |
    | SEC.gov                         | footer2 | Divisions & Offices                      |
    | MyMoney.gov                     | footer2 | MyMoney Five                             |
    | USA.gov                         | footer2 | 1-844-USA-GOV1                           |
    | Vulnerability Disclosure Policy | footer2 | Reporting a Vulnerability                |

@api @javascript @investor
Scenario: Signup for investor updates on the Home Page
  Given I am on "/"
  When I scroll to the bottom
    And I fill in "Enter Email Address" with "behatinvestortest@email.com"
    And I press the "Submit" button
  Then I should see the text "New Subscriber"

@api @javascript @investor
Scenario Outline: Social Media Links On Investor
  Given I am on "/"
  When I scroll to the bottom
    And I click "<link1>" in the "footer1" region
    And I confirm the popup
    And the link should open in a new tab
    And I wait 2 seconds
  Then I should see the text "<text1>"
    And I close the current tab

  Examples:
    | link1    | text1                                   |
    | Twitter  | SEC_Investor_Ed                         |
    | Facebook | @SECInvestorEducation                   |
    | YouTube  | U.S. Securities and Exchange Commission |

@api @javascript @investor
Scenario: Latest Tweet Above Footer On Investor
  Given I am on "/"
  When I scroll to the bottom
    And I switch to the iframe "twitter-widget-0"
    And I wait 2 seconds
  Then I should see the link "SEC Investor Ed"
    And I should see the text "@SEC_Investor_Ed"

@api @javascript @investor
Scenario: Verify Addthis For Investor
  Given "article" content:
    | title                           | body                                               | status | moderation_state |
    | Investor Behat E&D Test Article | Investor Behat Display Title http://www.finra.org/ | 1      | published        |
  When I am on "/investor-behat-ed-test-article"
    And I wait 2 seconds
  Then I should see the "a" element with the "class" attribute set to "at-share-btn at-svc-facebook" in the "addthis_investor" region
    And I should see the "a" element with the "class" attribute set to "at-share-btn at-svc-print" in the "addthis_investor" region
    And I should see the "a" element with the "class" attribute set to "at-share-btn at-svc-email" in the "addthis_investor" region
    And I should see the "a" element with the "class" attribute set to "at-share-btn at-svc-twitter" in the "addthis_investor" region
    And I should see the "a" element with the "class" attribute set to "at-share-btn at-svc-compact" in the "addthis_investor" region
  When I click on the element with css selector "a.at-svc-compact:nth-child(5) > span:nth-child(2) > svg:nth-child(1)"
    And I wait 1 seconds
  Then I should see the text "Share"
    And I should see the button "Load More"
    And I reload the page
    And I wait 2 seconds
  When I click on the element with css selector ".at-icon-facebook"
    And I switch to the new window
  Then I should see the text "Log in to use your Facebook account with Shared via AddThis."
    And I close the current tab

@api @javascript @investor
Scenario Outline: Check Environment Indicator
  Given I am logged in as a user with the "<role>" role
  When I visit "/"
  Then I should see the text "LOCAL LNDO" in the "env_indicator" region
    And I should see the "div" element with the "style" attribute set to "cursor: pointer; background-color: #f9c642; color: #212121" in the "env_indicator" region
  When I click on the element with css selector "#environment-indicator"
  Then I should see the link "Open on Prod" in the "env_indicator" region
    And I should see the link "Open on Train" in the "env_indicator" region
  When I visit "/admin/content"
  Then I should see the text "LOCAL LNDO" in the "env_indicator" region
    And I should see the "div" element with the "style" attribute set to "cursor: pointer; background-color: #f9c642; color: #212121" in the "env_indicator" region
    And the hyperlink "Open on Prod" should match the Drupal url "https://dcm.investor.gov/admin/content"
    And the hyperlink "Open on Train" should match the Drupal url "https://dcmtrain.investor.gov/admin/content"

  Examples:
    | role             |
    | Administrator    |
    | Site Builder     |
    | Content Creator  |
    | Content Approver |

@api @investor
Scenario: Autenticated User Environment Indicator
  Given I am logged in as a user with the "Authenticated user" role
  When I visit "/"
  Then I should not see the text "LOCAL LNDO"

@api @javascript @investor
Scenario: Verify the SEC Logo Links to SEC.gov
  Given I am on page "/"
  When I click on the element with css selector ".banner-seal"
  Then I should be on "https://www.sec.gov"
