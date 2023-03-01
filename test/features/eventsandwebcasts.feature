@eventsandwebcasts
Feature: Events with Webcasts
  As a Content Creator
  I want to be able to create events with and without webcasts
  So that visitors to SEC.gov can view upcoming Events and webcasts

  @api
  Scenario: View an event with a webcast on the event list page
    Given "webcast" content:
      | title                      | field_start_date | field_end_date | field_webcast_state | status | field_webcast_src |
      | BEHAT Test Webcast Content | +1 week          | +2 weeks       | testing             | 1      | SPA               |
      And "secperson" content:
      | title       | field_first_name_secperson | field_last_name_secperson | status |
      | BEHATPerson | Person                     | Name                      | 1      |
      And "event" content:
      # | field_sec_event_date | title                    | field_event_type | body                 | field_location:country_code | :address_line1 | :administrative_area | :locality   | :postal_code | field_sec_event_end_date | field_display_title      | field_webcast              | field_person | status | moderation_state |
      # | +1 week              | BEHAT Test Event Content | meeting          | Some text goes here. | US                          | 123 Main St.   | VA                   | Springfield | 22124        | +2 weeks                 | BEHAT Test Event Content | BEHAT Test Webcast Content | BEHATPerson  | 1      | published        |
      | field_sec_event_date | title                    | field_event_type | body                 | field_sec_event_end_date | field_display_title      | field_webcast              | field_person | status | moderation_state |
      | +1 week              | BEHAT Test Event Content | meeting          | Some text goes here. | +2 weeks                 | BEHAT Test Event Content | BEHAT Test Webcast Content | BEHATPerson  | 1      | published        |
    When I visit "/news/upcoming-events"
    Then I should see the heading "SEC Meetings and Other Events"
      And I should see the link "BEHAT Test Event Content"
      And I should see the text "Some text goes here."
      # And I should see the text "Location:"
      # And I should see the text "123 Main St."
      # And I should see the text "Springfield, VA 22124"
      # And I should see the text "United States"
      And I should see the link "View Event Details ›"

  @api
  Scenario: View a webcast on the event detail page as external user
    Given "webcast" content:
      | title                      | field_start_date | field_end_date | field_webcast_state | status | field_webcast_src |
      | BEHAT Test Webcast Content | +1 week          | +2 weeks       | testing             | 1      | SPA               |
    When I am viewing an "event" content:
      | field_sec_event_date        | +1 week                    |
      | title                       | BEHAT Test Event Content   |
      | moderation_state            | published                  |
      | field_event_type            | meeting                    |
      | status                      | 1                          |
      # | field_location:country_code | US                         |
      # | :address_line1              | 123 Main St                |
      # | :administrative_area        | VA                         |
      # | :locality                   | Springfield                |
      # | :postal_code                | 22124                      |
      | field_webcast               | BEHAT Test Webcast Content |
      | field_display_title         | BEHAT Test Event Content   |
      | field_sec_event_end_date    | +2 weeks                   |
    Then I should see the heading "BEHAT Test Event Content"
      And I should see the text "This event will be webcast ("
      And the "div" element should contain "live-player hidden"

  @api @javascript
  Scenario: View a webcast on the event detail page as a logged-in user
    Given "webcast" content:
      | title                      | field_start_date | field_end_date | field_webcast_state | status | field_webcast_src |
      | BEHAT Test Webcast Content | +1 week          | +2 weeks       | testing             | 1      | SPA               |
      And I am logged in as a user with the "content_creator" role
    When I am viewing an "event" content:
      | field_sec_event_date        | +1 week                    |
      | title                       | BEHAT Test Event Content   |
      | moderation_state            | published                  |
      | field_event_type            | meeting                    |
      | status                      | 1                          |
      # | field_location:country_code | US                         |
      # | :address_line1              | 123 Main St                |
      # | :administrative_area        | VA                         |
      # | :locality                   | Springfield                |
      # | :postal_code                | 22124                      |
      | field_webcast               | BEHAT Test Webcast Content |
      | field_display_title         | BEHAT Test Event Content   |
      | field_sec_event_end_date    | +2 weeks                   |
    Then I should see the heading "BEHAT Test Event Content"
      And I should see the heading "Internal Webcast Preview"
      And I should see the text "Authenticated Drupal users will always see the live webcast stream, even before an event has started. To view the page as seen by external users, please log out of Drupal."
      And I should see a video player
      And I should see the text "This event will be webcast ("

  #Then I should see the link "BEHAT Test Webcast Content"
  # It looks like the site has changed? Now if you're logged in it shows a preview. If you're not logged in shows a line like:
  #This event will be webcast (June 19, 2019 8:00 am EDT)
  #8AM is not the time though so that's weird. Have to track that down. And probably test the view for logged in users

  @api
  Scenario: View different event types on the event list page
    Given "event" content:
      # | field_sec_event_date | title                       | field_event_type | body                       | field_location:country_code | :address_line1 | :administrative_area | :locality   | :postal_code | field_sec_event_end_date | field_display_title         | status | moderation_state |
      # | +1 week              | BEHAT Test Meeting Event    | meeting          | Some text goes here.       | US                          | 123 Main St.   | VA                   | Springfield | 22124        | +2 weeks                 | BEHAT Test Meeting Event    | 1      | published        |
      # | +4 days              | BEHAT Test Hidden Event     | hidden           | Hidden text goes here.     | US                          | 123 Main St.   | VA                   | Springfield | 22124        | +5 days                  | BEHAT Test Hidden Event     | 1      | published        |
      # | +5 days              | BEHAT Test Appearance Event | appearance       | Some other text goes here. | US                          | 123 Main St.   | VA                   | Springfield | 22124        | +6 days                  | BEHAT Test Appearance Event | 1      | published        |
      # | +6 days              | BEHAT Test Hearing          | hearing          | Other text goes here.      | US                          | 123 Main St.   | VA                   | Springfield | 22124        | +7 days                  | BEHAT Test Hearing Event    | 1      | published        |
      | field_sec_event_date | title                       | field_event_type | body                       | field_sec_event_end_date | field_display_title         | status | moderation_state |
      | +1 week              | BEHAT Test Meeting Event    | meeting          | Some text goes here.       | +2 weeks                 | BEHAT Test Meeting Event    | 1      | published        |
      | +4 days              | BEHAT Test Hidden Event     | hidden           | Hidden text goes here.     | +5 days                  | BEHAT Test Hidden Event     | 1      | published        |
      | +5 days              | BEHAT Test Appearance Event | appearance       | Some other text goes here. | +6 days                  | BEHAT Test Appearance Event | 1      | published        |
      | +6 days              | BEHAT Test Hearing          | hearing          | Other text goes here.      | +7 days                  | BEHAT Test Hearing Event    | 1      | published        |
    When I visit "/news/upcoming-events"
    Then I should see the heading "SEC Meetings and Other Events"
      And I should see the link "BEHAT Test Meeting Event"
      And I should see the text "Some text goes here."
      And I should see the heading "Public Appearances by Officials"
      And I should see the link "BEHAT Test Appearance Event"
      And I should see the text "Some other text goes here."
      And I should see the heading "Public Hearings in Administrative Proceedings"
      And I should see the link "BEHAT Test Hearing"
      And I should see the text "Other text goes here."
      And I should not see the heading "Hidden"
      And I should not see the text "BEHAT Test Hidden Event"

  @api @javascript
  Scenario: View event location on the event detail page
    Given I am logged in as a user with the "content_creator" role
      And I create "node" of type "event":
      | title                    | field_sec_event_date | moderation_state | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality  | :postal_code | field_display_title      | field_sec_event_end_date |
      | BEHAT Test Event Content | +1 week              | published        | meeting          | 1      | US                          | 100 F St NE    | DC                   | Washington | 20002        | BEHAT Test Event Content | +2 weeks                 |
    When I am logged in as a user with the "authenticated user" role
      And I visit "/news/upcoming-events/behat-test-event-content"
    Then I should see the heading "BEHAT Test Event Content"
      And I should see the text "Location"
      And I should see the text "100 F St NE"
      And I should see the text "Washington, DC 20002"
      And I should see the text "United States"
      And I should see the "img" element with the "class" attribute set to "leaflet-marker-icon leaflet-zoom-animated leaflet-interactive" in the "contentarea" region
      And I should see the "div" element with the "class" attribute set to "leaflet-container leaflet-touch leaflet-fade-anim leaflet-grab leaflet-touch-drag leaflet-touch-zoom" in the "contentarea" region

  @api @webcastalert
  Scenario: Site alert for webcast event more than 24 hours in future
    Given "webcast" content:
      | title              | field_webcast_state | field_webcast_source | field_start_date | field_end_date | status |
      | Behat test webcast | upcoming            | SPA                  | +25 hours        | +26 hours      | 1      |
      And "event" content:
      | title            | field_sec_event_date | field_show_end_date | field_event_type              | field_meeting_category | field_webcast      | status |
      | Behat test event | +25 hours            | 0                   | SEC Meetings and Other Events | Open Meeting           | Behat test webcast | 1      |
    When I visit "/"
    Then I should not see the site alert titled "Upcoming Webcast"

  @api @webcastalert
  Scenario: Site alert for upcoming webcast event less than 24 hours in future
    Given "webcast" content:
      | title              | field_webcast_state | field_webcast_source | field_start_date | field_end_date | status |
      | Behat test webcast | upcoming            | SPA                  | +12 hours        | +13 hours      | 1      |
      And "event" content:
      | title            | field_sec_event_date | field_show_end_date | field_event_type              | field_meeting_category | field_webcast      | status |
      | Behat test event | +12 hours            | 0                   | SEC Meetings and Other Events | Open Meeting           | Behat test webcast | 1      |
    When I visit "/"
    Then I should see the site alert titled "Upcoming Webcast"

  @api @webcastalert
  Scenario: Site alert for live webcast event
    Given "webcast" content:
      | title              | field_webcast_state | field_webcast_source | field_start_date | field_end_date | status |
      | Behat test webcast | live                | SPA                  | +1 hours         | +2 hours       | 1      |
      And "event" content:
      | title            | field_sec_event_date | field_show_end_date | field_event_type              | field_meeting_category | field_webcast      | status |
      | Behat test event | +1 hours             | 0                   | SEC Meetings and Other Events | Open Meeting           | Behat test webcast | 1      |
    When I visit "/"
    Then I should see the site alert titled "Happening Now"

  @api @webcastalert @javascript
  Scenario: Site alert does not include end date in link
    Given "webcast" content:
      | title              | field_webcast_state | field_webcast_source | field_start_date | field_end_date | status |
      | Behat test webcast | upcoming            | SPA                  | +12 hours        | +13 hours      | 1      |
      And "event" content:
      | title            | field_sec_event_date | field_show_end_date | field_event_type              | field_meeting_category | field_webcast      | status |
      | Behat test event | +12 hours            | 0                   | SEC Meetings and Other Events | Open Meeting           | Behat test webcast | 1      |
    When I visit "/"
    Then I should see the site alert titled "Upcoming Webcast"
      And I should not see the event end date in the site alert

  @api @webcastalert
  Scenario: Site alert includes end date in link
    Given "webcast" content:
      | title              | field_webcast_state | field_webcast_source | field_start_date | field_end_date | status |
      | Behat test webcast | upcoming            | SPA                  | +12 hours        | +13 hours      | 1      |
      And "event" content:
      | title            | field_sec_event_date | field_sec_event_end_date | field_show_end_date | field_event_type              | field_meeting_category | field_webcast      | status |
      | Behat test event | +12 hours            | +13 hours                | 1                   | SEC Meetings and Other Events | Open Meeting           | Behat test webcast | 1      |
    When I visit "/"
    Then I should see the site alert titled "Upcoming Webcast"
      And I should see the event end date in the site alert

  @api @javascript
  Scenario: View event with no location specified on the event detail page
    Given I am viewing an "event" content:
      | field_sec_event_date     | +1 week                  |
      | title                    | BEHAT Test Event Content |
      | moderation_state         | published                |
      | field_event_type         | meeting                  |
      | status                   | 1                        |
      | field_display_title      | BEHAT Test Event Content |
      | field_sec_event_end_date | +2 weeks                 |
    When I visit "/news/upcoming-events/behat-test-event-content"
    Then I should see the heading "BEHAT Test Event Content"
      And I should not see the "div.leaflet-pane.leaflet-map-pane" element in the "contentarea" region

  @api @javascript
  Scenario: Create Event With No Location
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/event"
      And I fill in "Title" with "Simple Test Event"
      And I fill in "Display Title" with "simple test event"
      And I type "Please Join Us!" in the "Body" WYSIWYG editor
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Open Meeting" from "Meeting Category"
      And I type "John Jackson" in the "Contact" WYSIWYG editor
      And I publish it
    Then I should see the heading "Simple Test Event"
      And I should see the text "Please Join Us!"
      And I should see the text "John Jackson"
      And I should not see the "div.leaflet-pane.leaflet-map-pane" element in the "contentarea" region

  @api @javascript
  Scenario: Create And Edit An Event With DatePicker
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/event"
      And I fill in "Title" with "Event With Date"
      And I fill in "Display Title" with "Event Date"
      And I fill in the following:
        | field_sec_event_date[0][value][date]     | 11-15-2020 |
        | field_sec_event_date[0][value][time]     | 10:00:00AM |
        | field_sec_event_end_date[0][value][date] | 11-16-2020 |
        | field_sec_event_end_date[0][value][time] | 06:00:00PM |
      And I type "This is the body of the event" in the "Body" WYSIWYG editor
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Open Meeting" from "Meeting Category"
      And I publish it
    Then I should see the heading "Event Date"
      And I should see the text "Nov. 15, 2020 | 10:00 am ET"
    When I am on "/admin/content"
      And I click "Edit" in the "Event With Date" row
      And I fill in the following:
        | field_sec_event_date[0][value][date]     | 11-18-2020 |
        | field_sec_event_date[0][value][time]     | 08:00:00AM |
        | field_sec_event_end_date[0][value][date] | 11-20-2020 |
        | field_sec_event_end_date[0][value][time] | 05:00:00PM |
      And I publish it
    Then I should see the heading "Event Date"
      And I should see the text "Nov. 18, 2020 | 8:00 am ET"
      And I should not see the text "Nov. 15, 2020 | 10:00 am ET"

  @api
  Scenario: Events Show Add to Calendar Functionality Is Checked By Default
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/event"
    Then the "field_add_to_calendar[0][value]" checkbox should be checked

  @api @javascript
  Scenario Outline: Enable or Disable Add to Calendar in an Event
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/event"
      And I fill in "Title" with "Behat Test Event"
      And I fill in "Display Title" with "simple test event"
      And I <action> the box "Show add to calendar widget"
      And I type "Please Join Us!" in the "Body" WYSIWYG editor
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Open Meeting" from "Meeting Category"
      And I type "John Jackson" in the "Contact" WYSIWYG editor
      And I publish it
    Then I should see the heading "Simple Test Event"
      And I should <result> the css selector "div.event_add_cal"

      Examples:
        | action  | result  |
        | check   | see     |
        | uncheck | not see |

  @api @javascript
  Scenario Outline: Verify Event End Date Is Not Earlier Than Start Date
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/node/add/event"
      And I fill in "Title" with "Event With Date"
      And I fill in "Display Title" with "Event Date"
      And I fill in the following:
        | field_sec_event_date[0][value][date]     | 11-15-2020 |
        | field_sec_event_date[0][value][time]     | 11:30:00PM |
        | field_sec_event_end_date[0][value][date] | <end_date> |
        | field_sec_event_end_date[0][value][time] | <end_time> |
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Open Meeting" from "Meeting Category"
      And I press "Save and Create New Draft"
    Then I should see the text "SEC Event End Date field cannot have a value eariler than SEC Event Date field."

    Examples:
      | end_date   | end_time   |
      | 11-14-2020 | 11:30:00PM |
      | 11-15-2019 | 11:30:00PM |
      | 11-15-2020 | 11:29:00PM |

  @api @javascript
  Scenario Outline: Events appear as ET on upcoming events
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/event"
      And I fill in "Title" with "Behat Test Event"
      And I fill in "Display Title" with "simple test event"
      And I fill in the following:
        | field_sec_event_date[0][value][date]     | <start_date> |
        | field_sec_event_date[0][value][time]     | <start_time> |
        | field_sec_event_end_date[0][value][date] | <end_date>   |
        | field_sec_event_end_date[0][value][time] | <end_time>   |
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Open Meeting" from "Meeting Category"
      And I publish it
    Then I should see the text "<verify_date>"
      And I should see the text "<verify_time>"
    When I am on "news/upcoming-events"
    Then I should see the text "simple test event"
      And I should see the text "<verify_date>"
      And I should see the text "<verify_time>"

    Examples:
      | start_date | start_time | end_date   | end_time   | verify_date   | verify_time |
      | 11-10-2025 | 11:00:00PM | 11-11-2025 | 11:00:00PM | NOV. 10, 2025 | 11:00 PM ET |
      | 06-10-2025 | 11:00:00PM | 06-11-2025 | 11:00:00PM | June 10, 2025 | 11:00 PM ET |

  @api
  Scenario Outline: Webcast events appear as ET on upcoming events
    Given "webcast" content:
      | title         | field_display_title   | field_start_date | field_end_date | body 				           | field_webcast_state | field_webcast_src | moderation_state |
      | webcast title | webcast display title | <start_date>     | +3 hours 	    | This is the body field | upcoming 		       | MPR          	   | published        |
      And "event" content:
        # | title       	       | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code	| field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
        # | behat webcast events | meeting 		      | 1	     | US			                     | 123 Main St	  | VA		    	         | Arlington | 22204	      | webcast title | <start_date>	       | +3 hours			            | published        |
        | title       	       | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
        | behat webcast events | meeting 		      | 1	     | webcast title | <start_date>	        | +3 hours			           | published        |
    When I am on "/news/upcoming-events/behat-webcast-events"
    Then I should not see the text " <tz_abv>"

    Examples:
      | start_date | tz_abv |
      | 05-12-2025 | EST    |
      | 05-07-2025 | EDT    |

  @api
  Scenario: Summary Field Teaser Display On Upcoming Events
    Given "event" content:
      | title               | field_event_type | status | field_sec_event_date | field_sec_event_end_date | moderation_state |
      | behat event summary | meeting          | 1      | 05-07-2030           | 05-08-2030               | published        |
    When I am logged in as a user with the "Content Approver" role
      And I am on "/news/upcoming-events/behat-event-summary/edit"
      And I fill in "Summary" with "Stop the madness"
      And I publish it
      And I am not logged in
      And I visit "/news/upcoming-events"
    Then I should see the text "Stop the madness"
    When I click "View Event Details"
    Then I should see the text "Behat Event Summary"
      And I should not see the text "Stop the madness"

  @api
  Scenario: Summary and Body Teaser Display On Upcoming Events
    Given "event" content:
      | title               | field_event_type | status | field_sec_event_date | field_sec_event_end_date | moderation_state | body        |
      | behat event summary | meeting          | 1      | 05-07-2030           | 05-08-2030               | published        | No More War |
    When I am on "/news/upcoming-events/behat-event-summary"
    Then I should see the text "No More War"
    When I visit "/news/upcoming-events"
    Then I should see the text "No More War"
    When I am logged in as a user with the "Content Approver" role
      And I am on "/news/upcoming-events/behat-event-summary/edit"
    #If both Summary and Body are provided, Upcoming Events will use Summary text
      And I fill in "Summary" with "Can't we all just get along?"
      And I publish it
      And I am not logged in
      And I visit "/news/upcoming-events"
    Then I should see the text "Can't we all just get along?"
      And I should not see the text "No More War"
    When I click "View Event Details"
    #If Summary and Body are provided, Event Details page should still use Body text
    Then I should see the text "No More War"
    When I am logged in as a user with the "Content Approver" role
      And I am on "/news/upcoming-events/behat-event-summary/edit"
    #If Summary is empty, Upcoming Events will use Body text
      And I fill in "Summary" with ""
      And I publish it
      And I am not logged in
      And I visit "/news/upcoming-events/behat-event-summary"
    Then I should see the text "No More War"
    When I visit "/news/upcoming-events"
    Then I should not see the text "Can't we all just get along?"
      And I should see the text "No More War"
