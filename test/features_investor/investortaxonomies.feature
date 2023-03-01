Feature: Create Taxonomies
As an admin, I want to new taxonomies on drupal 8 home page

@api @investor
Scenario: Default Taxonomies
  Given I am logged in as a user with the "administrator" role
  When I am on "/admin/structure/taxonomy"
  Then I should see the text "Add vocabulary"
    And I should see the text "Glossary Term Categories"
    And I should see the text "News Types"
    And I should see the text "Publication Options"
    And I should see the text "Types of Fraud"
    And I should see the text "Tags"
    And I should see the text "Icons"
    And I should see the text "News Category"

@api @investor @javascript
Scenario: Create New Taxonomy Terms On Investor
  Given I am logged in as a user with the "administrator" role
  When I am on "/admin/structure/taxonomy/add"
    And I fill in "Name" with "BEHAT Taxonomy"
    And I wait 2 seconds
    And I press "Save"
    And I am on "/admin/structure/taxonomy/manage/behat_taxonomy/add"
    And I fill in "Name" with "BEHAT Taxonomy term"
    And I press "Save"
  When I am on "/admin/structure/taxonomy"
  Then I should see the text "behat taxonomy"

@api @javascript @investor
Scenario: Delete Taxonomy Terms On Investor
  Given I am logged in as a user with the "administrator" role
  When I am on "/admin/structure/taxonomy/add"
    And I fill in "Name" with "Delete Taxonomy"
    And I wait 2 seconds
    And I press "Save"
    And I am on "admin/structure/taxonomy/manage/delete_taxonomy/add"
    And I fill in "Name" with "BEHAT Taxonomy term"
    And I press "Save"
    And I am on "/admin/structure/taxonomy/"
  Then I should see the text "delete taxonomy"
  When I am on "/admin/structure/taxonomy/manage/delete_taxonomy/overview"
    And I click "Edit" in the "BEHAT Taxonomy term" row
    And I scroll to the bottom
    And I click "edit-delete"
    And I press "edit-submit"
  Then I should see the text "Deleted term BEHAT Taxonomy term."
