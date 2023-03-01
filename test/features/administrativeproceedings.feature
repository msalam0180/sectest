Feature: Administrative Proceedings File Number Open/Close and Rulemaking Index
As a user to the site, I should be able to view Administrative Proceedings related content

@api @javascript
Scenario: Authenticated User Can View AP Open/Close
  Given "rulemaking_index" terms:
      | name   | field_ap_status | tid  |
      | Open1  | Open            | 1234 |
      | Open2  | Open            |      |
      | Close1 | Closed          |      |
      | Close2 | Closed          | 4321 |
    And "release" content:
      | title | field_release_type         | field_release_number | field_release_file_number | field_respondents        | moderation_state |
      | AP1   | Administrative Proceedings | Open1                | Open1                     | Allen Kelly George Smith | published        |
      | AP2   | Administrative Proceedings | Open2                | Open2                     | Beverly                  | published        |
      | AP3   | Administrative Proceedings | Close1               | Close1                    | Caroline                 | published        |
      | AP4   | Administrative Proceedings | Close2               | Close2                    | David                    | published        |
      | AP5   | Administrative Proceedings | Close2               | Close2                    | James                    | published        |
    And I am logged in as a user with the "authenticated" role
  When I am on "/litigation/apdocuments/ap-closed-fileno-asc?order=name&sort=desc"
  Then I should see the link "Open Administrative Proceeding Cases"
    And I should not see the link "Enforcement Manual"
    And I should see the link "Close2"
    And I should see the text "David"
    And I should see the link "Close1"
    And I should see the text "Caroline"
    And "David" should precede "Caroline" for the query "//td[contains(@class, 'views-field views-field-nothing')]"
  When I click "Close2"
  Then I should see the heading "Administrative Proceeding File No. Close2"
    And I should not see the link "Enforcement Manual"
    And I should see "AP4"
    And I should see "AP5"
 When I am on "/litigation/admin/AP4"
  Then I should see the heading "David"
  When I am on "/litigation/apdocuments/ap-open-fileno-asc?order=name&sort=desc"
  Then I should see the link "Closed Administrative Proceeding Cases"
    And I should not see the link "Enforcement Manual"
    And I should see the link "Open2"
    And I should see the text "Beverly"
    And I should see the link "Open1"
    And I should see the text "Allen"
    And "Beverly" should precede "Allen Kelly George Smith" for the query "//td[contains(@class, 'views-field views-field-nothing')]"
  When I click "Open1"
  Then I should see the heading "Administrative Proceeding File No. Open1"
    And I should see "AP1"
  When I am on "litigation/admin/AP1"
  Then I should see the heading "Allen Kelly George Smith"
  When I am logged in as a user with the "Content Approver" role
    And I am on "/litigation/admin/ap5/edit"
    And I select the first autocomplete option for "Open1" on the "File Number" field
    And I press "Save"
    And I am on "/litigation/apdocuments/Open1"
  Then I should see "AP1"
    And I should see "AP5"
  When I visit "/litigation/apdocuments/Close2"
  Then I should see "AP4"
    And I should not see "AP5"

@api @javascript
Scenario: Adminstrative Proceeding Rulemaking Taxonomy Respondent And Document View
  Given "rulemaking_index" terms:
      | name     |
      | ui-98-po |
    And I create "media" of type "static_file":
      | name          | field_display_title | field_media_file    | field_description_abstract | status | field_publish_date  |
      | Behat 1stFile | published media     | behat-file_data.pdf | This is description abs    | 1      | 2021-01-02 12:00:00 |
      | Behat 2ndFile | published media2    | behat-file_data.pdf |                            | 1      | 2021-01-01 12:00:00 |
      | Behat 3rdFile | some static file    | behat-file_data.pdf |                            | 1      | 2021-04-12 12:00:00 |
      | Behat 4thFile | july 4th            | behat-file_data.pdf | July 5th                   | 1      | 2021-04-13 12:00:00 |
    And "release" content:
      | title | field_release_type         | field_release_number | field_release_file_number | field_respondents        | moderation_state | field_publish_date  | field_release_file | body  |
      | AP1   | Administrative Proceedings | 123, 644             | ui-98-po                  | Allen Kelly George Smith | published        | 2021-01-02 12:00:00 | Behat 1stFile      | behat |
      | AP2   | Administrative Proceedings | 432, 9854,289        | ui-98-po                  | Beverly                  | published        | 2021-02-14 12:00:00 |                    | body1 |
      | AP3   | Administrative Proceedings | 654, Abc             | ui-98-po                  | Caroline                 | published        | 2021-03-15 12:00:00 |                    | body2 |
      | AP4   | Administrative Proceedings |                      | ui-98-po                  | Jack                     | published        | 2022-06-30 12:00:00 | Behat 2ndFile      | Body4 |
    And I am logged in as a user with the "authenticated" role
  When I visit "/litigation/apdocuments/ui-98-po"
  Then I should see the heading "Administrative Proceeding File No. ui-98-po"
    And I should see the heading "Respondents"
    And I should see the text "Allen Kelly George Smith"
    And I should see the text "Beverly"
    And I should see the text "Caroline"
    And I should see the text "Jack"
    And I should see the heading "Documents"
    And I should not see "Jan. 1, 2021"
    And I should not see "some static file"
    And I should see the text "Jan. 2, 2021"
    And I should see the "a" element with the "href" attribute set to "/files/behat-file_data.pdf" in the "contentarea" region
    And I should see the "a" element with the "href" attribute set to "/litigation/admin/ap2" in the "contentarea" region
    And I should see "123" in the "Jan. 2, 2021" row
    And I should see "644" in the "Jan. 2, 2021" row
    And I should see "This is description abs" in the "Jan. 2, 2021" row
    And I should see "432" in the "Feb. 14, 2021" row
    And I should see "9854" in the "Feb. 14, 2021" row
    And I should see "AP2" in the "Feb. 14, 2021" row
    And I should see "654" in the "March 15, 2021" row
    And I should see "Abc" in the "March 15, 2021" row
    And I should see "AP3" in the "March 15, 2021" row
    And I should see "published media2" in the "June 30, 2022" row
    And "Jan. 2, 2021" should precede "Feb. 14, 2021" for the query "//td[contains(@class, 'views-field views-field-field-publish-date')]"
    And "123" should precede "654" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "644" should precede "Abc" for the query "//td[contains(@class, 'views-field views-field-field-release-number-1')]"
    And "This is description abs" should precede "AP2" for the query "//td[contains(@class, 'views-field views-field-nothing')]"
  When I am logged in as a user with the "Content Approver" role
    And I visit "/file/behat-3rdfile/edit"
    And I fill in "Release File Number" with "ui-98-po"
    And I fill in "edit-field-publish-date-0-value-date" with "01-01-2021"
    And I fill in "edit-field-publish-date-0-value-time" with "12:48:29PM"
    And I select "Enforcement" from "Primary Division/Office"
    And I press "Save"
    And I visit "/file/behat-4thfile/edit"
    And I fill in "Release File Number" with "ui-98-po"
    And I fill in "edit-field-publish-date-0-value-date" with "01-10-2021"
    And I fill in "edit-field-publish-date-0-value-time" with "12:48:29PM"
    And I select "Enforcement" from "Primary Division/Office"
    And I press "Save"
    And I am logged in as a user with the "authenticated" role
    And I visit "/litigation/apdocuments/ui-98-po"
  Then I should see "static file" in the "Jan. 1, 2021" row
    And I should see "July 5th" in the "Jan. 10, 2021" row
    And I should not see "july 4th" in the "Jan. 10, 2021" row
