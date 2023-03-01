Feature: Future Publish and Unpublish
  As a Content Approver to the SEC.gov
  I want to be able to create a content and then have it systematically published/unpublished at a future specified time
  So that I don't have to wait and do it manually

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Article Content
    Given I am logged in as a user with the "sitebuilder" role
    When I am on "/node/add/secarticle"
      And I fill in the following:
        | Title         | BEHAT Future Unpublish Test          |
        | Display Title | Behat Future Unpublish Display Title |
      And I select "Academic Publications" from "Article Type"
      And I type "I shall disappear" in the "List Page Details" WYSIWYG editor
      And I select "Economic and Risk Analysis" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I am on "/node/add/secarticle"
      And I fill in the following:
        | Title         | BEHAT Future Publish Test          |
        | Display Title | Behat Future Publish Display Title |
      And I select "Academic Publications" from "Article Type"
      And I type "I shall be seen" in the "List Page Details" WYSIWYG editor
      And I select "Economic and Risk Analysis" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Article" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish Test" row
      And I should see the text "No" in the "BEHAT Future Publish Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Person Content
    Given I am logged in as a user with the "sitebuilder" role
      And I visit "/node/add/secperson"
      And I fill in "Behat Person Future Unpublish Test" for "Title"
      And I fill in the following:
        | First Name | John  |
        | Last Name  | Behat |
      And I select "Other" from "Position Category"
      And I check "Current Position"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 06-07-2018 |
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 01-03-2019 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I publish it
      And I visit "/node/add/secperson"
      And I fill in "Behat Person Future Publish Test" for "Title"
      And I fill in the following:
        | First Name | Jane  |
        | Last Name  | Behat |
      And I select "Other" from "Position Category"
      And I check "Current Position"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 06-07-2018 |
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 01-03-2019 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 10:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Person" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "Behat Person Future Unpublish Test" row
      And I should see the text "No" in the "Behat Person Future Publish Test" row
      #For unknown reason, running cron using "And I run cron" doesn't seem to complete the cron run for this particular test. However, if I were to run cron through command line, it will work.  For now, using steps to run cron through GUI as a workaround
      And I visit "/admin/config/sec/cron/settings"
      And I press the "Run cron now" button
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Person" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "No" in the "Behat Person Future Unpublish Test" row
      And I should see the text "Yes" in the "Behat Person Future Publish Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Event
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/event"
      And I fill in "BEHAT Future Unpublish Event Test" for "Title"
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/event"
      And I fill in "BEHAT Future Publish Event Test" for "Title"
      And I select "SEC Meetings and Other Events" from "Event Type"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Event" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish Event Test" row
      And I should see the text "No" in the "BEHAT Future Publish Event Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish Event Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish Event Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Press Release
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/news"
      And I select "Press Release" from "News Type"
      And I fill in "BEHAT Future Unpublish News Test" for "Title"
      And I fill in "Display Title" with "My past new press release"
      And I fill in "Release Number" with "123"
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/news"
      And I select "Press Release" from "News Type"
      And I fill in "BEHAT Future Publish News Test" for "Title"
      And I fill in "Display Title" with "My future new press release"
      And I fill in "Release Number" with "123"
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "News" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "No" in the "BEHAT Future Publish News Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish News Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Statement
    Given "secperson" content:
      | title    | field_first_name_secperson | field_last_name_secperson | status | moderation_state |
      | Person 1 | John                       | Doe                       | 1      | published        |
      | Person 2 | Jane                       | Doe                       | 1      | published        |
      And I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/news"
      And I select "Statement" from "News Type"
      And I fill in "BEHAT Future Unpublish News Test" for "Title"
      And I fill in "Display Title" with "My past new statement"
      And I fill in "Description/Abstract" with "123 Statement"
      And I select the first autocomplete option for "Person 1" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/news"
      And I select "Statement" from "News Type"
      And I fill in "BEHAT Future Publish News Test" for "Title"
      And I fill in "Display Title" with "My future new statement"
      And I fill in "Description/Abstract" with "456 Statement"
      And I select the first autocomplete option for "Person 2" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "News" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "No" in the "BEHAT Future Publish News Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish News Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for PS Without Speaker
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/news"
      And I select "Statement" from "News Type"
      And I fill in "BEHAT Future Unpublish News Test 2" for "Title"
      And I fill in "Display Title" with "My past new statement"
      And I fill in "Description/Abstract" with "123 Statement"
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/news"
      And I select "Statement" from "News Type"
      And I fill in "BEHAT Future Publish News Test 2" for "Title"
      And I fill in "Display Title" with "My future new statement"
      And I fill in "Description/Abstract" with "456 Statement"
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "News" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish News Test 2" row
      And I should see the text "No" in the "BEHAT Future Publish News Test 2" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish News Test 2" row
      And I should see the text "Yes" in the "BEHAT Future Publish News Test 2" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Speech
    Given "secperson" content:
      | title    | field_first_name_secperson | field_last_name_secperson | status | moderation_state |
      | Person 1 | John                       | Doe                       | 1      | published        |
      | Person 2 | Jane                       | Doe                       | 1      | published        |
      And I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/news"
      And I select "Speech" from "News Type"
      And I fill in "BEHAT Future Unpublish News Test" for "Title"
      And I fill in "Display Title" with "My past new speech"
      And I fill in "Description/Abstract" with "123 Speech"
      And I select the first autocomplete option for "Person 1" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/news"
      And I select "Speech" from "News Type"
      And I fill in "BEHAT Future Publish News Test" for "Title"
      And I fill in "Display Title" with "My future new speech"
      And I fill in "Description/Abstract" with "456 Speech"
      And I select the first autocomplete option for "Person 2" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "News" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "No" in the "BEHAT Future Publish News Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish News Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Testimony
    Given "secperson" content:
      | title    | field_first_name_secperson | field_last_name_secperson | status | moderation_state |
      | Person 1 | John                       | Doe                       | 1      | published        |
      | Person 2 | Jane                       | Doe                       | 1      | published        |
      And I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/news"
      And I select "Testimony" from "News Type"
      And I fill in "BEHAT Future Unpublish News Test" for "Title"
      And I fill in "Display Title" with "My past new testimony"
      And I fill in "Description/Abstract" with "123 Testimony"
      And I select the first autocomplete option for "Person 1" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I scroll to the bottom
      And I publish it
      And I visit "/node/add/news"
      And I select "Testimony" from "News Type"
      And I fill in "BEHAT Future Publish News Test" for "Title"
      And I fill in "Display Title" with "My future new testimony"
      And I fill in "Description/Abstract" with "456 Testimony"
      And I select the first autocomplete option for "Person 2" on the "Speaker" field
      And I select "Agency-Wide" from "Primary Division/Office"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press "Save and Create New Draft"
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "News" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "No" in the "BEHAT Future Publish News Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish News Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish News Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Image
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/image"
      And I fill in "BEHAT Future Unpublish Image Test" for "Title"
      And I attach the file "behat-bird.gif" to "Image Upload"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Yellow Birdy"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I publish it
      And I visit "/node/add/image"
      And I fill in "BEHAT Future Publish Image Test" for "Title"
      And I attach the file "behat-rabbit.jpg" to "Image Upload"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Black Rabbit"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press the "List additional actions" button
      And I press the "Save and Create New Draft" button
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Image" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish Image Test" row
      And I should see the text "No" in the "BEHAT Future Publish Image Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish Image Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish Image Test" row

  @api @javascript
  Scenario: Scheduled Publishing and Unpublishing for Link
    Given I am logged in as a user with the "sitebuilder" role
    When I visit "/node/add/link"
      And I fill in "BEHAT Future Unpublish Link Test" for "Title"
      And I fill in "https://www.sec.gov" for "URL"
      And I fill in "Click Me" for "Link text"
      And I select "Unpublish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00AM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I publish it
      And I visit "/node/add/link"
      And I fill in "BEHAT Future Publish Link Test" for "Title"
      And I fill in "mailto:test@testemail.com" for "URL"
      And I fill in "Click Me" for "Link text"
      And I select "Publish On" from "edit-scheduling-options-actions-bundle"
      And I press "Add new Scheduling Options"
      And I wait for ajax to finish
      And I fill in the following:
        | scheduling_options[form][0][update_timestamp][0][value][date] | 12-19-2018 |
        | scheduling_options[form][0][update_timestamp][0][value][time] | 12:00:00PM |
      And I press "Create Scheduling Options"
      And I wait for ajax to finish
      And I press the "List additional actions" button
      And I press the "Save and Unpublish" button
    When I visit "/admin/workbench/content/all"
      And I select "All" from "Published"
      And I select "Link" from "Type"
      And I press the "Apply" button
      And I wait for ajax to finish
    Then I should see the text "Yes" in the "BEHAT Future Unpublish Link Test" row
      And I should see the text "No" in the "BEHAT Future Publish Link Test" row
    When I run cron
      And I press the "Apply" button
    Then I should see the text "No" in the "BEHAT Future Unpublish Link Test" row
      And I should see the text "Yes" in the "BEHAT Future Publish Link Test" row

  @api @javascript
  Scenario: Scheduled To Close Node-Based Rule Making Comments Form
    Given "customized_comment_form" content:
      | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
      | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
      And I am logged in as a user with the "webform, sitebuilder" role
    When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1/edit"
      And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
      And I select the radio button "Scheduled"
      And I fill in the following:
        | field_custom_webform_attachment[0][settings][scheduled][close][date] | 02/15/2022 |
        | field_custom_webform_attachment[0][settings][scheduled][close][time] | 12:00:00PM |
      And I publish it
    Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form by enduser 1 has been updated."
    When I am not logged in
      And I visit "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
    Then I should see the text "This form is closed to new submissions."

  @api @javascript
  Scenario: Scheduled To Open Node-Based Rule Making Comments Form
    Given "customized_comment_form" content:
      | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
      | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
      And I am logged in as a user with the "webform, sitebuilder" role
    When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1/edit"
      And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
      And I select the radio button "Scheduled"
      And I fill in the following:
        | field_custom_webform_attachment[0][settings][scheduled][open][date]  | 02/01/2022 |
        | field_custom_webform_attachment[0][settings][scheduled][open][time]  | 12:00:00PM |
      And I publish it
    Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form by enduser 1 has been updated."
    When I am not logged in
      And I visit "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
    Then I should see the text "Submit Comments on ab-12-cd"
