Feature: External links
  As a site visitor, the user should be able to click on external links and go to external sites

@api @investor
Scenario: External link on About Us page
  Given I am on "/"
  When I click "About Us"
  Then I should see the text "Welcome to Investor.gov!"
    And I click "question form"
  Then I should see the text "Questions and Feedback"
  When I am on "/"
    And I click "About Us"
    And I wait 1 seconds
    And I click "complaint forms"
  Then I should see the text "Investor Complaint Form"
    And I should see the text "3235-0547"

@api @javascript @investor
Scenario Outline: External link on Follow Us page
  Given I am on "/"
  When I click "Follow Us"
    And the hyperlink "<link>" should match the Drupal url "<url>"
    And I click "<link>"
    And I confirm the popup
    And I wait 2 seconds
    And the link should open in a new tab
    And I wait 2 seconds
  Then I should see the text "<text>"
    And I close the current tab

    Examples:
      | link                                           | text                                          | url                                          |
      | SEC Investor Education                         | SEC Investor Ed                               | http://twitter.com/SEC_Investor_ed           |
      | SEC News                                       | The SEC protects investors                    | http://twitter.com/SEC_News                  |
      | SEC Jobs                                       | his account expresses the author's views only | http://twitter.com/SEC_Careers               |
      | SEC Enforcement                                | SEC Enforcement                               | http://twitter.com/SEC_Enforcement           |
      | SEC Office of Investor Education and Advocacy. | SEC Office of Investor Education and Advocacy | http://www.facebook.com/SECInvestorEducation |
      | SEC Career Opportunities                       | U.S. Securities and Exchange Commission       | https://www.facebook.com/SECJobs             |
      | SEC Views                                      | U.S. Securities and Exchange Commission       | http://www.youtube.com/user/SECViews         |
      | SEC Photo Stream                               | Securities and Exchange Commission            | http://www.flickr.com/photos/67083337@N02    |

@api @investor
Scenario Outline: Link on Información en Español page
  Given I am on "/"
  When I click "<page>"
    And I click "<link>"
  Then I should see the text "<text>"

  Examples:
    | page                   | link                                            | text                                                 |
    | About Us               | question form                                   | Questions and Feedback                               |
    | About Us               | complaint forms                                 | Investor Complaint Form                              |
    | Follow Us              | SEC.gov's Privacy Policy                        | SEC Web Site Privacy and Security Policy             |
    | Follow Us              | Visit our free e-mail subscription service page | E-mail Updates                                       |
    | Información en Español | CFPB                                            | Oficina para la Protección Financiera del Consumidor |
    | Información en Español | Social Security Administration                  | Seguro Social                                        |
    | Información en Español | FTC                                             | Comisión Federal de Comercio                         |
    | Información en Español | Department of the Treasury                      | U.S. Department of the Treasury                      |
    | Información en Español | http://USA.gov                                  | Cómo puedo                                           |
    | Información en Español | Información Oficial del Seguro Social           | Seguro Social                                        |

@api @investor
Scenario: External links on Español page
  Given I am on "/"
  When I click "Información en Español"
    And I click "Bancarrota Corporativa"
    And I wait 2 seconds
  Then I should see the text "Lo que todo inversionista debería saber..."

@api @investor
Scenario: Contact Us
  Given I am on "/"
  When I click "Contact Us"
  Then I should see the text "Call us at"
    And I should see the text "Email us at"
    And I should see the text "Write us at:"

@api @javascript @investor
Scenario Outline: External Links on footer
  Given I am on "/"
  When I scroll to the bottom
  Then I should see the link "<link>" in the "<area>" region
    And I click "<link>"
    And I should see the text "<text>"

  Examples:
    | link        | area    | text                                                                |
    | MyMoney.gov | footer2 | MyMoney Five                                                        |
    | USA.gov     | footer2 | USAGov is the Official Guide to Government Information and Services |
    | SEC.gov     | footer2 | U.S. Securities and Exchange Commission                             |
  # All .gov links should have aria label and exception popup should not come when the links are clicked

# @api @javascript @investor
# Scenario: Exceptions for non .gov links on footer
#   Given I am on "/"
#   When I scroll to the bottom
#   Then I should see the link "FINRA" in the "footer2" region
#     And I click "FINRA"
#     And I confirm the popup
#     And I wait 2 seconds
#   Then I should see the text "Welcome to the new FINRA.org."
# FINRA link is not available on footer currently
