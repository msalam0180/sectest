Feature: Pagination on search results pages
  As a Site Visitor, the user should be able to see pagination on the search results page if more than 10 results available

@api @javascript @investor
Scenario: Pagination for Less than 10 Items
  Given I am logged in as a user with the "Content Approver" role
    And "article" content:
      | title                             | body    | status | moderation_state |
      | Apple Behat E&D Test Article      | Fruit1  | 1      | published        |
      | Banana Behat E&D Test Article     | Fruit2  | 1      | published        |
      | Orange Behat E&D Test Article     | Fruit3  | 1      | published        |
      | Pear Behat E&D Test Article       | Fruit4  | 1      | published        |
      | Plum Behat E&D Test Article       | Fruit5  | 1      | published        |
      | Peach Behat E&D Test Article      | Fruit6  | 1      | published        |
      | Papaya Behat E&D Test Article     | Fruit7  | 1      | published        |
      | Grapes Behat E&D Test Article     | Fruit8  | 1      | published        |
      | Watermelon Behat E&D Test Article | Fruit9  | 1      | published        |
      | Dates Behat E&D Test Article      | Fruit10 | 1      | published        |
    And I run cron
  When I am on "/"
    And I fill in "Search Investor.gov" with "Fruit"
    And I click on the element with css selector "#edit-submit-search-content"
  Then I should not see the link "Next ›"
    And I should not see the link "Last ››"
    And I wait 1 seconds
  When I am on "/"
    And I fill in "Search Investor.gov" with "Fruit2"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the text "1 - 1 of 1"
    And I should not see the link "Next ›"
    And I should not see the link "Last ››"

@api @javascript @investor
Scenario: Pagination with more than 10 Items
  Given I am logged in as a user with the "Content Approver" role
    And "article" content:
      | title                             | body    | status | moderation_state |
      | Apple Behat E&D Test Article      | Fruit1  | 1      | published        |
      | Banana Behat E&D Test Article     | Fruit2  | 1      | published        |
      | Orange Behat E&D Test Article     | Fruit3  | 1      | published        |
      | Pear Behat E&D Test Article       | Fruit4  | 1      | published        |
      | Plum Behat E&D Test Article       | Fruit5  | 1      | published        |
      | Peach Behat E&D Test Article      | Fruit6  | 1      | published        |
      | Papaya Behat E&D Test Article     | Fruit7  | 1      | published        |
      | Grapes Behat E&D Test Article     | Fruit8  | 1      | published        |
      | watermelon Behat E&D Test Article | Fruit9  | 1      | published        |
      | Berry Behat E&D Test Article      | Fruit10 | 1      | published        |
      | BBerry Behat E&D Test Article     | Fruit11 | 1      | published        |
    And I run cron
  When I am on "/"
    And I fill in "Search Investor.gov" with "Fruit"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Next ›" in the "search_pagination" region
    And I should see the link "Last ››" in the "search_pagination" region
    And I wait 1 seconds
    And I should see the link "2" in the "search_pagination" region
    And I click "Next ›" in the "search_pagination" region
    And I should see the text "Displaying results 11 - 11 of 11"
  Then I should see the link "‹ Previous" in the "search_pagination" region
    And I should see the link "‹‹ First" in the "search_pagination" region
    And I should see the link "1" in the "search_pagination" region

@api @javascript @investor
Scenario Outline: Investor Return To Top
  Given I am on "<link>"
    And I should not visibly see the link "Return to Top"
  When I scroll to the bottom
  Then I should see the link "Return to Top"
  When I click "Return to Top"
    And I wait 2 seconds
  Then I should not visibly see the link "Return to Top"

  Examples:
    | link                                                                  |
    | /                                                                     |
    | /financial-tools-calculators/calculators/compound-interest-calculator |
    | /financial-tools-calculators/calculators/savings-goal-calculator      |
    | /financial-tools-calculators/calculators/savings-goal-calculator      |
    | /introduction-investing                                               |
    | /protect-your-investments                                             |
    | /additional-resources                                                 |
    | /about-us                                                             |
    | /free-financial-planning-tools                                        |
    | /introduction-investing/investing-basics/glossary                     |
