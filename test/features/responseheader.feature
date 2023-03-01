Feature: Check for Pragma and Cache-Control Response Headers
  As a site administrator
  I want to check that the Pragma and Cache-Control Response Headers are not installed on the site
  So that the site doesn't break on prod

@api
Scenario: Verify that cache-control and pragma response headers are not installed on the site
  Given I am logged in as a user with the "administrator" role
  When I visit "admin/config/system/response-headers"
  Then I should not see the text "Cache-Control"
    And I should not see the text "cache-control"
    And I should not see the text "Pragma"
    And I should not see the text "pragma"

@api
Scenario: Verify that pragma response header is not returned by the server
  Given I run drush "cr"
  When I am on page "/"
    And I reload the page
  Then the "Pragma" response header does not exist
    And the "pragma" response header does not exist

@api
Scenario: Verify that pragma response header is not returned on prod site
  Given I am on page "https://www.sec.gov"
    And I reload the page
  Then the "Pragma" response header does not exist
    And the "pragma" response header does not exist
