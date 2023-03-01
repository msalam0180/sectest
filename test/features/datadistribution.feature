Feature: Data Distribution Content Type
  As a Content Creator
  I want to be able to create data distributions
  So that visitors to SEC.gov can learn about the secgov

  @api @javascript
  Scenario: Test The Ability To Create Data Distribution
    Given "division_office" terms:
      | name         | field_abbreviated |
      | Behat Office | bht               |
      And "tags" terms:
      | name  |
      | bingo |
      And "secarticle" content:
      | title              | field_display_title | body          | field_description_abstract | changed | status | field_article_type_secarticle | field_article_sub_type_secart | field_primary_division_office | field_publish_date  | field_date | field_tags | field_contact_email | field_contact_name |
      | Behat Test Article | Green Energy Data   | body of water | associate this article     | now     | 1      | Data                          | Data-PublicCompanies          | Behat Office                  | 2020-12-30 12:00:00 | now        | bingo      | behat@test.com      | joe smith          |
      And I am logged in as a user with the "content_creator" role
    When I am on "/node/add/data_distribution"
      And I fill in "Title" with "This Data Distribution"
      And I fill in "Display Title" with "this dd"
      And I attach the file "behat-dist-file.csv" to "File Upload"
      And I select the first autocomplete option for "Behat Test Article" on the "Associated Dataset" field
      And I fill in the following:
      | field_publish_date[0][value][date] | 11-01-2020 |
      | field_publish_date[0][value][time] | 13:00:00PM |
      And I press "Save and Create New Draft"
    Then I should see the text "this dd"
      And I should see the text "File Upload"
      And I should see the link "behat-dist-file.csv"
      And the hyperlink "behat-dist-file.csv" should match the Drupal url "/files/bht/data/public-companies/green-energy-data/behat-dist-file.csv"
      And I should see the text "Associated Dataset"
      And I should see the link "Behat Test Article"
      And the hyperlink "Behat Test Article" should match the Drupal url "/bht/data/public-companies/behat-test-article"

  @api
  Scenario: Validate Required Fields for Data Distribution
    Given I am logged in as a user with the "content_creator" role
    When I am on "/node/add/data_distribution"
      And I fill in "Title" with "This Data Distribution"
      And I fill in "Display Title" with "this dd"
      And I press "Save and Create New Draft"
    Then I should not see the text "Submitted by"
