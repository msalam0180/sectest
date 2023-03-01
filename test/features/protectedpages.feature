Feature: Protected Pages Functionality
  As a Content Manager
  I want to be able to set passwords for certain pages
  So that only certain visitors can access the content within SEC.gov

  @api @javascript
  Scenario: Validate Password Protected Pages
  Given "secarticle" content:
          | title              | field_display_title                 | body   | field_publish_date      | status |field_article_type_secarticle | field_primary_division_office |
          | Unprotected        | It's not a Protected Page           | Test 2 | 2019-02-17T17:00:00     | 1      | Other                        | Agency-Wide                   |
          | Protected Pager    | It's a Password Protected Page      | Test 1 | 2020-01-17T17:00:00     | 1      | Other                        | Agency-wide                   |
    And I am logged in as a user with the "sitebuilder" role
    And I am on "/admin/config/system/protected_pages/add"
    And I fill in "Relative Path" with "/protected-pager"
    And I fill in "Password" with "Password123!"
    And I fill in "Confirm password" with "Password123!"
    And I press the "Save" button
    And I wait for ajax to finish
    And I am on "/user/logout"
  When I am on "/unprotected"
  Then I should see the text "It's not a Protected Page"
  When I am on "/protected-pager"
  Then I should see the text "Enter Password"
    And I fill in "Enter Password" with "123!"
    And I press the "Authenticate" button
  Then I should see the text "Incorrect password!"
    And I fill in "Password" with "Password123!"
    And I press the "Authenticate" button
  Then I should see the text "It's a Password Protected Page"
    And I should see the text "Test 1"
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/config/system/protected_pages"
    And I press the "List additional actions" button
    And I click "Remove Password" in the "/protected-pager" row
    And I should see the heading "Are you sure you want to remove the password for this page?"
    And I press the "Remove Password" button
  Then I should see the text "The password has been successfully removed."
