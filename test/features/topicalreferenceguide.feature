@trg
Feature: Create and View Topical Reference Guide links
  As a content creator user
  I want to be able to create topical reference guide links in Drupal
  So that I can see the link on the Topical Reference Guide view on SEC.gov

@api @link @javascript
Scenario: Create Topical Reference Guide Link
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/link"
    And I fill in "Title" with "TRG TEST: Link to News Media Gallery"
    And I fill in "URL" with "/news/media-gallery"
    And I fill in "Link text" with "TRG TEST: Link to News Media Gallery"
    And I select "Accounting and Auditing" from "Topic"
    And I select "Forms" from "SubTopic"
    And I select "Investment Management" from "Primary Division/Office"
    And I publish it
  Then I should be on "/news/media-gallery"
  When I am not logged in
    And I visit "/divisions/investment/topical-reference-guide"
  Then I should see the heading "Topical Reference Guide"
    And I should see the link "TRG TEST: Link to News Media Gallery"
    And I should see the text "Forms" in the "TRG TEST: Link to News Media Gallery" row

@api @javascript
Scenario: View the IM Topical Reference Guide List Page
  Given "tags" terms:
      | name   |
      | behat  |
      | wdio   |
      | jira   |
      | rocket |
    And "link" content:
      | title           | field_url                                | field_topics            | field_subtopic         | field_primary_division_office | status | moderation_state | field_publish_date  | field_tags |
      | TRG TEST Link 1 | SEC Link - https://www.sec.gov           | Accounting and Auditing | Forms                  | Investment Management         | 1      | published        | 2018-09-11 12:00:00 | behat      |
      | TRG TEST Link 2 | Google Link - https://www.google.com     | Cybersecurity           | Resources              | Investment Management         | 1      | published        | 2018-07-11 16:00:00 | jira       |
      | TRG TEST Link 3 | Apple Link - https://www.apple.com       | Anti-Money Laundering   | Rulemaking             | Investment Management         | 0      | draft            | 2018-05-11 08:00:00 |            |
      | TRG TEST Link 4 | IBM Link - https://www.ibm.com           | Accounting and Auditing | Exemptive Applications | Investment Management         | 1      | published        | 2019-09-09 08:00:00 | rocket     |
      | TRG TEST Link 5 | Facebook Link - https://www.facebook.com | Cybersecurity           | Resources              | Investment Management         | 1      | published        | 2017-08-12 16:00:00 |            |
      | TRG TEST Link 6 | Netflix Link - https://www.netflix.com   | Cybersecurity           | Rulemaking             | Investment Management         | 1      | published        | 2016-04-19 16:00:00 | wdio       |
  When I am on "/divisions/investment/topical-reference-guide"
  Then I should see the heading "Investment Management"
    #list view should display link to link content with field_url title
    And I should see the link "SEC Link"
    And I should see the link "Google Link"
    And I should see the link "IBM Link"
    And I should see the link "Facebook Link"
    And I should see the link "Netflix Link"
    #list view should not display draft items
    And I should not see the link "Apple Link"
    #list view should display subtopic/type
    And I should see the text "Forms" in the "SEC Link" row
    And I should see the text "Resources" in the "Google Link" row
    And I should see the text "Exemptive Applications" in the "IBM Link" row
    And I should see the text "Resources" in the "Facebook Link" row
    And I should see the text "Rulemaking" in the "Netflix Link" row
    #list view should display the publish date
    And I should see the date "2018-09-11 12:00:00" in the "SEC Link" row
    And I should see the date "2018-07-11 16:00:00" in the "Google Link" row
    And I should see the date "2019-09-09 08:00:00" in the "IBM Link" row
    And I should see the date "2017-08-12 16:00:00" in the "Facebook Link" row
    And I should see the date "2016-04-19 16:00:00" in the "Netflix Link" row
    And I should see the text "1 to 5 of 5 items"
    #Filter for title
  When I fill in "edit-field-url-title" with "Goo"
  Then I should see the text "Resources" in the "Google Link" row
    And I should see the text "1 to 1 of 1 items"
    And I click on the element with css selector "#edit-reset"
    #Filter for year
  When I select "2019" from "Year"
    And I wait 1 seconds
  Then I should see the link "IBM Link"
    And I should not see the link "Google Link"
    And I should not see the link "SEC Link"
    And I should not see the link "Facebook Link"
    And I should not see the link "Netflix Link"
    And I should see the text "1 to 1 of 1 items"
    And I click on the element with css selector "#edit-reset"
    #Filter for Topics
  When I select "Accounting and Auditing" from "Topics"
    And I wait 1 seconds
  Then I should see the link "IBM Link"
    And I should see the link "SEC Link"
    And I should not see the link "Google Link"
    And I should not see the link "Facebook Link"
    And I should not see the link "Netflix Link"
    And I should see the text "1 to 2 of 2 items"
  When I click on the element with css selector "#edit-reset"
    #Filter for Type
    And I select "Resources" from "Type"
    And I wait 1 seconds
  Then I should see the link "Google Link"
    And I should see the link "Facebook Link"
    And I should not see the link "Netflix Link"
    And I should not see the link "IBM Link"
    And I should not see the link "SEC Link"
    And I should see the text "1 to 2 of 2 items"
    And I click on the element with css selector "#edit-reset"
    #Title sorting ascending
  When I click the sort filter "Title"
  Then "IBM Link" should precede "SEC Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "SEC Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Facebook Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Google Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    #Title sorting descending
  When I click the sort filter "Title"
  Then "SEC Link" should precede "IBM Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "IBM Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Netflix Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Google Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And I click on the element with css selector "#edit-reset"
    #Type sorting ascending
  When I click the sort filter "Type"
  Then "IBM Link" should precede "SEC Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "SEC Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Google Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Facebook Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    #Type sorting descending
  When I click the sort filter "Type"
  Then "SEC Link" should precede "IBM Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "IBM Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Netflix Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Google Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And I click on the element with css selector "#edit-reset"
    #Withdrawn sorting ascending (currently breaks due to defect OSSS-12717)
#  When I click the sort filter "Withdrawn"
#  Then "SEC Link" should precede "IBM Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "IBM Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "Facebook Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "Google Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    #Withdrawn sorting descending
#  When I click the sort filter "Withdrawn"
#  Then "SEC Link" should precede "IBM Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "IBM Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "Netflix Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And "Google Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
#    And I click on the element with css selector "#edit-reset"
    #Last Updated sorting ascending
  When I click the sort filter "Last Updated"
  Then "SEC Link" should precede "IBM Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "IBM Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Netflix Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Facebook Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    #Last Updated sorting descending
  When I click the sort filter "Last Updated"
  Then "IBM Link" should precede "SEC Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "SEC Link" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Google Link" should precede "Facebook Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
    And "Facebook Link" should precede "Netflix Link" for the query "//td[contains(@class, 'views-field views-field-field-url')]"
