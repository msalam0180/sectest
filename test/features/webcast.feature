Feature: Create and Associate Webcasts
  As a Content Creator
  I want to be able to create a webcast and associate it to an event
  So that visitors to SEC.gov can view an upcoming webcast on an event

  @api @javascript
  Scenario: Embed an entity
    Given "webcast" content:
      | title            | field_display_title | field_start_date | field_end_date | field_media_id | field_webcast_running_time | field_webcast_src | moderation_state |
      | embedded webcast | embedded Webcast1   | +24 hours        | +25 hours      |                | 2:00                       | MPR               | published        |
      And I am logged in as a user with the "content_creator" role
    When I am on "/node/add/event"
      And I press the "Embed" button
      And I wait for Ajax to finish
      And I select the first autocomplete option for "embedded webcast" on the "entity_id" field
      And I wait for Ajax to finish
      And I click Next on the modal "Select content to embed"
      And I click Embed on the modal "Embed content"

  @api @javascript
  Scenario: Display an event with a live webcast
    Given "webcast" content:
      | title         | field_display_title     | field_start_date | field_end_date | field_webcast_running_time | field_webcast_src | moderation_state | field_webcast_state |
      | behat webcast | Webcast's display title | +1 hour          | +2 hours       |                            | MPR               | published        | live                |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content |
      | moderation_state            | published                |
      | field_event_type            | meeting                  |
      | status                      | 1                        |
      # | field_location:country_code | US                       |
      # | :address_line1              | 123 Main St              |
      # | :administrative_area        | VA                       |
      # | :locality                   | Springfield              |
      # | :postal_code                | 22124                    |
      | field_webcast               | behat webcast            |
      | field_display_title         | BEHAT Test Event Content |
      | field_sec_event_date        | +1 hour                  |
      | field_sec_event_end_date    | +2 hours                 |
      And I wait for Ajax to finish
    Then I should see the text "Webcast's display title"
      And I should see the text "BEHAT Test Event Content"
      And I should see a video player

  @api
  Scenario: Display an event with an archived webcast
    Given "webcast" content:
      | title         | field_display_title     | field_start_date | field_end_date | field_webcast_running_time | field_webcast_src | moderation_state | field_webcast_state | field_media_id                   |
      | behat webcast | Webcast's display title | -8 hour          | -5 hours       |                            | MPR               | published        | ended               | 2f58b428db894840b52a6b4182785e47 |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content |
      | moderation_state            | published                |
      | field_event_type            | meeting                  |
      | status                      | 1                        |
      | field_webcast               | behat webcast            |
      | field_display_title         | BEHAT Test Event Content |
      | field_sec_event_date        | -8 hour                  |
      | field_sec_event_end_date    | +2 hours                 |
    Then I should see the text "Webcast's display title"

  @api
  Scenario: The display of an event with multiple webcasts associated
    Given "webcast" content:
      | title            | field_display_title    | field_start_date | field_end_date | field_media_id | field_webcast_running_time | field_webcast_src | moderation_state |
      | webcast's title1 | webcast display title1 | +1 hour          | +4 hours       |                | 1 h 30 min                 | MPR               | published        |
      | webcast's title2 | webcast display title2 | +1 hour          | +4 hours       |                | 1 h 30 min                 | MPR               | published        |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content           |
      | moderation_state            | published                          |
      | field_event_type            | meeting                            |
      | status                      | 1                                  |
      # | field_location:country_code | US                                 |
      # | :address_line1              | 123 Main St                        |
      # | :administrative_area        | VA                                 |
      # | :locality                   | Springfield                        |
      # | :postal_code                | 22124                              |
      | field_webcast               | webcast's title1, webcast's title2 |
      | field_display_title         | BEHAT Test Event Content           |
      | field_sec_event_date        | 2017-06-01 12:00:00                |
      | field_sec_event_end_date    | 2017-06-02 12:00:00                |
    Then I should see the text "webcast display title1"
      And I should see the text "webcast display title2"

  @api
  Scenario: Various Displays of an Upcoming Webcast
    Given "webcast" content:
      | title         | field_display_title   | body               | field_start_date | field_end_date | field_webcast_running_time | field_webcast_src | moderation_state |
      | webcast title | Webcast display title | webcast body field | +1 hour          | +4 hours       |                            | MPR               | published        |
      And "event" content:
      # | title             | field_display_title | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      # | event detail page | event display title | meeting          | 1      | US                          | 123 Main St    | VA                   | Arlington | 22204        | webcast title | +1 hour              | +4 hours                 | published        |
      | title             | field_display_title | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      | event detail page | event display title | meeting          | 1      | webcast title | +1 hour              | +4 hours                 | published        |
    When I visit "/news/upcoming-events/"
    Then I should see the link "event display title"
    When I visit "/news/upcoming-events/event-detail-page"
    Then I should see the text "Webcast display title"

  @api
  Scenario: Display of Happening Now Webcast Banner
    Given "webcast" content:
     | title         | field_display_title   | field_start_date | field_end_date | body 				          | field_webcast_state | field_webcast_src | moderation_state |
  	 | webcast title | webcast display title | now              | + 3 hours 	   | This is the body field | live 		            | MPR            	  | published        |
      And "event" content:
      #  | title       	     | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
  	  #  | event detail page | meeting 		      | 1	     | US			                     | 123 Main St	  | VA		    	         | Arlington | 22204	      | webcast title | now				           | +3 hours			            | published        |
       | title       	     | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
  	   | event detail page | meeting 		      | 1	     | webcast title | now				          | +3 hours			           | published        |
    When I am on "/news/upcoming-events/"
    Then I should see the text "Happening now"
      And I should see the link "webcast display title"
      And I should not see the text "This is the body field"
    When I am on the homepage
    Then I should see the text "Happening Now"
      And I should see the link "event detail page"

  @api
  Scenario: Display of Happening Now On Homepage When Webcast Goes From Testing To Live
    Given "webcast" content:
      | title         | field_display_title   | field_start_date | field_end_date | body 				           | field_webcast_state | field_webcast_src | moderation_state |
      | webcast title | webcast display title | now              | + 3 hours 	    | This is the body field | testing 		         | MPR        	     | published        |
      And "event" content:
        # | title       	    | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
        # | event detail page | meeting 		     | 1	    | US			                    | 123 Main St	   | VA		    	          | Arlington | 22204	       | webcast title | now				          | +3 hours			           | published        |
        | title       	    | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
        | event detail page | meeting 		     | 1	    | webcast title | now				           | +3 hours			            | published        |
    When I am on the homepage
    Then I should see the text "Upcoming Webcast"
      And I should see the link "event detail page"
    When I am logged in as a user with the "content_approver" role
      And I am on "/webcast/webcast-title/edit"
      And I select "live" from "Webcast State"
      And I publish it
      And I am not logged in
      And I am on the homepage
    Then I should see the text "Happening now"
      And I should see the link "event detail page"

  @api
  #Display of Happening webcast banner cannot be tested using behat right now as it will require manually adding in the the Upcoming Event block. We will wait for that to go live then turn on this test.
  Scenario: When I select the live state of a webcast, I want to be able to visit an event detail page and see the webcast
  Given "webcast" content:
     | title                | field_display_title		        | field_start_date | field_end_date| field_media_id | field_webcast_running_time | field_webcast_src | field_webcast_state | moderation_state |
     | Display Live webcast | display title of live webcast | now		       		 | +3 hours      |      	        |                            | MPR         	     | live                | published        |
    And "event" content:
      # | title         		                   | field_display_title | field_event_type | status | field_location:country_code| :address_line1 | :administrative_area | :locality | :postal_code  | field_webcast        | field_sec_event_date | field_sec_event_end_date | moderation_state|
      # | display webcast without page refresh | event display title | meeting          | 1	     | US			                    | 123 Main St	   | VA		                | Arlington | 22204	        | Display live webcast | now				          | +3 hours  			         | published       |
      | title         		                   | field_display_title | field_event_type | status | field_webcast        | field_sec_event_date | field_sec_event_end_date | moderation_state|
      | display webcast without page refresh | event display title | meeting          | 1	     | Display live webcast | now				           | +3 hours  			          | published       |
  When I visit "/news/upcoming-events/display-webcast-without-page-refresh"
    And I wait 1 seconds
  Then I should see the text "display title of live webcast"
  When I visit "/news/upcoming-events/"
  Then I should see the text "Happening now"
    And I should see the link "event display title"
    And the "div" element should contain "views-element-container block alert-box webcast notice live_upcoming_webcasts-block_1"

  # @api @javascript
  # #Is this still a valid use case? It will error out in escgov.theme because the webcast is blank
  # Scenario: Be able to create an event which doesn't have a webcast, and have the ability to display the event on webcast list page
  #  Given "event" content:
  #    | title      |field_display_title | field_event_type | status | field_location:country_code| :address_line1 | :administrative_area | :locality | :postal_code	| field_no_webcast_archive | field_sec_event_date | field_sec_event_end_date | moderation_state|
  # 	 | Event title| event display title| meeting          |  1	    | US                         | 123 Main St	  | VA		    	         | Arlington | 22204	      | 1                        | now				          | +3 hours			           | published       |
  #  When I visit "/news/webcasts/"
  #  Then I should see the link "event display title"

  @api
  Scenario: Webcast links point to event detail page
    Given "webcast" content:
      | title         | field_display_title   | field_start_date | field_end_date | field_webcast_running_time | field_webcast_src | moderation_state |
      | webcast title | webcast display title | now              | +2 hours       |                            | MPR               | published        |
      And "event" content:
      # | title                        | field_display_title | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      # | Webcast links point to event | event display title | meeting          | 1      | US                          | 123 Main St    | VA                   | Arlington | 22204        | webcast title | now                  | +5 hours                 | published        |
      | title                        | field_display_title | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      | Webcast links point to event | event display title | meeting          | 1      | webcast title | now                  | +5 hours                 | published        |
    When I visit "/news/upcoming-events/"
    Then I should see the link "webcast display title"
    When I click "webcast display title"
    Then I should see the text "event display title"

  @api
  Scenario: Ability to hide the Live Webcast Player from block using source None
    Given "webcast" content:
      | title         | field_display_title   | field_start_date | field_end_date | body                   | field_webcast_running_time | field_webcast_src | moderation_state |
      | webcast title | webcast display title | now              | +4 hours       | this is the body field |                            | None              | published        |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content |
      | moderation_state            | published                |
      | field_event_type            | meeting                  |
      | status                      | 1                        |
      # | field_location:country_code | US                       |
      # | :address_line1              | 123 Main St              |
      # | :administrative_area        | VA                       |
      # | :locality                   | Springfield              |
      # | :postal_code                | 22124                    |
      | field_webcast               | webcast title            |
      | field_display_title         | BEHAT Test Event Content |
      | field_sec_event_date        | 2017-06-01 12:00:00      |
      | field_sec_event_end_date    | 2017-06-02 12:00:00      |
      And I wait 1 seconds
    Then I should not see a video player

  #@api
  #TODO: Validate the scenario
  #Scenario: When I look for a .json file at /nb/mobile-live-stream.json I find a .json file that provides info fo next Live/upcoming webcast
  #  Given "webcast" content:
  #    | title         		      | field_display_title		  | field_start_date | field_end_date | field_webcast_running_time | field_webcast_source | field_display_live_webcast | moderation_state |
  #    | .json file display test | .json file display test | now 		         | +4 hours    	  |			                       | MPR_1@330284   	    | 1				 		   |	published     |
  #    And "event" content:
  #      | title             | field_event_type  | status | field_location:country_code| :address_line1 | :administrative_area | :locality | :postal_code | field_webcast 		  | field_sec_event_date | field_sec_event_end_date | moderation_state|
  #      | json display event| meeting 	   	   | 1	    | US			             | 123 Main St	  | VA		    	     | Arlington | 22204        | .json file display test | now 		           | +4 hours    	        | published       |
  #  When I visit "/nb/mobile-live-stream.json"
  #outcome will need to be implemented

  @api
  Scenario Outline: Pending Webcast Archive Display
    Given "webcast" content:
      | title         | field_display_title   | field_start_date | field_end_date  | field_media_id | field_webcast_running_time | field_webcast_src | moderation_state |
      | BEHAT Webcast | BEHAT Webcast Display | yesterday 14:00  | yesterday 19:00 | <ID>           | 1 h 30 min                 | MPR               | published        |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content |
      | moderation_state            | published                |
      | field_event_type            | meeting                  |
      | status                      | 1                        |
      # | field_location:country_code | US                       |
      # | :address_line1              | 123 Main St              |
      # | :administrative_area        | VA                       |
      # | :locality                   | Springfield              |
      # | :postal_code                | 22124                    |
      | field_webcast               | BEHAT Webcast            |
      | field_display_title         | BEHAT Test Event Content |
      | field_sec_event_date        | 2017-06-01 12:00:00      |
      | field_sec_event_end_date    | 2017-06-02 12:00:00      |
    Then I <Outcome> see the text "Webcast archive will be posted soon"
      And I reload the page

    Examples:
      | ID                               | Outcome    |
      | 374dc5703d3b4771b4aa771041b61c9b | should not |
      |                                  | should     |

  @api
  Scenario: Ability to hide event/webcast information from event/webcast list page. External users will be given the link by content creator to preview content
    Given "webcast" content:
      | title        | field_display_title         | field_start_date | field_end_date | field_media_id | field_webcast_running_time | field_webcast_src | field_display_live_webcast | moderation_state |
      | Hide webcast | display title: Hide webcast | +12 hours        | +14 hours      |                | 1 h 30 min                 | MPR               | 0                          | published        |
      And "event" content:
      # | title      | field_display_title               | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      # | hide event | Display title: hide event display | hidden           | 1      | US                          | 123 Main St    | VA                   | Arlington | 22204        | Hide webcast  | +12 hours            | +14 hours                | published        |
      | title      | field_display_title               | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | moderation_state |
      | hide event | Display title: hide event display | hidden           | 1      | Hide webcast  | +12 hours            | +14 hours                | published        |
    When I visit "/news/webcasts/"
    Then I should not see the link "display title: Hide webcast"
      And I should not see the text "Display title: hide event display"
    When I visit "/news/upcoming-events/"
    Then I should not see the link "display title: Hide webcast"
      And I should not see the text "Display title: hide event display"

  @api
  Scenario: Ability to watch webcast archive on event detail page
    Given "webcast" content:
      | title         | field_display_title                    | body                   | field_start_date | field_end_date  | field_media_id                   | field_webcast_running_time | field_webcast_src | moderation_state |
      | BEHAT Webcast | display title: display webcast archive | this is the body field | yesterday 14:00  | yesterday 19:00 | 374dc5703d3b4771b4aa771041b61c9b | 1 h 32 min                 | MPR               | published        |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content |
      | moderation_state            | published                |
      | field_event_type            | meeting                  |
      | status                      | 1                        |
      # | field_location:country_code | US                       |
      # | :address_line1              | 123 Main St              |
      # | :administrative_area        | VA                       |
      # | :locality                   | Springfield              |
      # | :postal_code                | 22124                    |
      | field_webcast               | BEHAT Webcast            |
      | field_display_title         | BEHAT Test Event Content |
      | field_sec_event_date        | 2017-06-01 12:00:00      |
      | field_sec_event_end_date    | 2017-06-02 12:00:00      |
    Then I should see the text "display title: display webcast archive"
      And I should see the text "this is the body field"

  @api
  Scenario: Verify the display of multiple webcast archives on event detail page including verifying the display title, body and run time display behaviors
    Given "webcast" content:
      | title          | field_display_title         | field_start_date | field_end_date  | field_media_id                   | field_webcast_running_time | field_webcast_src | moderation_state |
      | webcast1 title | List Event webcast archive1 | yesterday 14:00  | yesterday 19:00 | 6b0f90b8087f403e94377bbb4f9bf392 | 1 h 34 min                 |                   | published        |
      | webcast2 title |                             | yesterday 14:00  | yesterday 19:00 | dbbb5d5395e34d63a4edee2527814628 |                            |                   | published        |
    When I am viewing an "event" content:
      | title                       | BEHAT Test Event Content       |
      | moderation_state            | published                      |
      | field_event_type            | meeting                        |
      | status                      | 1                              |
      # | field_location:country_code | US                             |
      # | :address_line1              | 123 Main St                    |
      # | :administrative_area        | VA                             |
      # | :locality                   | Springfield                    |
      # | :postal_code                | 22124                          |
      | field_webcast               | webcast1 title, webcast2 title |
      | field_display_title         | BEHAT Test Event Content       |
      | field_sec_event_date        | yesterday 14:00                |
      | field_sec_event_end_date    | yesterday 19:00                |
    Then I should see the text "Event Webcasts"
      And I should see the text "List Event webcast archive1 (1 h 34 min)"
      And I should see the link "webcast2 title"
      And I should see the text "List Event webcast archive1"

  #@api
  #TODO: Corpfin About page does not show live webcast--is this still a requirement?
  #Scenario: Be able to create a webcast, associate it with an event, display it on landing page and Bio page
  #    Given "webcast" content:
  #      | title          | field_display_title   | field_start_date | field_end_date | body 				          | field_webcast_running_time |field_webcast_source | field_webcast_state| moderation_state |
  #	    | webcast title  | Webcast display title | now              | + 3 hour 		   | This is the body field | 1 h 30 min			           |MPR_1@330284  	     | live               | published        |
  #      And "event" content:
  #        | title       | field_display_title | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code	| field_webcast  | field_sec_event_date | field_sec_event_end_date | moderation_state | field_related_landing_page| field_person |
  #	      | event title | event display title | meeting 		     | 1	    | US			                    | 123 Main St	   | VA		    	          | Arlington | 22204	        | webcast title  | now				          | +3 hours			           | published        | dera_about                | John Nester  |
  #    When I visit "/news/upcoming-events/"
  #    Then I should see the text "Happening now"
  #      And I should see the link "Webcast display title"
  #    When I visit "/page/dera_about"
  #    Then I should see the text "Live Webcast"
  #      And I should see the link "event display title"
  #      And I visit "/biography/john-nester"
  #      And I should see the link "event display title"


  #@api
  #TODO: This needs to be rewritten--it depends on content 'homepage' should likely create a landing page and then asociate that one
  #Scenario: Validate Webcast state and title display of webcast without a Display Title filled in
  #  Given "webcast" content:
  #    | title           | field_start_date | field_end_date | body 				       | field_webcast_source | moderation_state | field_webcast_state |
  #	  | Title Upcoming  | +12 hour			   | + 20 hour 	    | Webcast Body Field | MPR_1@330284  	      | published        | upcoming				     |
  #    | Title Happening | now				       | + 3 hour			  | Webcast Body Field | MPR_1@330284  	      | published        | live				         |
  #    | No DT Archived  | -24 hour			   | -12 hour 		  | Webcast Body Field | MPR_1@330284  	      | published        | ended				       |
  #    And "event" content:
  #      | title       	   					 | field_event_type | status | field_location:country_code | :address_line1  | :administrative_area | :locality | :postal_code | field_webcast	  | field_sec_event_date | field_sec_event_end_date | moderation_state| field_related_landing_page	|
  #	    | Event-Title Upcoming       | meeting 		      | 1	     | US			                     | 123 Main St	   | VA		    	          | Arlington | 22204	       | Title Upcoming   | +12 hours				     | +20 hours			          | published       | homepage                		|
  #      | Event-Title Happening      | meeting 		      | 1	     | US			                     | 123 Main St	   | VA		    	          | Arlington | 22204	       | Title Happening  | now					         | +3 hours			            | published       | homepage		                |
  #      | Event-Title No DT Archived | meeting 		      | 1	     | US			                     | 123 Main St	   | VA		    	          | Arlington | 22204	       | No DT Archived   | -25 hours				     | -15 hours			          | published       | homepage                		|
  #  When I visit "/news/upcoming-events/event-title-upcoming"
  #	Then I should see the text "Title Upcoming"
  #  When I visit "/news/upcoming-events/event-title-happening"
  #	Then I should see the text "Title Happening"
  #	  And I should not see the text "Webcast Body Field"
  #  When I visit "/news/upcoming-events/event-title-no-dt-archived"
  #	Then I should see the text "No DT Archived"
  #  	And I should not see the text "Webcast Body Field"

  @api @javascript
  Scenario: When I visit a hidden event detail page and the webcast is on state testing, I am able to see the webcast liveplayer
    Given I am logged in as a user with the "administrator" role
      And "webcast" content:
      | title                | field_display_title           | field_start_date | field_end_date | field_webcast_src | field_webcast_state | moderation_state |
      | Display Live webcast | display title of live webcast | now              | +3 hours       | MPR               | testing             | published        |
      And "event" content:
      # | title        | field_event_type | status | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_webcast        | field_sec_event_date | field_sec_event_end_date | moderation_state |
      # | Hidden event | hidden           | 1      | US                          | 123 Main St    | VA                   | Arlington | 22204        | Display live webcast | now                  | +3 hours                 | published        |
      | title        | field_event_type | status | field_webcast        | field_sec_event_date | field_sec_event_end_date | moderation_state |
      | Hidden event | hidden           | 1      | Display live webcast | now                  | +3 hours                 | published        |
    When I visit "/nb/news/upcoming-events/hidden-event"
    Then I should see the text "display title of live webcast"
      And I should see a video player

  @api @javascript
  Scenario: Create A Webcast With Date Picker
    Given I am logged in as a user with the "content_approver" role
    When I am on "/node/add/webcast"
      And I fill in the following:
      | Title                            | Behat Webcast               |
      | Display Title                    | Behat Display Webcast Title |
      | field_date[0][value][date]       | 10-10-2020                  |
      | field_date[0][value][time]       | 10:00:00AM                  |
      | field_start_date[0][value][date] | 10-11-2020                  |
      | field_start_date[0][value][time] | 06:00:00PM                  |
      | field_end_date[0][value][date]   | 10-12-2020                  |
      | field_end_date[0][value][time]   | 07:00:00AM                  |
      And I type "This is the body of the webcast" in the "Body" WYSIWYG editor
      And I select "SPA" from "Webcast Source"
      And I publish it
    Then I should see the text "Behat Display Webcast Title"
      And I should see the text "This is the body of the webcast"
      And I should see the text "Oct. 10, 2020"
      And I should see the text "Oct. 11, 2020"
      And I should see the text "Oct. 12, 2020"
