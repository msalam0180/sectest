Feature: Search on investor page
  As a Site Visitor, the user should be able search from the landing page of investor.gov.

  @api @javascript @investor
  Scenario: Create Article to test Search
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "Apple manasu Test Article"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Apple Test Article Summary"
      And I type "Investor Apple Behat Display Title" in the "Body" WYSIWYG editor
      And I press the "Save" button
    Then I should see the text "Article Apple manasu Test Article has been created."

  @api @javascript @investor
  Scenario: Create basic page to test Search
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/page"
      And I fill in "Title" with "Behat Samsung Investor tadakara Test page"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Behat Samsung investor page test"
      And I type "Behat Samsung Display Title" in the "Body" WYSIWYG editor
      And I press the "Save" button
    Then I should see the text "Behat Samsung Investor tadakara Test page"
    When I select "Published" from "edit-new-state"
      And I press "edit-submit"
      And I click "Investor.gov"
    Then I should not see the text "Behat Samsung Investor Test page"

  @api @javascript @investor
  Scenario Outline: Investor Search test2
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/page"
      And I fill in "Title" with "<text2>"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Behat Samsung investor page test"
      And I type "Behat Samsung Display Title" in the "Body" WYSIWYG editor
      And I press the "Save" button
    Then I should see the text "<text2>"
      And I select "Published" from "edit-new-state"
      And I press "edit-submit"
      And I wait for ajax to finish
    When I am on "/"
      And I fill in "Search Investor.gov" with "<text1>"
      And I click on the element with css selector "#edit-submit-search-content"
      And I wait 2 seconds
    Then I should see the text "<text2>"

    Examples:
      | text1    | text2                                     |
      | manasu   | Apple manasu Test Article                 |
      | tadakara | Behat Samsung Investor tadakara Test page |

  @api @javascript @investor
  Scenario: Verify NoResult Message on Investor
    Given I am on "/"
    When I fill in "Search Investor.gov" with "ibvestor"
      And I click on the element with css selector "#edit-submit-search-content"
      And I wait for AJAX to finish
    Then I should see the text "Your Search Yielded No Results"
      And I should see the text "Check if your spelling is correct"
      And I should see the text 'Remove quotes around phrases to match each word individually: "asset management" will match less than asset management.'
      And I should see the text "Consider loosening your query with OR: asset management will match less than asset OR management."
      And I should see the text "Additional SEC resources (to search for information that is not available on Investor.gov)"
      And I should see the text "for checking the background of an investment professional or firm."
      And I should see the link "Investment Adviser Public Disclosure database"
      And the hyperlink "Investment Adviser Public Disclosure database" should match the Drupal url "http://www.adviserinfo.sec.gov/IAPD/Default.aspx"
      And I should see the text "for researching a public company or looking for a particular SEC filing, such as a Form 10-K, Form 10-Q, or Form 8–K."
      And I should see the link "EDGAR database"
      And the hyperlink "EDGAR database" should match the Drupal url "https://www.sec.gov/edgar/searchedgar/companysearch.html"
      And I should see the text "for SEC public statements, proposed and final rules, enforcement actions, additional educational materials, and other documents."
      And I should see the link "Comprehensive search page"
      And the hyperlink "Comprehensive search page" should match the Drupal url "https://www.sec.gov/search/search.htm"

  @api @javascript @investor
  Scenario: Investor Search Suggestions
    Given "article" content:
      | title                                   | body                                     | status | moderation_state |
      | 110-0 Investor Behat D143J Test Article | 110-0 Investor D143J Behat Display Title | 1      | published        |
      | 110-1 Investor Behat D143J Test Article | 110-2 Investor D143J Behat Display Title | 1      | published        |
      And "page" content:
        | title                                  | body                                   | status | moderation_state |
        | 110-2 teacup Test D143J Page Investor1 | 110-2 teacup D143J Behat Display Title | 1      | published        |
        | 110-3 teacup Test D143J Page Investor2 | 110-3 teacup D143J Behat Display Title | 1      | published        |
      And I run cron
    When I am on "/"
      And I fill in "Search Investor.gov" with "110-0"
      And I select the first autocomplete option for "110-0" on the "Search" field
    Then I should see the text "110-0 Investor D143J Behat Display Title"
    When I am on "/"
      And I fill in "Search Investor.gov" with "teacup"
      And I select the first autocomplete option for "teacup" on the "Search" field
      And I wait 3 seconds
    Then I should see the text "teacup D143J Behat Display Title"
    When I am on "/"
      And I fill in "Search Investor.gov" with "D143J"
      And I wait 2 seconds
      And I am on "/search?keys=D143J"
    Then I should see the link "110-0 Investor Behat D143J Test Article" in the maincontent region
      And I should see the link "110-1 Investor Behat D143J Test Article" in the maincontent region
      And I should see the link "110-2 teacup Test D143J Page Investor1" in the maincontent region
      And I should see the link "110-3 teacup Test D143J Page Investor2" in the maincontent region

  @api @javascript @investor
  Scenario: Investor Case Sensitive Search Suggestions
    Given "article" content:
      | title                            | body                                     | status | moderation_state |
      | Investor Behat NEWP Test Article | 110-0 Investor D143J Behat Display Title | 1      | published        |
      And "page" content:
        | title                            | body                                   | status | moderation_state |
        | Baseball Test newp Page Investor | 110-2 teacup D143J Behat Display Title | 1      | published        |
      And I run cron
    When I am on "/"
      And I fill in "Search Investor.gov" with "NEWP"
      And I select the first autocomplete option for "NEWP" on the "Search" field
      And I wait 1 seconds
      And I am on "/search?keys=NEWP"
    Then I should see the link "Investor Behat NEWP Test Article" in the maincontent region
      And I should see the link "Baseball Test newp Page Investor" in the maincontent region
    When I am on "/"
      And I fill in "Search Investor.gov" with "newp"
      And I select the first autocomplete option for "newp" on the "Search" field
      And I wait 1 seconds
      And I am on "/search?keys=newp"
    Then I should see the link "Investor Behat NEWP Test Article" in the maincontent region
      And I should see the link "Baseball Test newp Page Investor" in the maincontent region

  @api @javascript @investor
  Scenario: Investor Site Search by Alternate Name
    Given I am logged in as a user with the "Content Approver" role
      And "page" content:
        | title              | body                                    | field_alternate_name | status | moderation_state |
        | Test Page Investor | Behat Display Title http://www.SEC.gov/ | Altu Nume            | 1      | published        |
    When I am on "/node/add/article"
      And I fill in "Title" with "Investor Behat E&D Test Article"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Apple Test Article Summary"
      And I type "Investor Behat Display Title http://www.finra.org/" in the "Body" WYSIWYG editor
      And I fill in "Alternate Name" with "Altu Nume , Manutest"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "Save" button
    Then I should see the text "Article Investor Behat E&D Test Article has been created."
    When I run cron
      And I am on "/search?keys=Altu Nume"
    Then I should see the link "Investor Behat E&D Test Article" in the maincontent region
      And I should see the link "Test Page Investor" in the maincontent region
    When I am on "/search?keys=Manutest"
    Then I should see the link "Investor Behat E&D Test Article" in the maincontent region
      And I should not see the link "Test Page Investor"

  @api @javascript @investor
  Scenario: Searching in Glossary with Alternative Names
    Given "glossary_term" content:
      | title                | body                     | field_alternate_name | status | moderation_state |
      | 1 Glossary           | Behat glossary           |                      | 1      | published        |
      | 2 Glossary Name      | Behat glossary name      | NAME                 | 1      | published        |
      | 3 Glossary Term      | Behat glossary term      | term                 | 1      | published        |
      | 4 Glossary Alternate | Behat glossary alternate | Alternate Name       | 1      | published        |
      | 5 Glossary Test      | Behat glossary search    | test nam             | 1      | published        |
      And I am logged in as a user with the "Authenticated user" role
      And I am on "/introduction-investing/investing-basics/glossary"
    When I fill in "Search" with "Behat"
    Then I should see the text "No results"
    When I fill in "Search" with "1 Glossary"
    Then I should see the link "1 Glossary"
      And I should see the text "Behat glossary"
      And I should not see the text "2 Glossary Name"
      And I should not see the text "3 Glossary Term"
      And I should not see the text "4 Glossary Alternate"
      And I should not see the text "5 Glossary Test"
    When I fill in "Search" with "Alternate"
    Then I should see the link "4 Glossary Alternate"
      And I should see the text "Behat glossary alternate"
      And I should not see the text "1 Glossary"
      And I should not see the text "2 Glossary Name"
      And I should not see the text "3 Glossary Term"
      And I should not see the text "5 Glossary Test"
    When I fill in "Search" with "Nam"
    Then I should see the link "2 Glossary Name"
      And I should see the text "Behat glossary name"
      And I should see the link "4 Glossary Alternate"
      And I should see the text "Behat glossary alternate"
      And I should see the link "5 Glossary Test"
      And I should see the text "Behat glossary search"
      And I should not see the text "1 Glossary"
      And I should not see the text "3 Glossary Term"

  @api @javascript @investor
  Scenario Outline: Validate Permission for Searching Glossary Terms
    Given "glossary_term" content:
      | title                | body                     | status | moderation_state |
      | 1 Glossary published | Behat glossary published | 1      | published        |
      | 2 Glossary draft     | Behat glossary draft     | 1      | draft            |
    When I am logged in as a user with the "<role>" role
      And I am on "/introduction-investing/investing-basics/glossary"
      And I fill in "Search" with "Glossary"
    Then I should see the link "1 Glossary published"
      And I should see the text "Behat glossary published"
      And I should not see the text "2 Glossary"
    When I am logged in as a user with the "Administrator" role
      And I visit "/admin/content"
      And I click "Edit" in the "2 Glossary draft" row
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "Save" button
      And I am logged in as a user with the "<role>" role
      And I am on "/introduction-investing/investing-basics/glossary"
      And I fill in "Search" with "Glossary"
    Then I should see the link "1 Glossary published"
      And I should see the text "Behat glossary published"
      And I should see the text "2 Glossary draft"
      And I should see the text "Behat glossary"

    Examples:
      | role               |
      | Authenticated user |
      | Content Creator    |
      | Content Approver   |
      | Site Builder       |
      | Administrator      |

  @api @javascript @investor
  Scenario: Investor Search is not case sensitive
    Given "article" content:
      | title                                  | body                       | status | moderation_state |
      | 110-0 Investor poppyseeds Test Article | 110-0 Investor 12420 Behat | 1      | published        |
      | 110-1 Investor POPPYSEEDS Test Article | 110-2 Investor 12421 BEHAT | 1      | published        |
    When I am logged in as a user with the "Authenticated user" role
      And I run cron
      And I am on "/search?keys=POPPYSEEDS"
    Then I should see the link "110-0 Investor poppyseeds Test Article" in the maincontent region
      And I should see the link "110-1 Investor POPPYSEEDS Test Article" in the maincontent region

  @api @javascript @investor
  Scenario: Searching for Landing Page
    Given I am logged in as a user with the "Administrator" role
      And "landing" content:
        | title                         | body                         | status | moderation_state | nid |
        | Investor Behat Test Landing 1 | Behat Body Landing publish   | 1      | published        | 123 |
        | Investor Behat Test Landing 2 | Behat Body Landing unpublish | 1      | unpublished      | 122 |
      And I am on "/node/123/edit"
      And I press "Save"
      And I am on "/node/122/edit"
      And I press "Save"
    When I am logged in as a user with the "Authenticated user" role
      And I am on "/search?keys=Investor Behat Test Landing"
    Then I should see the link "Investor Behat Test Landing 1" in the maincontent region
      And I should not see the link "Investor Behat Test Landing 2"

  @api @javascript @investor
  Scenario: Searching for Landing Page Alternative Spelling
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
        | title                         | body                       | status | moderation_state | nid | field_alternate_name |
        | Investor Behat Test Landing 1 | Behat Body Landing publish | 1      | published        | 123 | random               |
      And I am on "/node/123/edit"
      And I press "Save"
    When I am logged in as a user with the "Authenticated user" role
      And I visit "/search?keys=random"
    Then I should see the link "Investor Behat Test Landing 1" in the maincontent region
