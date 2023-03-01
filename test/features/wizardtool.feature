Feature: OASB Wizard Tool
  As an end user
  I want to be able to use wizard tool for guidance on small buiness resources and information.

  Background:
    Given "secarticle" content:
      | field_article_type_secarticle | moderation_state | title             | field_display_title | status | changed | body                                              | field_primary_division_office                 | field_left_nav_override |
      | Other                         | published        | Behat Wizard Tool | Behat Wizard Tool   | 1      | 1 month | <div id="decision-tree">Loading Wizard Tool</div> | Advocate for Small Business Capital Formation | Education menu          |
      And I create "media" of type "static_file":
        | name             | field_display_title | field_media_file      | field_description_abstract | status |
        | oasb wizard tool | Behat wizard tool   | oasb-wizard-tool.json | oasb wizard tool           | 1      |

@api @javascript
Scenario: Less Than 1 Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "Less than $1 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Registered Offering (or IPO)" in the "relevant_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 1-5 Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$1 million to $5 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Registered Offering (or IPO)" in the "relevant_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 5-10 Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$5 million to $10 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should not see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Regulation Crowdfunding" in the "other_results" region
    And I should see the text "Intrastate Offering" in the "other_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 10-20 Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$10 million to $20 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "other_results" region
    And I should see the text "Regulation Crowdfunding" in the "other_results" region
    And I should see the text "Intrastate Offering" in the "other_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 20-75 Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$20 million to $75 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "other_results" region
    And I should see the text "Regulation Crowdfunding" in the "other_results" region
    And I should see the text "Intrastate Offering" in the "other_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 75 Or More Million Capital Raise With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$75 million or more"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Registered Offering (or IPO)" in the "relevant_results" region
    And I should not see the text "Mini-IPO" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "other_results" region
    And I should see the text "Rule 504 Limited Offering" in the "other_results" region
    And I should see the text "Regulation Crowdfunding" in the "other_results" region
    And I should see the text "Intrastate Offering" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: Do Not Know Capital Raise Amount With Intrastate Personal Network Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "I don't know."
  Then I should see the heading "Let’s explore resources!"
    And I should see the link "10 Steps to Start Your Business"
    And I should see the link "SBA"
    And I should see the link "Minority Business Development Administration"
    And I should see the link "calculating your startup costs"
  When I click "continue."
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Registered Offering (or IPO)" in the "relevant_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: Less Than 1 Million Capital Raise With Out Of State Online/Advertising Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "Less than $1 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Online or via Advertising"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Out of State or Undecided"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should not see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should not see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "other_results" region
    And I should see the text "Rule 506(b) Private Placement" in the "other_results" region
    And I should see the text "Rule 504 Limited Offering" in the "other_results" region
    And I should see the text "Intrastate Offering" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: 1-5 Million Capital Raise With No Connection Idea On Intrastate Non-Accredited Potential Investors
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "Behat Wizard Tool"
    And I should see the text "Does your business already exist?"
    And I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "Have you explored your options for external capital before focusing on raising capital from investors?"
    And I should see the text "2 of 8"
    And I click "Yes"
  Then I should see the text "Have you already decided what type of offering you want to pursue?"
    And I should see the text "3 of 8"
    And I click "Not Yet"
  Then I should see the text "How much money do you plan to raise?"
    And I should see the text "4 of 8"
  When I click "$1 million to $5 million"
  Then I should see the text "How do you plan to connect with potential investors?"
    And I should see the text "5 of 8"
  When I click "Other or Unknown"
  Then I should see the text "Where are your potential investors located?"
    And I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click "No"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
    And I should see the text "Rule 504 Limited Offering" in the "relevant_results" region
    And I should see the text "Regulation Crowdfunding" in the "relevant_results" region
    And I should see the text "Intrastate Offering" in the "relevant_results" region
    And I should see the text "Mini-IPO" in the "relevant_results" region
    And I should not see the text "Rule 506(b) Private Placement" in the "relevant_results" region
    And I should not see the text "Rule 506(c) General Solicitation Offering" in the "relevant_results" region
    And I should see the text "Rule 506(b) Private Placement" in the "other_results" region
    And I should see the text "Rule 506(c) General Solicitation Offering" in the "other_results" region
    And I should see the text "Registered Offering (or IPO)" in the "other_results" region
    And I should see the text "Next steps"
  When I click "Methodology"
  Then I should see the text "Navigating Your Options: Methodology"
    And I should see the text "Offering Types"
    And I should see the text "Dynamic Filtering"
    And I should see the text "Offering Type Utilization"

@api @javascript
Scenario: Use Wizard Back Button To Navigate Back To Start Of Wizard
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "1 of 8"
  When I click "No"
  Then I should see the text "Let’s explore business fundamentals!"
  When I click "continue."
  Then I should see the text "2 of 8"
  When I click "Yes"
  Then I should see the text "3 of 8"
  When I click "Not Yet"
  Then I should see the text "4 of 8"
  When I click "$1 million to $5 million"
  Then I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "8 of 8"
  When I click "Methodology"
    And I click on the element with css selector ".back-btn"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "6 of 8"
    And I should see "Intrastate Only" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "5 of 8"
    And I should see "Using Only My Network" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "4 of 8"
    And I should see "$1 million to $5 million" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "3 of 8"
    And I should see "Not Yet" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "2 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "Let’s explore business fundamentals!"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "1 of 8"
    And I should see "No" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region

@api @javascript
Scenario: Change Answers
  Given I am logged in as a sitebuilder
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "2 of 8"
  When I click "Yes"
  Then I should see the text "3 of 8"
  When I click "Not Yet"
  Then I should see the text "4 of 8"
  When I click "Less than $1 million"
  Then I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "7 of 8"
  When I click "No"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "6 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "5 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "4 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "3 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "2 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "1 of 8"

@api @javascript
Scenario: Use Browser Forward Button To Navigate Through Wizard
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "1 of 8"
  When I click "Yes"
  Then I should see the text "2 of 8"
  When I click "Yes"
  Then I should see the text "3 of 8"
  When I click "Not Yet"
  Then I should see the text "4 of 8"
  When I click "$1 million to $5 million"
  Then I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "8 of 8"
  When I click "Methodology"
    And I click on the element with css selector ".back-btn"
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
  When I click on the element with css selector ".back-btn"
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "6 of 8"
    And I should see "Intrastate Only" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "5 of 8"
    And I should see "Using Only My Network" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "4 of 8"
    And I should see "$1 million to $5 million" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "3 of 8"
    And I should see "Not Yet" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should see the text "2 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I click on the element with css selector ".back-btn"
  Then I should be on "/education/capitalraising/navigator#1"
    And I should see the text "1 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
    And I scroll "#decision-tree" into view
  When I hover over the element "#decision-tree > div > div.all-choices > a.next_id.dt-img-btn.selected > div.img > img"
  When I click the "#decision-tree" element
  When I move forward one page
  Then I should see the text "2 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move forward one page
  Then I should see the text "3 of 8"
    And I should see "Not Yet" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move forward one page
  Then I should see the text "4 of 8"
    And I should see "$1 million to $5 million" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move forward one page
  Then I should see the text "5 of 8"
    And I should see "Using Only My Network" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move forward one page
  Then I should see the text "6 of 8"
    And I should see "Intrastate Only" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move forward one page
  Then I should see the text "7 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region

@api @javascript
Scenario: Use Browser Back Button To Navigate Back To Start Of Wizard
  Given I am logged in as a content_approver
    And I visit "/Behat-Wizard-Tool/edit"
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="decision-tree">Loading Wizard Tool</div>' in the "Body" WYSIWYG editor
    And I fill in "URL alias" with "/education/capitalraising/navigator"
    And I publish it
  When I am not logged in
    And I visit "/Behat-Wizard-Tool"
  Then I should see the text "1 of 8"
  When I click "No"
  Then I should see the text "Let’s explore business fundamentals!"
  When I click "continue."
  Then I should see the text "2 of 8"
  When I click "Yes"
  Then I should see the text "3 of 8"
  When I click "Not Yet"
  Then I should see the text "4 of 8"
  When I click "$1 million to $5 million"
  Then I should see the text "5 of 8"
  When I click "Using Only My Network"
  Then I should see the text "6 of 8"
  When I click "Intrastate Only"
  Then I should see the text "7 of 8"
  When I click "Yes"
  Then I should see the text "8 of 8"
  When I click "Methodology"
    And I move backward one page
  Then I should see the text "The results are in!"
    And I should see the text "8 of 8"
  When I move backward one page
  Then I should see the text "Are your investors all accredited?"
    And I should see the text "7 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "6 of 8"
    And I should see "Intrastate Only" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "5 of 8"
    And I should see "Using Only My Network" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "4 of 8"
    And I should see "$1 million to $5 million" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "3 of 8"
    And I should see "Not Yet" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "2 of 8"
    And I should see "Yes" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
  When I move backward one page
  Then I should see the text "Let’s explore business fundamentals!"
  When I move backward one page
  Then I should see the text "1 of 8"
    And I should see "No" in the "a" element with the "class" attribute set to "next_id dt-img-btn selected" in the "wizard_allchoices" region
