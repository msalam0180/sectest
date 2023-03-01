Feature: Test Article Type Content Type
  As an Admin
  I want to be able to create Article Type content
  So that visitors to SEC.gov can learn about the Article Type

@api @javascript
Scenario: Create Article Type Content Through the UI
  Given I am logged in as a user with the "Administrator" role
  When I visit "/node/add/article_type"
    And I fill in "Article Type Test" for "Title"
    And I type "This is the body" in the "Body" WYSIWYG editor
    And I press the "Save" button
  Then I should see the text "This is the body"

@api @javascript @Negative
Scenario: Create Negative Article Type Content Through the UI
  Given I am logged in as a user with the "Administrator" role
  When I visit "/node/add/article_type"
    And I type "This is the body" in the "Body" WYSIWYG editor
    And I press the "Save" button
  Then I should not see the text "This is the body"

@api @javascript
Scenario: Deleted Article Type Does Not Display in Article Dropdown
  Given I am logged in as a user with the "Administrator" role
    And I am viewing a "article_type" content:
     | title                                  | Article Type Test 1 |
     | body                                   | Article Test        |
  When I visit "admin/workbench/content/all"
    And I click "edit" in the "Article Type Test 1" row
    And I click "edit-delete"
    And I press the "Delete" button
    And I visit "/node/add/secarticle"
  Then the "select" element should not contain "Article Type Test 1"

@api @javascript
Scenario: Article Type Displays in a Article Dropdown
  Given I am logged in as a user with the "content_creator" role
    And I am viewing a "article_type" content:
      | title                                          | Article Type Test |
      | body                                           | Article Test      |
    And I visit "/node/add/secarticle"
  Then the "select" element should contain "Article Type Test"

@api
Scenario: Viewing an Article Type
  Given I am logged in as a user with the "content_creator" role
    And I am viewing a "article_type" content:
      | title                                          | Article Type Test |
      | body                                           | Article Test      |
  Then I should see the text "Article Test"
