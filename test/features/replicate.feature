Feature: Replicate Content Nodes
  As a Content Creator to the SEC.gov
  I want to be able to duplicate a content
  So that I can leverage existing content to create similar content

  Background:
    Given users:
        | uid  | name        | mail           | roles            | status |
        | 9995 | bh_creator1 | test5@test.com | Content Creator  | 1      |
        | 9996 | bh_creator2 | test6@test.com | Content Creator  | 1      |
        | 9997 | bh_approver | test7@test.com | Content Approver | 1      |
        | 9998 | bh_bac1     | test8@test.com | bad_actors       | 1      |
      And "secperson" content:
        | title      | field_first_name_secperson | field_last_name_secperson | body                                                                               | field_enable_biography_page | status | nid      |
        | John Behat | John                       | Behat                     | John started working with behat in 2017 and has been maintaining behat ever since. | 1                           | 1      | 9878900  |
        | Jane Behat | Jane                       | Behat                     | Jane started working with behat in 2018 and has been maintaining behat ever since. | 1                           | 1      | 9878901  |
      And "division_office" terms:
        | name       |
        | division 1 |
        | office 1   |
      And "tags" terms:
        | name     | tid  |
        | tag team | 8020 |

@api
Scenario Outline: Replicate Image Content
  Given "image" content:
    | title             | field_primary_division_office | moderation_state | status |
    | BEHAT Image File  | office 1                      | published        | 1      |
    And I am logged in as a user with the "<role>" role
  When I am on "/image/behat-image-file/replicate"
  Then the response status code should be <status_code>

  Examples:
  | role                  | status_code |
  | administrator         | 200         |
  | sitebuilder           | 200         |
  | content_approver      | 403         |
  | content_creator       | 403         |
  | bad_actors            | 403         |
  | division_office_admin | 403         |

@api
Scenario Outline: Replicate Video Content
  Given "video" content:
    | title                   | field_display_title     | field_video                                | body         | field_transcript     | status | moderation_state |
    | BEHAT Simple Video Test | behat simple video test | http://www.youtube.com/watch?v=xf9BpXOtMcc | man from SEC | man walking in video | 1      | published        |
    And I am logged in as a user with the "<role>" role
  When I am on "/news/sec-videos/behat-simple-video-test/replicate"
  Then the response status code should be <status_code>

  Examples:
  | role                  | status_code |
  | administrator         | 200         |
  | sitebuilder           | 200         |
  | content_approver      | 403         |
  | content_creator       | 403         |
  | bad_actors            | 403         |
  | division_office_admin | 403         |

@api
Scenario Outline: Replicate Static File Content
  Given "file" content:
    | title                         | field_display_title           | field_primary_division_office | status |
    | BEHAT Simple Static File Test | behat simple static file test | Credit Ratings                | 1      |
    And I am logged in as a user with the "<role>" role
  When I am on "/file/behat-simple-static-file-test/replicate"
  Then the response status code should be <status_code>

  Examples:
  | role                  | status_code |
  | administrator         | 200         |
  | sitebuilder           | 200         |
  | content_approver      | 403         |
  | content_creator       | 403         |
  | bad_actors            | 403         |
  | division_office_admin | 403         |

@api @javascript
Scenario: Replicate Static File Media
  Given I create "media" of type "static_file":
    | name                                | field_display_title       | field_description_abstract | status |
    | BEHAT Simple Static File Media Test | behat simple static file  | This is description abs    | 1      |
    And I am logged in as a user with the "content_creator" role
  When I visit "/file/behat-simple-static-file-media-test/edit"
  Then I should not see the link "Replicate" in the "navigation_tab" region

@api @javascript
Scenario: Replicate Video Media
  Given I create "media" of type "video_media":
    | name            | field_display_title | field_media_oembed_video                    | field_media_item_body  | field_media_transcript | status | mid       |
    | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | media vido body        | cat transcript         | 1      | 9241159   |
    And I am logged in as a user with the "content_creator" role
  When I visit "/media/9241159/edit"
  Then I should not see the link "Replicate" in the "navigation_tab" region

@api @javascript
Scenario: Replicate Image Media
  Given I create "media" of type "image_media":
    | name               | field_media_image  | field_media_caption | status | mid    |
    | Behat Person Image | behat-person.gif   | This is a person    | 1      | 902100 |
    And I am logged in as a user with the "content_creator" role
  When I visit "/media/902100/edit"
  Then I should not see the link "Replicate" in the "navigation_tab" region

@api @javascript
Scenario: Replicate Landing Page Content
  Given "landing_page" content:
    | title     | field_display_title    | field_primary_division_office | field_left_1_box | field_description_abstract | field_tags | field_division_office | field_audience | field_act        | field_regulation | field_left_2_box | field_left_3_box | field_left_4_box | field_left_5_box | field_center_2_box | field_right_2_box | field_right_3_box | field_right_4_box | field_left_nav_override | status | field_creator | field_sec_content_approver | field_date          | nid     | field_person | sticky | promote |
    | BHLP Test | Behat LP Display Title | office 1                      | fl1b             | my description abs         | tag team   | Agency-Wide           | Investors      | JOBS Act of 2012 | Regulation S     | fl2b             | fl3b             | fl4b             | fl5b             | fc2b               | fr2b              | fr3b              | fr4b              | About                   | 1      | bh_creator1   | bh_approver                | 2019-06-17T17:00:00 | 9876543 | John Behat   | 1      | 1       |
  When I am logged in as "bh_creator2"
    And I am on "/page/bhlp-test/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Landing Page 2"
    And I press "Replicate"
  Then I should see the heading "Edit Landing Page Behat Landing Page 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "SEC Content Approver" field should not contain "bh_approver (9997)"
    But the "SEC Content Approver" field should contain ""
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should contain "/page/behat-landing-page-2"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-target-id" field should contain "bh_creator2 (9996)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the "Title" field should contain "Behat Landing Page 2"
    And the "Description/Abstract" field should contain "my description abs"
    And the "edit-field-tags-0-target-id" field should contain "tag team (8020)"
    And the "#edit-field-person option[selected='selected']" element should contain "John Behat"
    And the "#edit-field-primary-division-office option[selected='selected']" element should contain "office 1"
    And the "#edit-field-division-office option[selected='selected']" element should contain "Agency-Wide"
    And the "#edit-field-audience option[selected='selected']" element should contain "Investors"
    And the "#edit-field-act option[selected='selected']" element should contain "JOBS Act of 2012"
    And the "#edit-field-regulation option[selected='selected']" element should contain "Regulation S"
    And the "#edit-field-left-nav-override option[selected='selected']" element should contain "About"
  When I scroll to the bottom
    And the "edit-field-date-0-value-date" field should not contain "2019-06-17"
    But the "edit-field-date-0-value-date" field should contain ""
    And the "edit-field-date-0-value-time" field should not contain "13:00:00"
    But the "edit-field-date-0-value-time" field should contain ""
    And I press the "Save and Create New Draft" button
  Then I should see the heading "Behat LP Display Title"
    And I should see the text "fl1b"
    And I should see the text "fl2b"
    And I should see the text "fl3b"
    And I should see the text "fl4b"
    And I should see the text "fl5b"
    And I should see the text "fr2b"
    And I should see the text "fr3b"
    And I should see the text "fr4b"
    And I should see the text "fc2b"
  When I am on "/page/behat-landing-page-2/edit"
    And I click "Revisions" in the "navigation_tab" region
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript
Scenario: Replicate Article Content
  Given "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | title                     | field_display_title       | status | body             | field_primary_division_office | field_creator | field_sec_content_approver | nid     | field_date          | field_tags | field_description_abstract | field_publish_date  | field_contact_email | field_contact_name | field_release_number | field_division_office | field_person | field_left_nav_override | field_audience | field_act        |  sticky | promote |
    | Data                          | Data-MarketStructure          | Behat Simple Article Test | behat simple article test | 1      | This is the body | Corporation Finance           | bh_creator1   | bh_approver                | 9876544 | 2019-06-17T17:00:00 | tag team   | my description abs         | 2019-07-17T18:00:00 | behat@test.test     | ramen              | 2019-12345           | Agency-Wide           | John Behat   | About                   | Investors      | JOBS Act of 2012 |  1      | 1       |
  When I am logged in as "bh_creator2"
    And I am on "/corpfin/data/market-structure/behat-simple-article-test/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876544?"
    And I fill in "edit-new-label-en" with "Behat Test Article 2"
    And I press "Replicate"
  Then I should see the heading "Edit Article Behat Test Article 2"
    And I should see the text "node (9876544) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "SEC Content Approver" field should not contain "bh_approver (9997)"
    But the "SEC Content Approver" field should contain ""
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should contain "/corpfin/data/market-structure/behat-test-article-2"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-0-target-id" field should contain "bh_creator2 (9996)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the "Title" field should contain "Behat Test Article 2"
    And the "#edit-field-article-type-secarticle option[selected='selected']" element should contain "Data"
    And the "#edit-field-article-sub-type-secart option[selected='selected']" element should contain "Market Structure"
    And the "Display Title" field should contain "behat simple article test"
    And the "Description/Abstract" field should contain "my description abs"
    And the "edit-field-tags-0-target-id" field should contain "tag team (8020)"
    And the "edit-field-publish-date-0-value-date" field should not contain "2019-07-17"
    And the "edit-field-publish-date-0-value-time" field should not contain "14:00:00"
    And the "edit-field-date-0-value-date" field should not contain "2019-06-17"
    But the "edit-field-date-0-value-date" field should contain ""
    And the "edit-field-date-0-value-time" field should not contain "13:00:00"
    But the "edit-field-date-0-value-time" field should contain ""
    And the "edit-field-release-number-0-value" field should not contain "2019-12345"
    But the "edit-field-release-number-0-value" field should contain ""
    And the "#edit-field-primary-division-office option[selected='selected']" element should contain "Corporation Finance"
    And the "#edit-field-person option[selected='selected']" element should contain "John Behat"
    And the "#edit-field-division-office option[selected='selected']" element should contain "Agency-Wide"
    And the "#edit-field-audience option[selected='selected']" element should contain "Investors"
    And the "#edit-field-act option[selected='selected']" element should contain "JOBS Act of 2012"
    And the "#edit-field-left-nav-override option[selected='selected']" element should contain "About"
    And the "edit-field-contact-name-0-value" field should contain "ramen"
    And the "edit-field-contact-email-0-value" field should contain "behat@test.test"
  When I fill in "edit-field-date-0-value-date" with "07-31-2022"
    And I fill in "edit-field-date-0-value-time" with "08:00:00AM"
    And I scroll to the bottom
    And I press the "Save and Create New Draft" button
  Then I should see the heading "behat simple article test"
    And I should see the text "This is the body"
    And I should see the text "July 2022"
  When I am on "/corpfin/data/market-structure/behat-test-article-2/revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript
Scenario: Replicate Event Content
  Given "event" content:
    # | field_sec_event_date | title       | field_event_type | body | field_location:country_code | :address_line1 | :administrative_area | :locality | :postal_code | field_sec_event_end_date | field_display_title | field_person | status | field_primary_division_office | field_creator | field_sec_content_approver | nid     | field_tags | field_all_day_event | field_add_to_calendar | field_show_end_date | field_additional_information | field_contact | field_meeting_category | sticky | promote |
    # | 2019-06-17T17:00:00  | Behat Event | meeting          | body | US                          | 33 Arch Street | MA                   | Boston    | 02110        | 2019-06-18T20:00:00      | behat simple event  | Jane Behat   | 1      | Corporation Finance           | bh_creator1   | bh_approver                | 9876545 | tag team   | 1                   | 0                     | 1                   | turn left                    | John Behat    | Open Meeting           | 1      | 1       |
    | field_sec_event_date | title       | field_event_type | body | field_sec_event_end_date | field_display_title | field_person | status | field_primary_division_office | field_creator | field_sec_content_approver | nid     | field_tags | field_all_day_event | field_add_to_calendar | field_show_end_date | field_additional_information | field_contact | field_meeting_category | sticky | promote |
    | 2019-06-17T17:00:00  | Behat Event | meeting          | body | 2019-06-18T20:00:00      | behat simple event  | Jane Behat   | 1      | Corporation Finance           | bh_creator1   | bh_approver                | 9876545 | tag team   | 1                   | 0                     | 1                   | turn left                    | John Behat    | Open Meeting           | 1      | 1       |
  When I am logged in as "bh_approver"
    And I am on "/news/upcoming-events/behat-event/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876545?"
    And I fill in "edit-new-label-en" with "Behat Test Event 2"
    And I press "Replicate"
  Then I should see the heading "Edit Event Behat Test Event 2"
    And I should see the text "node (9876545) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_approver" in the "edit_author" region
    And the "SEC Content Approver" field should not contain "bh_approver (9997)"
    But the "SEC Content Approver" field should contain ""
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should contain "/news/upcoming-events/behat-test-event-2"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-0-target-id" field should contain "bh_approver (9997)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the checkbox "Sticky at top of lists" is unchecked
    And the "Title" field should contain "Behat Test Event 2"
    And the "Display Title" field should contain "behat simple event"
    And the checkbox "All Day" is checked
    And the checkbox "Show End Date" is checked
    And the checkbox "Show add to calendar widget" is unchecked
    And the "edit-field-sec-event-date-0-value-date" field should not contain "2019-06-17"
    And the "edit-field-sec-event-date-0-value-date" field should not contain ""
    And the "edit-field-sec-event-date-0-value-time" field should not contain "13:00:00"
    And the "edit-field-sec-event-date-0-value-time" field should not contain ""
    And the "edit-field-sec-event-end-date-0-value-date" field should not contain "2019-06-18"
    And the "edit-field-sec-event-end-date-0-value-date" field should not contain ""
    And the "edit-field-sec-event-end-date-0-value-time" field should not contain "16:00:00"
    And the "edit-field-sec-event-end-date-0-value-time" field should not contain ""
    But the "edit-field-sec-event-end-date-0-value-time" field should not contain ""
    And the "#edit-field-event-type option[selected='selected']" element should contain "SEC Meetings and Other Events"
    And the "#edit-field-meeting-category option[selected='selected']" element should contain "Open Meeting"
    And the "#edit-field-primary-division-office option[selected='selected']" element should contain "Corporation Finance"
    And the "edit-field-tags-0-target-id" field should contain "tag team (8020)"
    And the "#edit-field-person option[selected='selected']" element should contain "Jane Behat"
  When I fill in "Display Title" with "Behat Test Event 2 Display Title"
  When I scroll to the bottom
    And I publish it
  Then I should see the heading "Behat Test Event 2 Display Title"
    And I should see the text "body"
    And I should see the text "turn left"
    # And I should see the text "33 Arch Street"
    # And I should see the text "Boston, MA 02110"
    And I should see the text "John behat"
    # And I should see the "img" element with the "class" attribute set to "leaflet-marker-icon leaflet-zoom-animated leaflet-interactive" in the "contentarea" region
    # And I should see the "div" element with the "class" attribute set to "leaflet-container leaflet-touch leaflet-fade-anim leaflet-grab leaflet-touch-drag leaflet-touch-zoom" in the "contentarea" region
  When I visit "/news/upcoming-events"
  Then I should see the link "Behat Test Event 2 Display Title"
  When I am on "/news/upcoming-events/behat-test-event-2/revisions"
  Then I should see the text "by bh_approver"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript
Scenario: Replicate News Press Release Content
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title                     | status | body                    | field_display_title       | field_creator | field_sec_content_approver | nid     | field_date          | field_tags | field_description_abstract | field_publish_date  | field_release_number | field_person | sticky | promote |
    | Press Release        | Agency-wide                   | Behat Simple PR News Test | 1      | This is the first body. | behat simple pr news test | bh_creator1   | bh_approver                | 9876546 | 2019-06-17T17:00:00 | tag team   | my description abs         | 2019-07-17T18:00:00 | 2020-126             | Jane Behat   | 1      | 1       |
  When I am logged in as "bh_creator2"
    And I am on "/news/press-release/behat-simple-pr-news-test/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876546?"
    And I fill in "edit-new-label-en" with "Behat Test News 2"
    And I press "Replicate"
  Then I should see the heading "Edit News Behat Test News 2"
    And I should see the text "node (9876546) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "SEC Content Approver" field should not contain "bh_approver (9997)"
    But the "SEC Content Approver" field should contain ""
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should contain "/news/press-release/behat-test-news-2"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-0-target-id" field should contain "bh_creator2 (9996)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the "#edit-field-news-type-news option[selected='selected']" element should contain "Press Release"
    And the "Title" field should contain "Behat Test News 2"
    And the "edit-field-tags-0-target-id" field should contain "tag team (8020)"
    And the "Display Title" field should contain "behat simple pr news test"
    And the "Description/Abstract" field should contain "my description abs"
    And the "edit-field-publish-date-0-value-date" field should not contain "2019-07-17"
    And the "edit-field-publish-date-0-value-date" field should not contain ""
    And the "edit-field-publish-date-0-value-time" field should not contain "14:00:00"
    And the "edit-field-publish-date-0-value-time" field should not contain ""
    And the "edit-field-date-0-value-date" field should not contain "2019-06-17"
    But the "edit-field-date-0-value-date" field should contain ""
    And the "edit-field-date-0-value-time" field should not contain "13:00:00"
    But the "edit-field-date-0-value-time" field should contain ""
    And the "edit-field-release-number-0-value" field should not contain "2020-126"
    But the "edit-field-release-number-0-value" field should contain ""
    And the "Location" field should contain "Washington D.C."
    And the "edit-field-person-0-target-id" field should contain "Jane Behat (9878901)"
    And the "#edit-field-primary-division-office option[selected='selected']" element should contain "Agency-Wide"
  When I fill in "Display Title" with "Hot off the press"
    And I fill in "Release Number" with "90210"
    And I scroll to the bottom
    And I press the "Save and Create New Draft" button
  Then I should see the heading "Hot off the press"
    And I should see the text "This is the first body."
    And I should see the text "90210"
  When I am on "/news/press-release/behat-test-news-2/revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by bh_creator1"
    And I should not see the text "by Anonymous"

@api @javascript
Scenario: Replicate News Statement Content
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title                     | status | body                    | field_display_title       | field_creator | field_sec_content_approver | nid     | field_date          | field_tags | field_description_abstract | field_publish_date  | field_person | sticky | promote |
    | Statement            | Agency-wide                   | Behat Simple PS News Test | 1      | This is the first body. | behat simple pr news test | bh_creator1   | bh_approver                | 9876546 | 2019-06-17T17:00:00 | tag team   | my description abs         | 2019-07-17T18:00:00 | Jane Behat   | 1      | 1       |
  When I am logged in as "bh_creator2"
    And I am on "/news/statement/behat-simple-ps-news-test/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876546?"
    And I fill in "edit-new-label-en" with "Behat Test News 2"
    And I press "Replicate"
  Then I should see the heading "Edit News Behat Test News 2"
    And I should see the text "node (9876546) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "SEC Content Approver" field should not contain "bh_approver (9997)"
    But the "SEC Content Approver" field should contain ""
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should contain "/news/statement/behat-test-news-2"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-0-target-id" field should contain "bh_creator2 (9996)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the "#edit-field-news-type-news option[selected='selected']" element should contain "Statement"
    And the "Title" field should contain "Behat Test News 2"
    And the "edit-field-tags-0-target-id" field should contain "tag team (8020)"
    And the "Display Title" field should contain "behat simple pr news test"
    And the "Description/Abstract" field should contain "my description abs"
    And the "edit-field-publish-date-0-value-date" field should not contain "2019-07-17"
    And the "edit-field-publish-date-0-value-date" field should not contain ""
    And the "edit-field-publish-date-0-value-time" field should not contain "14:00:00"
    And the "edit-field-publish-date-0-value-time" field should not contain ""
    And the "edit-field-date-0-value-date" field should not contain "2019-06-17"
    But the "edit-field-date-0-value-date" field should contain ""
    And the "edit-field-date-0-value-time" field should not contain "13:00:00"
    But the "edit-field-date-0-value-time" field should contain ""
    And the "edit-field-person-0-target-id" field should contain "Jane Behat (9878901)"
    And the "#edit-field-primary-division-office option[selected='selected']" element should contain "Agency-Wide"
  When I fill in "Display Title" with "Hot off the press"
    And I scroll to the bottom
    And I press the "Save and Create New Draft" button
  Then I should see the heading "Hot off the press"
    And I should see the text "This is the first body."
    And I should see "Jane Behat"
  When I am on "/news/statement/behat-test-news-2/revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by bh_creator1"
    And I should not see the text "by Anonymous"

@api @javascript
Scenario: Replicate IDD Content
  Given I create "node" of type "ba":
    | title   | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document   | field_date_filed | field_court | field_civ_action_no_ap_file_no | body | status | nid     | field_action_number | field_judgment_date | field_ap_usdc | field_individual_name_in_documen | field_entity_name | field_also_known_as | field_court | field_judgment_final_order_appea | field_display_no_display | field_middle_initial | sticky | promote |
    | JorgeCl | Jorge            | Clooney         | 33                    | Alabama          | State/Residence       | SEC v. Clooney Clan LLC. et al. | 2011-06-17       | N. D. Ala.  | Test234                        | body | 1      | 9192019 | DC-20002-A          | 2012-07-27          | usdc          | Clooney                          | JClooney          | headman             | N.D. Cal.   | No                               | 2                        | Z                    | 1      | 1       |
  When I am logged in as "bh_bac1"
    And I am on "/idd/node/9192019/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9192019?"
    And I fill in "edit-new-label-en" with "Behat Test IDD Matt Diamond"
    And I press "Replicate"
  Then I should see the heading "Edit Individual Defendant Behat Test IDD Matt Diamond"
    And I should see the text "node (9192019) has been replicated to id"
    And I should see the text "Not published" in the "edit_meta" region
    And I should see the text "bh_bac1" in the "edit_author" region
  When I click on the element with css selector "#edit-path-0"
  Then the "URL alias" field should not contain "/idd/node/9192019"
  When I click on the element with css selector "#edit-author"
  Then the "edit-uid-0-target-id" field should contain "bh_bac1 (9998)"
  When I click on the element with css selector "#edit-options"
  Then the checkbox "Promoted to front page" is unchecked
    And the checkbox "Sticky at top of lists" is unchecked
    And the "#edit-field-ap-usdc option[selected='selected']" element should contain "USDC"
    And the "Individual Name in Document" field should contain "Clooney"
    And the "edit-field-first-name-0-value" field should contain "Jorge"
    And the "edit-field-middle-initial-0-value" field should contain "Z"
    And the "edit-field-last-name-0-value" field should contain "Clooney"
    And the "Entity Name" field should contain "JClooney"
    And the "edit-field-also-known-as-0-value" field should contain "headman"
    And the "Age in Document" field should contain "33"
    And the "#edit-field-state-idd option[selected='selected']" element should contain "Alabama"
    And the "Action Name in document" field should contain "SEC v. Clooney Clan LLC. et al."
    And the "Action Related Name ID" field should contain "Behat Test IDD Matt Diamond"
    And the "edit-field-date-filed-0-value-date" field should contain "2011-06-17"
    And the "Action Number" field should contain "DC-20002-A"
    And the "#edit-field-court option[selected='selected']" element should contain "N.D. Cal."
    And the "Civ. Action No. /AP File No." field should contain "Test234"
    And the "#edit-field-judgment-final-order-appea option[selected='selected']" element should contain "No"
    And the "edit-field-judgment-date-0-value-date" field should not contain "2012-07-27"
    And the "edit-field-judgment-date-0-value-date" field should contain ""
    And the "#edit-field-display-no-display option[selected='selected']" element should contain "Other"
  When I publish it
  Then I should see the text "Individual Defendant Behat Test IDD Matt Diamond has been updated."
  When I click "Edit" in the "Behat Test IDD Matt Diamond" row
    And I click "Revisions"
  Then I should see the text "by bh_bac1"
    But I should not see the text "by Anonymous"
