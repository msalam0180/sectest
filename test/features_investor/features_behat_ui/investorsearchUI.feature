Feature: UI Screenshots for Search on investor page
  As a Site Visitor, the user should be able search from the landing page of investor.gov.

  @ui @api @javascript @wdio
  Scenario: Global Search
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "Investor WDIO Test"
      And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "Save" button
    Then I take a screenshot on "investor" using "search.feature" file with "@error" tag
      And I take a screenshot on "investor" using "search.feature" file with "@auto_complete" tag

  @api @javascript @wdio @ui
  Scenario: Glossary Search
    Given I am logged in as a user with the "Content Approver" role
      And "glossary_term" content:
      | title           | body                  | field_alternate_name | status | moderation_state |
      | Test Glossary 1 | Behat glossary search | Alternate            | 1      | published        |
    Then I take a screenshot on "investor" using "search.feature" file with "@glossary_search" tag
