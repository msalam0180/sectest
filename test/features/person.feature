Feature: Test Person Content Type
  As a Content Creator
  I want to be able to create person content
  So that visitors to SEC.gov can learn about the person

  @api @javascript
  Scenario: Create Person Content Through the UI
    Given I am logged in as a user with the "Sitebuilder" role
    When I visit "/node/add/secperson"
      And I fill in "John Doe Behat" for "Title"
      And I fill in the following:
        | First Name | John  |
        | Last Name  | Behat |
      And I type "John Doe Behat was named Automation Tester of the SEC.GOV O&M Team in June 2018. Before joining the SEC.GOV O&M Team, Mr. Behat spent 3 years working on Behat. Mr. Behat received his Behat certification online." in the "Body" WYSIWYG editor
      And I select "Other" from "Position Category"
      And I check "Current Position"
      And I fill in "Director of Behat" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 06-07-2018 |
      And I attach the file "behat-person.gif" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Mr. Behat"
      And I publish it
    Then I should see the text "John Behat Director of Behat"
      And I should see the "img" element with the "alt" attribute set to "Mr. Behat" in the "contentarea" region

  @api
  Scenario: Viewing a Person Content
    Given I am viewing an "secperson" content:
      | title                       | Behat Person Content Test                           |
      | field_first_name_secperson  | John D.                                             |
      | field_last_name_secperson   | Behat                                               |
      | status                      | 1                                                   |
      | body                        | John Doe Behat was named the new Director of Behat. |
      | field_enable_biography_page | 1                                                   |
    Then I should see the heading "Biography"
      And I should see the text "John D. Behat"
      And I should see the text "John Doe Behat was named the new Director of Behat."

  @api @javascript
  Scenario: Delete a Person Content
    Given I am logged in as a user with the "sitebuilder" role
      And "secperson" content:
      | title                     | field_first_name_secperson | field_last_name_secperson |
      | Behat Person Content Test | John                       | Behat                     |
    When I visit "/admin/content"
      And I click "Edit" in the "Behat Person Content Test" row
      And I click "edit-delete"
      And I press the "Delete" button
    Then I should see the text "The Person Behat Person Content Test has been deleted"
      And I should not see the link "Behat Person Content Test"

  @api @javascript
  Scenario: View More Speeches, Statements, Press Release and Testimony By Person
    Given "secperson" content:
      | title      | field_first_name_secperson | field_last_name_secperson | body                                                                               | field_enable_biography_page | status |
      | John Behat | John                       | Behat                     | John started working with behat in 2017 and has been maintaining behat ever since. | 1                           | 1      |
      | Jane Behat | Jane                       | Behat                     | Jane started working with behat in 2018 and has been maintaining behat ever since. | 1                           | 1      |
      | Dave Behat | Dave                       | Behat                     | Dave started working with behat in 2019 and has been maintaining behat ever since. | 1                           | 1      |
      | Jack Behat | Jack                       | Behat                     | Jack started working with behat in 2016 and has been maintaining behat ever since. | 1                           | 1      |
      And I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
      And "news" content:
      | field_news_type_news | field_primary_division_office | title           | status | field_description_abstract     | field_display_title             | field_publish_date  | field_person | field_media_file_upload | body         |
      | Speech               | Agency-wide                   | Speech 1        | 1      | Speech by Behat Tester         | Speech 1 by Behat Tester        | 2018-11-11 12:00:00 | John Behat   | Behat File              |  |
      | Speech               | Agency-wide                   | Speech 2        | 1      | Speech by Behat Tester         | Speech 2 by Behat Tester        | 2018-12-01 12:00:00 | John Behat   | Behat File              | this is body |
      | Speech               | Agency-wide                   | Speech 3        | 1      | Speech by Behat Tester         | Speech 3 by Behat Tester        | 2017-06-13 16:00:00 | John Behat   | Behat File              |              |
      | Speech               | Agency-wide                   | Speech 4        | 1      | Speech by Behat Tester         | Speech 4 by Behat Tester        | 2016-12-19 12:00:00 | John Behat   | Behat File              |              |
      | Speech               | Agency-wide                   | Speech 5        | 1      | Speech by Behat Tester         | Speech 5 by Behat Tester        | 2016-06-13 16:00:00 | John Behat   | Behat File              |              |
      | Speech               | Agency-wide                   | Speech 6        | 1      | Speech by Behat Tester         | Speech 6 by Behat Tester        | 2017-12-17 12:00:00 | Jane Behat   | Behat File              |              |
      | Speech               | Agency-wide                   | Speech 7        | 1      | Speech by Behat Tester         | Speech 7 by Behat Tester        | 2017-12-18 12:00:00 | Dave Behat   | Behat File              |              |
      | Speech               | Agency-wide                   | Speech 8        | 1      | Speech by Behat Tester         | Speech 8 by Behat Tester        | 2017-06-19 16:00:00 | Jack Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 1     | 1      | Testimony by Behat Tester      | Testimony 1 by Behat Tester     | 2018-05-12 11:00:00 | John Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 2     | 1      | Testimony by Behat Tester      | Testimony 2 by Behat Tester     | 2018-07-10 12:00:00 | John Behat   | Behat File              | this is body |
      | Testimony            | Agency-wide                   | Testimony 3     | 1      | Testimony by Behat Tester      | Testimony 3 by Behat Tester     | 2018-06-13 12:00:00 | John Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 4     | 1      | Testimony by Behat Tester      | Testimony 4 by Behat Tester     | 2018-09-14 12:00:00 | Jane Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 5     | 1      | Testimony by Behat Tester      | Testimony 5 by Behat Tester     | 2018-07-12 12:00:00 | Dave Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 6     | 1      | Testimony by Behat Tester      | Testimony 6 by Behat Tester     | 2017-06-23 12:00:00 | Jack Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 7     | 1      | Testimony by Behat Tester      | Testimony 7 by Behat Tester     | 2017-06-19 12:00:00 | Jane Behat   | Behat File              |              |
      | Testimony            | Agency-wide                   | Testimony 8     | 1      | Testimony by Behat Tester      | Testimony 8 by Behat Tester     | 2018-11-20 12:00:00 | John Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 1 | 1      | Statement by Behat Tester      | Statement 1 by Behat Tester     | 2018-09-11 12:00:00 | John Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 2 | 1      | Statement by Behat Tester      | Statement 2 by Behat Tester     | 2018-10-10 12:00:00 | John Behat   | Behat File              | this is body |
      | Statement            | Agency-wide                   | Pub Statement 3 | 1      | Statement by Behat Tester      | Statement 3 by Behat Tester     | 2017-06-13 12:00:00 | Dave Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 4 | 1      | Statement by Behat Tester      | Statement 4 by Behat Tester     | 2018-07-11 12:00:00 | John Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 5 | 1      | Statement by Behat Tester      | Statement 5 by Behat Tester     | 2018-07-10 12:00:00 | Jack Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 6 | 1      | Statement by Behat Tester      | Statement 6 by Behat Tester     | 2018-06-13 12:00:00 | John Behat   | Behat File              |              |
      | Statement            | Agency-wide                   | Pub Statement 7 | 1      | Statement by Behat Tester      | Statement 7 by Behat Tester     | 2016-05-11 12:00:00 | Jane Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 1 | 1      | Press release by Behat Tester  | Press release 1 by Behat Tester | 2018-03-11 12:00:00 | John Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 2 | 1      | Press release by Behat Tester  | Press release 2 by Behat Tester | 2018-06-10 12:00:00 | John Behat   | Behat File              | this is body |
      | Press Release        | Agency-wide                   | Press release 3 | 1      | Press release by Behat Tester  | Press release 3 by Behat Tester | 2017-06-13 12:00:00 | Dave Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 4 | 1      | Press release by Behat Tester  | Press release 4 by Behat Tester | 2018-07-11 12:00:00 | John Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 5 | 1      | Press release by Behat Tester  | Press release 5 by Behat Tester | 2017-07-10 12:00:00 | Jack Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 6 | 1      | Press release by Behat Tester  | Press release 6 by Behat Tester | 2018-11-13 12:00:00 | John Behat   | Behat File              |              |
      | Press Release        | Agency-wide                   | Press release 7 | 1      | Press release by Behat Tester  | Press release 7 by Behat Tester | 2018-11-11 12:00:00 | Jane Behat   | Behat File              |              |
    When I visit "/biography/john-behat"
      # Validate that the listed speeches, statements, press releases and testimony on the biography page should be 3 most recent
    Then I should see the link "Speech 1 by Behat Tester (PDF)" in the "person_related_speeches" region
      And I should see the link "Speech 3 by Behat Tester (PDF)" in the "person_related_speeches" region
      And I should not see the link "Speech 2 by Behat Tester (PDF)" in the "person_related_speeches" region
      And I should see the link "Speech 2 by Behat Tester" before I see the link "Speech 1 by Behat Tester (PDF)" in the "Person Related Speeches" view
      And I should not see the link "Speech 7 by Behat Tester (PDF)" in the "person_related_speeches" region
      And I should see the link "Statement 1 by Behat Tester (PDF)" in the "person_related_statement" region
      And I should see the link "Statement 4 by Behat Tester (PDF)" in the "person_related_statement" region
      And I should not see the link "Statement 2 by Behat Tester (PDF)" in the "person_related_statement" region
      And I should see the link "Statement 2 by Behat Tester" before I see the link "Statement 1 by Behat Tester (PDF)" in the "Person Related Public Statements" view
      And I should not see the link "Statement 7 by Behat Tester (PDF)" in the "person_related_statement" region
      And I should see the link "Testimony 8 by Behat Tester (PDF)" in the "person_related_testimony" region
      And I should see the link "Testimony 3 by Behat Tester (PDF)" in the "person_related_testimony" region
      And I should not see the link "Testimony 2 by Behat Tester (PDF)" in the "person_related_testimony" region
      And I should see the link "Testimony 2 by Behat Tester" before I see the link "Testimony 3 by Behat Tester (PDF)" in the "Person Related Testimonials" view
      And I should not see the link "Testimony 1 by Behat Tester (PDF)" in the "person_related_testimony" region
      And I should see the link "Press release 6 by Behat Tester (PDF)" in the "person_related_press-releases" region
      And I should see the link "Press release 4 by Behat Tester (PDF)" in the "person_related_press-releases" region
      And I should not see the link "Press release 2 by Behat Tester (PDF)" in the "person_related_press-releases" region
      And I should see the link "Press release 6 by Behat Tester (PDF)" before I see the link "Press release 2 by Behat Tester" in the "Person Related Press Releases" view
      And I should not see the link "Press release 7 by Behat Tester (PDF)" in the "person_related_press-releases" region
      # Validate that the link to view additional speeches and statements by the person is available
    When I click "View More by John Behat"
    Then I should see the heading "Speeches and Statements"
      # Validate that the list page should be filtered to show speeches of the person from biography page only
      And I should see the link "Speech 1 by Behat Tester"
      And I should see the text "John Behat" in the "Speech 1 by Behat Tester" row
      And I should see the link "Speech 4 by Behat Tester"
      And I should see the text "John Behat" in the "Speech 4 by Behat Tester" row
      And I should see the link "Speech 5 by Behat Tester"
      And I should see the text "John Behat" in the "Speech 5 by Behat Tester" row
      But I should not see the link "Speech 6 by Behat Tester"
      And I should not see the link "Speech 7 by Behat Tester"
      And I should not see the link "Speech 8 by Behat Tester"
      And I should see the link "Statement 1 by Behat Tester"
      And I should see the text "John Behat" in the "Statement 1 by Behat Tester" row
      And I should see the link "Statement 2 by Behat Tester"
      And I should see the text "John Behat" in the "Statement 2 by Behat Tester" row
      And I should see the link "Statement 4 by Behat Tester"
      And I should see the text "John Behat" in the "Statement 4 by Behat Tester" row
      But I should not see the link "Statement 3 by Behat Tester"
      And I should not see the link "Statement 5 by Behat Tester"
      And I should not see the link "Statement 7 by Behat Tester"
      And I should see the link "Testimony 1 by Behat Tester"
      And I should see the text "John Behat" in the "Testimony 1 by Behat Tester" row
      And I should see the link "Testimony 2 by Behat Tester"
      And I should see the text "John Behat" in the "Testimony 2 by Behat Tester" row
      And I should see the link "Testimony 3 by Behat Tester"
      And I should see the text "John Behat" in the "Testimony 3 by Behat Tester" row
      And I should see the link "Testimony 8 by Behat Tester"
      And I should see the text "John Behat" in the "Testimony 8 by Behat Tester" row
      But I should not see the link "Testimony 4 by Behat Tester"
      And I should not see the link "Testimony 5 by Behat Tester"
      And I should not see the link "Testimony 6 by Behat Tester"

  @api @javascript
  Scenario: Person Selection Of No Menu Option
    Given I am logged in as a user with the "division_office_admin" role
    When I visit "node/add/secperson"
      And I fill in "Title" with "Testing Ticket 13643"
      And I fill in the following:
        | First Name | John  |
        | Last Name  | Behat |
      And I select "Enforcement" from "Primary Division/Office"
      And I select "Enforcement" from "Override Left Navigation"
      And I select "Other" from "Position Category"
      And I check "Current Position"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 05/21/2020 |
      And I publish it
    Then I should see the text "Biography"
      And I should see the text "John Behat"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"
      And I click the panelizer "Edit" link
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "No Menu" from "Override Left Navigation"
      And I publish it
    Then I should see the text "Biography"
      And I should see the text "John Behat"
      And I should not see the text "Enforcement Manual"
      And I should not see the text "Public Alerts"
      And I should not see the text "Federal Court Actions"
      And I click the panelizer "Edit" link
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "Enforcement" from "Override Left Navigation"
      And I publish it
    Then I should see the text "Biography"
      And I should see the text "John Behat"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"
