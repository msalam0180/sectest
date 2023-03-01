Feature: IDD Content Type
  As an administrator or bad_actors role user
  I want to be able to create bad actor records
  So that visitors to SEC.gov can learn about individuals with actions against SEC

  Background:
    Given I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file  | field_description_abstract | status | mid     |
      | Behat Test File | aaaTest static file  | behat-idd.pdf     | This is description abs    | 1      | 9242020 |

@api @javascript
Scenario: Create an IDD record through the UI
  Given I am logged in as a user with the "bad_actors" role
  When I visit "/node/add/ba"
    And I select "AP" from "AP/USDC"
    And I fill in "Sandra Edward Graham" for "Individual Name in Document"
    And I fill in the following:
      | First 			                  | Sandra        |
	    | MI				                    | Edward        |
      | Last                          | Graham        |
      | Suffix                        | III           |
      | Entity Name                   | MaryJane LLC. |
      | field_also_known_as[0][value] | Sandy         |
      | Age in Document               | 33            |
      | Action Name in document       | testing123    |
      | title[0][value]               | ActionId123   |
      | field_action_number[0][value] | ActionNo123   |
      | Date                          | 03/23/2015    |
      | Civ. Action No. /AP File No   | test234       |
    And I select "California" from "State"
    And I select "State/Residence" from "Basis for State"
    And I select "N.D. Ala." from "Court"
    And I type "This is Other Information" in the "Other Information" WYSIWYG editor
    And I select "Yes-Affirmed" from "Judgment/Final Order Appealed"
    And I fill in "field_judgment_date[0][value][date]" with "03/24/2015"
    And I type "These are CMS Notes" in the "CMS Notes" WYSIWYG editor
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    And I fill in "field_related_documents[0][subform][field_document_date][0][value][date]" with "05/04/2015"
    And I select the first autocomplete option for "BEHAT Test File" on the "field_related_documents[0][subform][field_static_file_media][0][target_id]" field
    And I select "Reinstatement" from "Document Type"
    And I publish it
  Then I should see the text "Individual Defendant ActionId123 has been created"
    And I click "ActionId123" in the status_message region
    And I should see the text "ActionNo123"
    And I should see the text "Related Document(s)"
    And I should see the text "Behat Test File"

@api @javascript
Scenario: Create IDD, with multiple related documents
  Given I am logged in as a user with the "administrator" role
  When I visit "/node/add/ba"
    And I select "AP" from "AP/USDC"
    And I fill in "Sandra Edward Graham" for "Individual Name in Document"
    And I fill in the following:
      | First 			                  | Sandra        |
      | MI				                    | Edward        |
      | Last                          | Graham        |
      | Suffix                        | III           |
      | Entity Name                   | MaryJane LLC. |
      | field_also_known_as[0][value] | Sandy         |
      | Age in Document               | 33            |
    And I press the "Add another item" button
    And I wait for AJAX to finish
    And I fill in "San" for "field_also_known_as[1][value]"
    And I select "California" from "State"
    And I select "State/Residence" from "Basis for State"
    And I fill in the following:
      | Action Name in document       | testing123  |
      | title[0][value]               | ActionId123 |
      | field_action_number[0][value] | ActionNo123 |
      | Date                          | 03/23/2015  |
    And I select "N.D. Ala." from "Court"
    And I fill in the following:
    | Civ. Action No. /AP File No | test234 |
    And I type "This is Other Information" in the "Other Information" WYSIWYG editor
    And I select "Yes-Affirmed" from "Judgment/Final Order Appealed"
    And I fill in "02/26/2015" for "field_judgment_date[0][value][date]"
    And I type "These are CMS Notes" in the "CMS Notes" WYSIWYG editor
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    #Drupal Static File Reference
    And I select the first autocomplete option for "BEHAT Test File" on the "field_related_documents[0][subform][field_static_file_media][0][target_id]" field
    And I fill in the following:
    | field_related_documents[0][subform][field_document_date][0][value][date] | 05/04/2015 |
    And I select "Reinstatement" from "field_related_documents[0][subform][field_document_type]"
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    #NON-DRUPAL DOCUMENT URL
    And I fill in the following:
    | field_related_documents[1][subform][field_document_url][0][uri]          | https://www.nhl.com/capitals |
    | field_related_documents[1][subform][field_document_url][0][title]        | test230                      |
    | field_related_documents[1][subform][field_document_date][0][value][date] | 08/07/2015                   |
    And I select "Final Judgment (Civ Inj)" from "field_related_documents[1][subform][field_document_type]"
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    #Drupal Static File Reference
    And I select the first autocomplete option for "Behat Test File" on the "field_related_documents[1][subform][field_static_file_media][0][target_id]" field
    And I fill in the following:
    | field_related_documents[2][subform][field_document_date][0][value][date] | 06/01/2013 |
    And I select "Finality Order (AP)" from "field_related_documents[2][subform][field_document_type]"
    #Display/No-display solution
    And I select "Loss" from "Reason Unpublished"
    And I publish it
  Then I should see the text "Individual Defendant ActionId123 has been created"

  @api
  Scenario: Delete an Individual Defendant Record
    Given I am logged in as a user with the "administrator" role
      And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court | field_civ_action_no_ap_file_no | body        |
      | Donna Clooney | Donna            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Mary Jane LLC. et al., 2017 CV 12345 (D. Mass) | 2011/2/4         | N. D. Ala.  | Test234                        | So original |
    When I visit "/admin/content"
      And I click "Edit" in the "Donna Clooney" row
      And I click "edit-delete"
      And I press the "Delete" button
    Then I should not see the link "Donna Clooney"

  @api
  Scenario: Edit an Individual Defendant record
    Given I am logged in as a user with the "administrator" role
      And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court | field_civ_action_no_ap_file_no | body        |
      | Donna Clooney | Donna            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Mary Jane LLC. et al., 2017 CV 12345 (D. Mass) | 2011/2/4         | N. D. Ala.  | Test234                        | So original |
    When I visit "/admin/content"
      And I click "Edit" in the "Donna Clooney" row
      And I fill in the following:
      | Individual Name in Document | Donna C. Clooney |
      | MI                          | C.               |
      | title[0][value]             | Donna C. Clooney |
      And I publish it
    Then I should see the text "Donna C. Clooney"

# Scenario: Permissions for "Individual Defendant" role- access to IDD nodes- create, edit, delete
@api
Scenario: Individual Defendant role - Edit an Individual Defendant record
  Given I am logged in as a user with the "bad_actors" role
    And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body        |
      | Abe Clooney   | Abe              | Clooney         | 33                    | Alabama          | State/Residence       | SEC v. Mary Jane LLC. et al., 2017 CV 12345 (D. Mass) | 2011/2/4         | N. D. Ala.       | Test234                        | So original |
  When I visit "/admin/content"
    And I click "Edit" in the "Abe Clooney" row
    And I fill in the following:
      | Individual Name in Document | Donna C. Clooney |
      | First                       | Donna            |
      | MI                          | C.               |
      | title[0][value]             | Donna C. Clooney |
      And I publish it
    Then I should see the text "Donna C. Clooney"

  @api
  Scenario: Users with Individual Defendant Role Should Be Able To Delete an Individual Defendant Record
    Given I am logged in as a user with the "bad_actors" role
      And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court | field_civ_action_no_ap_file_no | body        |
      | Donna Clooney | Donna            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Mary Jane LLC. et al., 2017 CV 12345 (D. Mass) | 2011/2/4         | N. D. Ala.  | Test234                        | So original |
    When I visit "/admin/content"
      And I click "Edit" in the "Donna Clooney" row
      And I click "edit-delete"
      And I press the "Delete" button
    Then I should not see the link "Donna Clooney"

@api @javascript
Scenario: Mandatory Fields - Action Related Name ID
  Given I am logged in as a user with the "bad_actors" role
  When I visit "/node/add/ba"
    And I select "AP" from "AP/USDC"
    And I fill in "Sandra Edward Graham" for "Individual Name in Document"
    And I fill in the following:
      | First 			                 | Sandra |
      | MI				                   | Edward |
      | Last                         | Graham |
      | Suffix                       | III    |
      | Age in Document              | 33     |
      |field_also_known_as[0][value] | Sandy  |
    And I press the "Add another item" button
    And I wait for AJAX to finish
    #AKA-2
    And I fill in "San" for "field_also_known_as[1][value]"
    And I select "California" from "State"
    And I select "State/Residence" from "Basis for State"
    And I fill in the following:
      | Action Name in document                | testing123    |
      | field_action_number[0][value]          | ActionNo123   |
      | Date                                   | 03/23/2015    |
    And I select "N.D. Ala." from "Court"
    And I fill in the following:
      | Civ. Action No. /AP File No  | test234              |
    And I type "This is Other Information" in the "Other Information" WYSIWYG editor
    And I select "Yes-Affirmed" from "Judgment/Final Order Appealed"
    And I fill in "02/26/2015" for "field_judgment_date[0][value][date]"
    And I type "These are CMS Notes" in the "CMS Notes" WYSIWYG editor
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    And I fill in "field_related_documents[0][subform][field_document_date][0][value][date]" with "05/04/2015"
    And I select the first autocomplete option for "BEHAT Test File" on the "field_related_documents[0][subform][field_static_file_media][0][target_id]" field
    And I fill in "field_related_documents[0][subform][field_document_url][0][title]" with "test567"
    And I select "Reinstatement" from "field_related_documents[0][subform][field_document_type]"
    And I press the "Save" button
  Then I should be on "/node/add/ba"
    And I should not see the text "Individual Defendant ActionId123 has been created"
    And I should see the text "Create Individual Defendant"

@api
Scenario: Validate Help Text
  Given I am logged in as a user with the "bad_actors" role
  When I am on "/node/add/ba"
  Then I should see the text "Entity Name"
    And I should see the text "If you are not going to publish this defendant, please give a reason."
    And I should see the text "Please enter the date in the format MM/DD/YYYY."

  @api
  Scenario Outline: View IDD content by role
    Given "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                          | field_date_filed | field_court | field_civ_action_no_ap_file_no | body            | status | nid     | moderation_state | field_action_number |
      | Jorge Clooney | Jorge            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Clooney Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.  | Test234                        | So original     | 1      | 9192019 | published        | DC-20002-A          |
      | Geoff Daniels | Geoff            | Daniels         | 59                    | Michigan        | State/Residence       | SEC v. Carey LLC. et al., 2017 CV 12345 (D. MI)        | 2012/2/4         | N. D. MI.   | Test235                        | Not so original | 0      | 9202019 | draft            | DC-20002-B          |
    When I am logged in as a user with the "<role>" role
      And I visit "<node1>"
    Then I <var1> see the text "<text1>"
      And I visit "<node2>"
    Then I <var2> see the text "<text2>"

  Examples:
    | role                         | node1          | var1   | text1             | node2          | var2       | text2             |
    | bad_actors                   | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |
    | content_creator              | /node/9192019  | should | SEC Action Lookup | /node/9202019  | should     | SEC Action Lookup |
    | content_approver             | /node/9192019  | should | SEC Action Lookup | /node/9202019  | should     | SEC Action Lookup |
    | sitebuilder                  | /node/9192019  | should | SEC Action Lookup | /node/9202019  | should     | SEC Action Lookup |
    | administrator                | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |
    | authenticated                | /node/9192019  | should | SEC Action Lookup | /node/9202019  | should     | SEC Action Lookup |
    | bad_actors, content_creator  | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |
    | bad_actors, content_approver | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |
    | bad_actors, sitebuilder      | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |
    | bad_actors, administrator    | /node/9192019  | should | Jorge Clooney     | /node/9202019  | should     | DC-20002-B        |

@api
Scenario: View IDD content as anonymous user
  Given "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                          | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body            |  status  |  nid      | moderation_state | field_action_number |
      | Jorge Clooney | Jorge            | Clooney         | 33                    | Alabama          | State/Residence       | SEC v. Clooney Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.       | Test234                        | So original     |  1       |  9192019  | published        | DC-20002-A          |
      | Geoff Daniels | Geoff            | Daniels         | 59                    | Michigan         | State/Residence       | SEC v. Carey LLC. et al., 2017 CV 12345 (D. MI)        | 2012/2/4         | N. D. MI.        | Test235                        | Not so original |  0       |  9202019  | draft            | DC-20002-B          |
  When I am not logged in
    And I am on "/node/9192019"
  Then I should see the text "SEC Action Lookup"
  When I am on "/node/9202019"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file."

  @api @javascript
  Scenario Outline: IDD Download
    Given "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                          | field_date_filed | field_court | field_civ_action_no_ap_file_no | body            | status | nid     | moderation_state | field_action_number |
      | Jorge Clooney | Jorge            | Clooney         | 33                    | Alabama         | State/Residence       | SEC v. Clooney Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.  | Test234                        | So original     | 1      | 9192019 | published        | DC-20002-A          |
      | Geoff Daniels | Geoff            | Daniels         | 59                    | Michigan        | State/Residence       | SEC v. Carey LLC. et al., 2017 CV 12345 (D. MI)        | 2012/2/4         | N. D. MI.   | Test235                        | Not so original | 1      | 9202019 | published        | DC-20002-B          |
    When I am logged in as a user with the "<role>" role
      And I visit "/admin/content/idd"
    Then I should see the link "Export to CSV"
    When I click "Export to CSV"
      And I wait 3 seconds
    Then I should see the text "Export complete. Download the file here if file is not automatically downloaded."
      And I should see the link "here"
      And I should see the "a" element with the "href" attribute set to "/Export-Completed-Names-in-ENF-Actions" in the "status_message" region

    Examples:
    | role                         |
    | administrator                |
    | bad_actors                   |
    | bad_actors, administrator    |
    | bad_actors, content_creator  |
    | bad_actors, content_approver |
    | bad_actors, sitebuilder      |

@api @javascript
Scenario: Create IDD With Static File Media
  Given "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                          | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body            |  status  |  nid      | moderation_state | field_action_number |
      | Jorge Clooney | Jorge            | Clooney         | 33                    | Alabama          | State/Residence       | SEC v. Clooney Clan LLC. et al., 2017 CV 12345 (D. AR) | 2011/2/4         | N. D. Ala.       | Test234                        | So original     |  1       |  9192019  | published        | DC-20002-A          |
  When I am logged in as a user with the "bad_actors" role
    And I visit "/node/9192019/edit"
    And I press the "Add Related Document(s)" button
    And I wait for AJAX to finish
    And I fill in "field_related_documents[0][subform][field_static_file_media][0][target_id]" with "Behat Test File"
    And I publish it
    And I visit "/node/9192019"
  Then I should see the text "Behat Test File"
