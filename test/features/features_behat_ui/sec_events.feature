Feature: Event Content Type
  As a Site Visitor, the user should be able to view upcoming events on SEC.gov

@ui @api @javascript @wdio
Scenario: Add Calendar File to Event
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/event"
    And I fill in "Title" with "Community-Based Fraud During COVID-19"
    And I fill in "Display Title" with "Community-Based Fraud During COVID-19"
    And I check the box "Show add to calendar widget"
    And I fill in the following:
      | field_sec_event_date[0][value][date]     | 11-15-2025 |
      | field_sec_event_date[0][value][time]     | 10:00:00AM |
      | field_sec_event_end_date[0][value][date] | 11-15-2025 |
      | field_sec_event_end_date[0][value][time] | 12:00:00PM |
    And I type "Please Join Us!" in the "Body" WYSIWYG editor
    And I select "SEC Meetings and Other Events" from "Event Type"
    And I select "Open Meeting" from "Meeting Category"
    And I type "Karen McKenzie" in the "Contact" WYSIWYG editor
    And I publish it
  Then I take a screenshot on "sec" using "events.feature" file with "@add_calendar" tag
