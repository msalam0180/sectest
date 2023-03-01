Feature: Workflow and Permissions
  As an authenticated user
  I want to be able to view/use workflow with the right permissions
  So that I create, edit, delete, and publish content

  Background:
    Given "division_office" terms:
      | name              |
      | behat             |
      | office of justice |
      And users:
      | name      | mail           | roles                 |
      | ccreator  | test1@test.com | content_creator       |
      | ccreator2 | test2@test.com | content_creator       |
      | capprover | test3@test.com | content_approver      |
      | doadmin   | test5@test.com | division_office_admin |

@api @javascript
Scenario: My Edits Workflow
  Given users:
    | name      | mail           | status | roles           | uid  |
    | ccreator1 | test4@test.com | 1      | content_creator | 9999 |
    And "secarticle" content:
      | field_article_type_secarticle | moderation_state | title                    | field_display_title      | status | body             | field_primary_division_office | uid  |
      | Other                         | draft            | Article Created by User1 | Article Created by User1 | 0      | This is the body | office of justice             | 9999 |
    And I am logged in as "ccreator2"
  When I visit "/admin/content/search"
    And I fill in "Display Title" with "Article Created"
    And I press "Filter"
    And I wait for Ajax to finish
    And I click "Edit" in the "Article Created by User1" row
    And I fill in "Title" with "Article Created by User1 and Edited by User2"
    And I fill in "Display Title" with "Article Created by User1 and Edited by User2"
    And I press "Save and Create New Draft"
    And I am logged in as "capprover"
    And I visit "/admin/content/search"
    And I fill in "Title" with "edited by user2"
    And I press "Filter"
    And I wait for Ajax to finish
    And I click "Edit" in the "Article Created by User1 and Edited by User2" row
    And I fill in "Title" with "Article Created by User1 then Edited by User2 and User3"
    And I fill in "Display Title" with "Article Created by User1 then Edited by User2 and User3"
    And I press "Save and Create New Draft"
    And I am logged in as "ccreator1"
    And I visit "/admin/workbench"
  Then I should see the link "Article Created by User1 then Edited by User2 and User3" in the "recent_edits" region
  When I visit "/admin/workbench/content/edited"
    And I select "-View All-" from "Published"
    And I press "Apply"
    And I wait for AJAX to finish
  Then I should see the link "Article Created by User1 then Edited by User2 and User3"
  When I am logged in as "ccreator2"
    And I visit "/admin/workbench"
  Then I should see the link "Article Created by User1 then Edited by User2 and User3" in the "recent_edits" region
  When I visit "/admin/workbench/content/edited"
    And I select "-View All-" from "Published"
    And I press "Apply"
    And I wait for AJAX to finish
  Then I should see the link "Article Created by User1 then Edited by User2 and User3"
  When I am logged in as "capprover"
    And I visit "/admin/workbench"
  Then I should see the link "Article Created by User1 then Edited by User2 and User3" in the "recent_edits" region
  When I visit "/admin/workbench/content/edited"
    And I select "-View All-" from "Published"
    And I press "Apply"
    And I wait for AJAX to finish
  Then I should see the link "Article Created by User1 then Edited by User2 and User3"

@api @javascript
Scenario: Allow division office admins to update and publish Site Alerts
  Given I am logged in as a user with the "Content Creator" role
  When I visit "/node/add/sec_alert"
    And I fill in "Title" with "Test Site Alert 123"
    And I select the first autocomplete option for "doadmin" on the "edit-field-sec-content-approver-0-target-id" field
    And I select the first autocomplete option for "Critical" on the "Alert Type" field
    And I scroll to the bottom
    And I press the "List additional actions" button
    And I press the "Save and Request Review" button
    And I am an anonymous user
    And I go to the homepage
  Then I should not see the text "Test Site Alert 123"
  When I am logged in as "doadmin"
    And I visit "admin/workbench/content/needs-review"
    And I click "Edit" in the "Test Site Alert 123" row
    And I scroll to the bottom
    And I publish it
  Then I should see the text "Site Alert Test Site Alert 123 has been updated"
  When I go to the homepage
  Then I should see the text "Test Site Alert 123"
    And I should see the "div" element with the "class" attribute set to "homepage-alert Critical promote view-row-count-1 view-row-first" in the "site_alert" region

@api @javascript
Scenario: Allow division office admins to create site alerts save as draft and publish
  Given I am logged in as a user with the "division_office_admin" role
  When I visit "/node/add/sec_alert"
    And I fill in "Title" with "Test Site Alert 456"
    And I select the first autocomplete option for "Info" on the "Alert Type" field
    And I scroll to the bottom
    And I press the "Save and Create New Draft" button
  Then I should see the text "Status Draft"
  When I visit "/admin/workbench/content/all"
    And I select "No" from "Published"
    And I press "Apply"
    And I click "edit" in the "Test Site Alert 456" row
    And I publish it
  When I go to the homepage
  Then I should see the text "Test Site Alert 456"
    And I should see the "div" element with the "class" attribute set to "homepage-alert Info promote view-row-count-1 view-row-first" in the "site_alert" region

@api @javascript
Scenario: Allow division office admins to unpublish a site alert
  Given I am logged in as a user with the "division_office_admin" role
  When I visit "/node/add/sec_alert"
    And I fill in "Title" with "Test Site Alert Unpublish Me"
    And I scroll to the bottom
    And I publish it
  When I visit "/admin/workbench/content/all"
    And I click "edit" in the "Test Site Alert Unpublish Me" row
    And I scroll to the bottom
    And I press the "List additional actions" button
    And I press "Save and Unpublish"
  Then I should see the text "Site Alert Test Site Alert Unpublish Me has been updated"
  When I go to the homepage
  Then I should not see the text "Test Site Alert Unpublish Me"

@api @javascript
Scenario: Allow division office admins to publish then perform deletion of a site alert
  Given I am logged in as a user with the "division_office_admin" role
  When I visit "/node/add/sec_alert"
    And I fill in "Title" with "Test Site Alert Delete Me"
    And I scroll to the bottom
    And I publish it
  When I go to the homepage
  Then I should see the text "Test Site Alert Delete Me"
  When I visit "/admin/workbench/content/all"
    And I click "edit" in the "Test Site Alert Delete Me" row
    And I scroll to the bottom
    And I click "edit-delete"
    And I press the "Delete" button
  Then I should see the text "The Site Alert Test Site Alert Delete Me has been deleted."
  When I go to the homepage
  Then I should not see the text "Test Site Alert Delete Me"

@api
Scenario Outline: Access To Create Site Alert
  Given I am logged in as a user with the "<Role>" role
  When I am on "/node/add/sec_alert"
  Then the response status code should be <status_code>

  Examples:
    | Role                  | status_code |
    | administrator         | 200         |
    | sitebuilder           | 200         |
    | content_approver      | 403         |
    | content_creator       | 200         |
    | bad_actors            | 403         |
    | division_office_admin | 200         |

@api @javascript
Scenario Outline: Creating Different Types of Site Alert
  Given I am logged in as a user with the "division_office_admin" role
  When I visit "/node/add/sec_alert"
    And I fill in "Title" with "Test Site Alert Me"
    And I select the first autocomplete option for "<alert_type>" on the "Alert Type" field
    And I scroll to the bottom
    And I publish it
  When I go to the homepage
  Then I should see the text "Test Site Alert Me"
    And I should see the "div" element with the "class" attribute set to "<validate_alert>" in the "site_alert" region

  Examples:
    | alert_type  | validate_alert                                                  |
    | Warning     | homepage-alert Warning promote view-row-count-1 view-row-first  |
    | Info        | homepage-alert Info promote view-row-count-1 view-row-first     |
    | Critical    | homepage-alert Critical promote view-row-count-1 view-row-first |
    | Success     | homepage-alert Success promote view-row-count-1 view-row-first  |

@api @javascript
Scenario Outline: Save And Keep Content In UnPublished Status
  Given "ba" content:
    | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                   | field_date_filed | field_court | field_civ_action_no_ap_file_no | body            | status | nid     | field_action_number |
    | Geoff Daniels | Geoff            | Daniels         | 59                    | Michigan        | State/Residence       | SEC v. Carey LLC. et al., 2017 CV 12345 (D. MI) | 2012/2/4         | N. D. MI.   | Test235                        | Not so original | 1      | 6202019 | DC-20002-B          |
    And "link" content:
      | title             | field_description_abstract | field_url                             | status | field_publish_date  | field_tags   | nid     |
      | SEC.gov Page Link | Site Link Description      | Click Here - https://www.investor.gov | 1      | 2020-07-13T17:00:00 | foiafreqdocs | 6202020 |
    And "page" content:
      | title             | body                                     | status | moderation_state | nid     |
      | SEC Page Investor | Behat Display Title https://www.SEC.gov/ | 1      |                  | 6202021 |
    And "webcast" content:
      | title         | field_display_title   | body               | field_start_date | field_end_date | field_webcast_src | status | nid     | moderation_state |
      | webcast title | Webcast display title | webcast body field | +1 hour          | +4 hours       | MPR               | 1      | 6202022 | published        |
    And "event" content:
      | title             | field_display_title | field_event_type | status | field_webcast | field_sec_event_date | field_sec_event_end_date | status | nid     | moderation_state |
      | event detail page | event display title | meeting          | 1      | webcast title | +1 hour              | +4 hours                 | 1      | 6202023 | published        |
    And "sec_alert" content:
      | title            | field_alert_type | body                       | status | nid     | moderation_state |
      | BEHAT Test Alert | Critical         | BEHAT Test Alert body text | 1      | 6202025 | published        |
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title             | status | body             | field_primary_division_office | nid     |
      | Data                          | Data-MarketStructure          | published        | Behat Simple Article Test | This is the BEHAT display title | 1      | This is the body | Corporation Finance           |         |
      | Other                         | - None -                      | published        | This is the main title    | This is the display title       | 1      | This is the body | Agency-Wide                   | 6202027 |
    And "landing_page" content:
      | title                          | field_display_title            | field_primary_division_office | field_left_1_box | status | nid     | moderation_state |
      | Behat Simple Landing Page Test | behat simple landing page test | Credit Ratings                | Left 1           | 1      | 6202028 | published        |
    And "news" content:
      | field_news_type_news | field_primary_division_office | title                     | status | body                    | field_display_title       | nid     | moderation_state | field_release_number |
      | Press Release        | Agency-wide                   | Behat Simple PR News Test | 1      | This is the first body. | behat simple pr news test | 6202029 | published        | 2021-123             |
    And "data_visualization" content:
      | title                      | field_display_title | field_description_abstract      | status | nid     | moderation_state | field_script |
      | (Behat) Data Visualization | behat data viz      | (Behat) Data Visualization Test | 1      | 6202030 | published        | no content   |
    And "data_distribution" content:
      | title                     | field_display_title | field_description_abstract     | field_associated_dataset  | status | nid     | moderation_state |
      | (Behat) Data Distribution | behat data dist     | (Behat) Data Distribution Test | Behat Simple Article Test | 1      | 6202031 | published        |
    And "sec_hero" content:
      | title                 | field_display_title         | body               | field_tags  | status | nid     | moderation_state |
      | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | NYRO Slider | 1      | 6202032 | published        |
  When I am logged in as a user with the "<role>" role
    And I am on "<node_url>"
    And I press the "List additional actions" button
    And I press "Save and Unpublish"
    And I am on "<node_url>"
    And I press the "List additional actions" button
  Then I should see the "Save and Keep Unpublished" button
  When I press "Save and Keep Unpublished"
    And I am on "<node_url>"
  Then I should see the text "Not published" in the "edit_meta" region

    Examples:
    | role             | node_url               |
    | bad_actors       | /idd/node/6202019/edit |
    | content_approver | /node/6202020/edit     |
    | sitebuilder      | /node/6202021/edit     |
    | content_approver | /node/6202022/edit     |
    | content_approver | /node/6202023/edit     |
    | sitebuilder      | /node/6202025/edit     |
    | content_approver | /node/6202027/edit     |
    | content_approver | /node/6202028/edit     |
    | content_approver | /node/6202029/edit     |
    | content_approver | /node/6202030/edit     |
    | content_approver | /node/6202031/edit     |
    | sitebuilder      | /node/6202032/edit     |

@api @javascript
Scenario Outline: No Save and Keep Unpublished Button For Published Content
  Given "ba" content:
    | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                          | field_date_filed | field_court | field_civ_action_no_ap_file_no | body            | status | nid     | moderation_state | field_action_number |
    | Jorge Clooney | Jorge            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Clooney Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.  | Test234                        | So original     | 1      | 6192019 | published        | DC-20002-A          |
    And "link" content:
      | title                  | field_description_abstract | field_url                             | status | field_publish_date  | field_tags   | moderation_state | nid     |
      | Investor.gov Page Link | Site Link Description      | Click Here - https://www.sec.gov      | 1      | 2019-08-17T17:00:00 | foiafreqdocs | published        | 6192020 |
    And "page" content:
      | title                  | body                                          | status | moderation_state | nid     |
      | Investor Page Investor | Behat Display Title https://www.investor.gov/ | 1      | published        | 6192021 |
    And "event" content:
      | title             | field_display_title | field_event_type | status | field_sec_event_date | field_sec_event_end_date | status | nid     | moderation_state |
      | event detail page | event display title | meeting          | 1      | +1 hour              | +4 hours                 | 1      | 6192023 | published        |
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title             | status | body             | field_primary_division_office | nid     |
      | Other                         | - None -                      | published        | This is the main title    | This is the display title       | 1      | This is the body | Agency-Wide                   | 6192027 |
    And "landing_page" content:
      | title                          | field_display_title            | field_primary_division_office | field_left_1_box | status | nid     | moderation_state |
      | Behat Simple Landing Page Test | behat simple landing page test | Credit Ratings                | Left 1           | 1      | 6192028 | published        |
    And "news" content:
      | field_news_type_news | field_primary_division_office | title                     | status | body                    | field_display_title       | nid     | moderation_state | field_release_number |
      | Press Release        | Agency-wide                   | Behat Simple PR News Test | 1      | This is the first body. | behat simple pr news test | 6192029 | published        | 2021-123             |
  When I am logged in as a user with the "<role>" role
    And I am on "<node_url>"
    And I press the "List additional actions" button
  Then I should not see the "Save and Keep Unpublished" button

    Examples:
    | role             | node_url               |
    | bad_actors       | /idd/node/6192019/edit |
    | content_approver | /node/6192020/edit     |
    | sitebuilder      | /node/6192021/edit     |
    | content_approver | /node/6192023/edit     |
    | content_approver | /node/6192027/edit     |
    | content_approver | /node/6192028/edit     |
    | content_approver | /node/6192029/edit     |
