Feature: Investor Alerts And Bulletins
  As a visitor to investor.gov, user should be able to view Alerts and Bulletins

  @ui @api @javascript @wdio
  Scenario: Screenshot of News Alert Page
    Given I am logged in as a user with the "Content Approver" role
    When I visit "/node/add/news"
      And I fill in "Title" with "Investor Behat Test Alert"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Alert Stark Summary"
      And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
      And I select "Investor Alerts" from "News Type"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press "edit-submit"
    Then I take a screenshot on "investor" using "alertsbulletins.feature" file with "@alerts" tag
      And I take a screenshot on "investor" using "alertsbulletins.feature" file with "@search_alerts" tag

  @ui @api @javascript @wdio
  Scenario: Screenshot of News Bulletin Page
    Given I am logged in as a user with the "Content Approver" role
    When I visit "/node/add/news"
      And I fill in "Title" with "Investor Behat Test Bulletin"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Bulletins Drago Summary"
      And I type "Investor Behat Display Bulletin Title" in the "Body" WYSIWYG editor
      And I select "Investor Bulletins" from "News Type"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press "edit-submit"
    Then I take a screenshot on "investor" using "alertsbulletins.feature" file with "@bulletins" tag

  @ui @api @javascript @wdio
  Scenario: Screenshot of Default News Alert Breadcrumb
    Given "news" content:
      | title        | body                   | field_news_type | status | moderation_state | nid    | field_date          | field_news_category                                   |
      | News Alert 1 | body test news alert 1 | Investor Alerts | 1      | published        | 825036 | 2025-02-14T13:00:00 | Corporation Finance, Trading and Markets, Enforcement |
    When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/news-alert-1"
    Then I take a screenshot on "investor" using "alertsbulletins.feature" file with "@alerts_breadcrumb" tag
