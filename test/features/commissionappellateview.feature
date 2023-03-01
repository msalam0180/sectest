Feature: Commission Appellate Court Briefs View
As a sec.gov site visitor, I should be able to view commssion applete court briefs.

@api @javascript
Scenario: Confirm Commission Appellate Court List View
  Given I create "media" of type "static_file":
    | name                      | field_display_title | field_media_file       | field_description_abstract | status |
    | Behat Cats Static 1stFile | published media     | behat-file_data.pdf    | This is description abs    | 1      |
    | Behat File                | published media2    | behat-file_corpfin.pdf | this is some descriotion   | 1      |
    And I create "media" of type "image_media":
      | name              | field_media_image | field_media_caption | status | mid    |
      | Behat Puppy Image | behat-puppy.jpg   | This is a puppy     | 1      | 902100 |
    And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | moderation_state | title             | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
      | Appellate Brief               | Behat File              | published        | Behat for Article | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      |                     |
      | Appellate Brief               |                         | published        | Behat for Article | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details2     | 2019-07-25T17:00:00 |
      | Appellate Brief               |                         |                  | Behat for Article | No Show             | 0      | Normal text      | Enforcement                   | 2019-04-18T17:00:00 | This is list page details      |                     |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Appellate Brief" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Appellate Brief"
    And I fill in "Display Title" with "BEHAT Commission Appellate Brief View"
    And I scroll "#edit-field-list-page-det-secarticle-wrapper" into view
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "List Page Details" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I fill in "/media/902100" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Cats Static 1stFile" on the "field_media_file_upload[0][target_id]" field
    And I select "Acquisitions" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "BEHAT Commission Appellate Brief View"
  When I am logged in as a user with the "authenticated" role
    And I am on "/litigation/appellatebriefs"
  Then I should see the heading "Commission Appellate Court Briefs"
    And I should see the text "This page provides links to some of the legal briefs the Commission's staff submitted in various court actions. See also:"
    And I should see the link "Enforcement" in the navigation region
    And I should see the link "Commission Amicus / Friend of the Court Briefs"
    And I should see the link "Request for Commission Amicus Participation in a Pending Case"
    And "May 2020" should precede "July 2019" for the query "//td[contains(@class, 'views-field-field-publish-date')]"
    And I should see "BEHAT Link Title (PDF)" in the "May 2020" row
    And I should not see "This is the body" in the "May 2020" row
    And I should see "This is list page details" in the "May 2020" row
    And I should see "Basic Article Title" in the "July 2019" row
    And I should not see "Normal text" in the "July 2019" row
    And I should see "This is list page details2" in the "July 2019" row
    And I should not see the text "No Show"
    And I should see the text "1 to 3 of 3 items"
  When I click "BEHAT Link Title (PDF)"
  Then I should be on "/files/behat-file_corpfin.pdf"
  When I move backward one page
    And I click "BEHAT Commission Appellate Brief View (PDF)"
  Then I should be on "/files/behat-file_data.pdf"
  When I move backward one page
    And I click "/media/902100"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-puppy.jpg" in the "contentarea" region
  When I move backward one page
    And I click "Basic Article Title"
  Then I should see the heading "Basic Article Title"
    And I should see the text "Normal text"
    And I should see the text "July 25, 2019" in the "node_page_modified_date" region
