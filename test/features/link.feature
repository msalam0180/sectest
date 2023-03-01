Feature: Link Content
  As a content creator
  I need to be able to create link content in Drupal
  So that I can add links to content residing elsewhere on SEC.gov

@api @link @javascript
Scenario: Create topical reference guide link
  Given I am logged in as a user with the "content_creator" role
  When I am on "/node/add/link"
    And I fill in "Title" with "TRG Link"
    And I fill in "URL" with "/divisions/investment/icvaluation.htm"
    And I fill in "Link text" with "TRG Link"
    And I select "Accounting and Auditing" from "Topic"
    And I select "Forms" from "SubTopic"
    And I publish it
  Then I should be on "/divisions/investment/icvaluation.htm"

@api @javascript
Scenario: Content Creator able to edit and publish previously saved link nodes
  Given I am logged in as a user with the "content_creator" role
  When I am on "/node/add/link"
    And I fill in "Title" with "Investor Homepage"
    And I fill in "URL" with "https://www.investor.gov"
    And I fill in "Link text" with "Investor Website"
    And I scroll to the bottom
    And I press the "List additional actions" button
    And I press the "Save and Unpublish" button
  Then I should be on "https://www.investor.gov"
  When I visit "/admin/content/search"
    And I click "Edit" in the "Investor Homepage" row
    And I scroll to the bottom
    And I press the "List additional actions" button
  Then I should see the "Save and Re-publish" button
    And I should see the "Save and Keep Unpublished" button

@api @javascript
Scenario: Content Creator able to Edit and Re-publish Previously Published link nodes
  Given I am logged in as a user with the "content_creator" role
  When I am on "/node/add/link"
    And I fill in "Title" with "Investor Homepage"
    And I fill in "URL" with "https://www.investor.gov"
    And I fill in "Link text" with "Investor Website"
    And I scroll to the bottom
    And I publish it
  Then I should be on "https://www.investor.gov"
  When I visit "/admin/content/search"
    And I click "Edit" in the "Investor Homepage" row
    And I scroll to the bottom
    And I press the "List additional actions" button
  Then I should see the "Save and Publish" button
    And I should see the "Save and Unpublish" button

@api @javascript
Scenario: Content Creator able to Edit existing link node Publish
  Given "link" content:
      | title           | field_url                          | field_topics            | field_subtopic | field_primary_division_office | status | moderation_state | field_publish_date  |
      | TRG TEST Link 1 | SEC Link - https://www.sec.gov     | Accounting and Auditing | Forms          | Investment Management         | 1      | published        | 2018-09-11 12:00:00 |
      | TRG TEST Link 2 | Apple Link - https://www.apple.com | Anti-Money Laundering   | Rulemaking     | Investment Management         | 0      | archived         | 2018-05-11 08:00:00 |
    And I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I click "Edit" in the "TRG TEST Link 2" row
    And I scroll to the bottom
    And I press the "List additional actions" button
  Then I should see the "Save and Re-publish" button
    And I should see the "Save and Keep Unpublished" button
  When I visit "/admin/content/search"
    And I click "Edit" in the "TRG TEST Link 1" row
    And I scroll to the bottom
    And I press the "List additional actions" button
  Then I should see the "Save and Publish" button
    And I should see the "Save and Unpublish" button
