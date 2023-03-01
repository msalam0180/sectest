Feature: Public IDD Search
  As a visitor
  When I visit the IDD Search Page, I want to search defendants database using a search box
  So that I can learn if they have actions against them

@api
#PASS- 05/16/2018
#Sprint 5 - update search page URL- Pass
Scenario: Access search view
#Given I am logged in as a user with the no role
  Given I am on "/litigations/sec-action-look-up"
  Then the response status code should be 200
    And I should see the text "SEC Action Lookup - Individuals" in the "contentbanner" region
    And I should see the text "Individuals with Court or Commission Orders Entered Against Them"
    And I should see the text "About this Feature"

@api
Scenario: Acquia Search Pages
  Given I am not logged in
  When I am on "/search"
  Then the response status code should be 403

@api @javascript
Scenario: IDD Last Name Solr Search
  Given I create "media" of type "static_file":
    | name            | field_display_title | field_media_file   | field_description_abstract | status |
    | Behat Text File | mark sinclair file  | behat-file-idd.txt | This is description abs    | 1      |
    | Behat PDF File  | jane doe file       | behat-file-idd.pdf | This is description abs    | 1      |
    And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                           | field_date_filed | field_court | field_civ_action_no_ap_file_no | body          | status | nid     | moderation_state | field_action_number |
      | Mark Sinclair | Vinny            | Diesel          | 53                    | Alabama         | State/Residence       | SEC v. Sinclair Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.  | Test234                        | So original   | 1      | 9192019 | published        | DC-20002-A          |
      | Jane Doe      | Jane             | Diesen          | 50                    | Alabama         | State/Residence       | SEC v. Doe Clan LLC. et al., 2017 CV 12345 (D. AR)      | 2011/2/4         | N. D. Ala.  | Test432                        | Very original | 1      | 9192020 | published        | DC-20003-A          |
  When I am logged in as a user with the "bad_actors" role
    And I visit "/node/9192019/edit"
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    And I fill in "field_related_documents[0][subform][field_static_file_media][0][target_id]" with "Behat Text File"
    And I publish it
    And I visit "/node/9192020/edit"
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    And I fill in "field_related_documents[0][subform][field_static_file_media][0][target_id]" with "Behat PDF File"
    And I publish it
    And I am logged in as a user with the "administrator" role
    And I visit "/admin/config/search/search-api/index/acquia_search_index"
    And I press "Queue all items for reindexing"
    And I press "Confirm"
    And I wait for AJAX to finish
    And I press "Clear all indexed data"
    And I press "Confirm"
    And I wait for AJAX to finish
    And I press "Rebuild tracking information"
    And I press "Confirm"
    And I wait 1 seconds
    And I press "Index now"
    And I wait 2 seconds
    And I run drush "cr"
    And I am not logged in
    And I visit "/litigations/sec-action-look-up"
    And I fill in "edit-last-name" with "Diese"
    And I press "SEARCH"
  Then I should see the text "Vinny Diesel"
    And I should see the text "Jane Diesen"
  When I click "mark sinclair file"
  Then I should be on "/files/behat-file-idd.txt"
    And I should see the text "I am a really bad actor!"
  When I move backward one page
    And I click "jane doe file"
  Then I should be on "/files/behat-file-idd.pdf"

#@api @javascript
#TODO: This doesn't work in env with lots of blocks, based on the note below this test can't be trusted not to throw a
#false negative. Rethink strategy.
#Sprint 5 - update search page URL-Pass
#Changes made to the "Block description" and "body" fields WILL be saved and remain in the system after the test execution is complete.
#Please check the existing values of the "Block description" and "body" fields before executing this test.
#Scenario: Editing About section
#Given I am logged in as a user with the "sitebuilder" role
#When I visit "/admin/structure/block/block-content"
#And I click "Edit" in the "About the IDD" row
#And I fill in "About" for "Block description"
#And I type "This is the body" in the "Body" WYSIWYG editor
#Text "This is teh body" will be added to the "body" field at the begining of the existing text in the feld.
#And I press the "Save" button
#And I visit "/litigations/sec-action-look-up"
#Then I should see the text "This is the body"

#Scripts below are currently being worked on- dependent on the ability to run Solr locally
  @javascript
  Scenario: Search for defendants by last name
##    When I fill in "Last Name (required)" with "Costanza"
#      And I press the "SEARCH" button
#    Then I should see the heading "George Constanza"
#      And I should not see the heading "Jerry Seinfeld"

  Scenario: Pagination
#  Given I am on "/litigations/sec-action-look-up"
#  When I fill in "Last Name (required)" with "Clark"
#  And I press the "SEARCH" button
#Then I should see the heading "George Constanza"
#  And I should see the link "Next"
#    And I should see the link "Last"
#    And I should see the text "1 to 25 of"

  Scenario: First Name and Last Name

  Scenario: Test Last Name Required
