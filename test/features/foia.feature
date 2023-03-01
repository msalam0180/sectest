Feature: Verify Articles with PDF in foia list view
  As a user of the site
  I want to be able to upload PDF
  So that when I click on the link it should open a PDF

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for foia
  Given I create "media" of type "static_file":
      | name              | field_media_file           | status |
      | Behat Test File 1 | behat-file_foia.pdf        | 1      |
      | Behat Test File 2 | behat-file_foiafq_docs.pdf | 1      |
    And "secarticle" content:
      | title                                                                         | field_tags    |  field_display_title                                                           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file having article type as announcement and foia-freq-do as tags  | foia-freq-doc |  Verify PDF file having article type as announcement and foia-freq-do as tags  | Some random text               | 2019-09-17T17:00:00 | 2019-09-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
      | Verify PDF file having article type as announcement and foiafreqdocs as tags  | foiafreqdocs  |  Verify PDF file having article type as announcement and foiafreqdocs as tags  | Some random text               | 2019-09-17T17:00:00 | 2019-09-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
    And I am logged in as a user with the "Content Approver" role
  When I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as announcement and foia-freq-do as tags" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File 1" on the "Use existing media" field
    And I wait for AJAX to finish
    And I publish it
    And I am on "/foia-frequently-requested-documents"
    And I scroll to the bottom
  Then I should see the link "Verify PDF file having article type as announcement and foia-freq-do as tags"
    And I click "Verify PDF file having article type as announcement and foia-freq-do as tags"
  Then I should be on "/files/behat-file_foia.pdf"
  When I visit "/admin/content"
    And I wait 2 seconds
    And I click "Edit" in the "Verify PDF file having article type as announcement and foiafreqdocs as tags" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File 2" on the "Use existing media" field
    And I wait for AJAX to finish
    And I publish it
    And I am on "/foia-frequently-requested-documents"
    And I scroll to the bottom
  Then I should see the link "Verify PDF file having article type as announcement and foiafreqdocs as tags"
    And I click "Verify PDF file having article type as announcement and foiafreqdocs as tags"
  Then I should be on "/files/behat-file_foiafq_docs.pdf"
