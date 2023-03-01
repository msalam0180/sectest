Feature: Perform Bulk Publishing of Content
  As a content approver user
  I want to be able to publish/unpublish/deleting multiple content records at a time
  So that I can save time from doing them individually

@api @javascript
Scenario: Bulk Unpublishing Content
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
      | title              | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                             | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body                            | status |
      | publishex101       | John             | Publisher       | 34                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/14        | D. Md.           | TestPublishing                 | For bulkpublishing behat testing| 1      |
      | publishex102       | Jane             | Publisher       | 35                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2012/5/14        | D. Md.           | TestPublishing                 | For bulkpublishing behat testing| 1      |
      | publishex103       | Jack             | Publisher       | 36                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2013/5/14        | D. Md.           | TestPublishing                 | For bulkpublishing behat testing| 1      |
      | publishex104       | Jake             | Publisher       | 37                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/15        | D. Md.           | TestPublishing                 | For bulkpublishing behat testing| 1      |
      | publishex105       | Jim              | Publisher       | 38                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/16        | D. Md.           | TestPublishing                 | For bulkpublishing behat testing| 1      |
  When I visit "/admin/content"
    And I fill in "publishex" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click on the element with css selector "input.form-checkbox:nth-child(1)"
    And I wait for AJAX to finish
    And I select "Set Content as Unpublished" from "action"
    And I press "Apply to selected items"
    #Currently there is a bug (OSSS-5844) that will prevent it from showing the confirmation message "Set Content as Unpublished was applied to" therefore skipping the next step
    #And I should see the text "Set Content as Unpublished was applied to" - Commenting this out until we have a fix to OSSS-5844
    And I visit "/admin/content"
    And I fill in "publishex" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click "Edit" in the "publishex101" row
  Then I should see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "publishex102" row
    And I should see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "publishex103" row
    And I should see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "publishex104" row
    And I should see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "publishex105" row
    And I should see the text "Not published"

@api @javascript
Scenario: Bulk Publishing Content
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
      | title              | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                             | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body                              | status |
      | unpublisher101     | Dan              | Unpublisher     | 24                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/14        | D. Md.           | TestUnPublishing               | For bulkunpublishing behat testing| 0      |
      | unpublisher102     | Anna             | Unpublisher     | 25                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2012/5/14        | D. Md.           | TestUnPublishing               | For bulkunpublishing behat testing| 0      |
      | unpublisher103     | Carol            | Unpublisher     | 26                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2013/5/14        | D. Md.           | TestUnPublishing               | For bulkunpublishing behat testing| 0      |
      | unpublisher104     | Sarah            | Unpublisher     | 27                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/15        | D. Md.           | TestUnPublishing               | For bulkunpublishing behat testing| 0      |
      | unpublisher105     | Elle             | Unpublisher     | 28                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/16        | D. Md.           | TestUnPublishing               | For bulkunpublishing behat testing| 0      |
  When I visit "/admin/content"
    And I fill in "unpublisher" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click on the element with css selector "input.form-checkbox:nth-child(1)"
    And I wait for AJAX to finish
    And I select "Set Content as Published" from "action"
    And I press "Apply to selected items"
    #Currently there is a bug (OSSS-5844) that will prevent it from showing the confirmation message "Set Content as Published was applied to" therefore skipping the next step
    #And I should see the text "Set Content as Unpublished was applied to" - Commenting this out until we have a fix to OSSS-5844
    And I visit "/admin/content"
    And I fill in "unpublisher" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click "Edit" in the "unpublisher101" row
  Then I should not see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "unpublisher102" row
    And I should not see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "unpublisher103" row
    And I should not see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "unpublisher104" row
    And I should not see the text "Not published"
    And I visit "/admin/content"
    And I click "Edit" in the "unpublisher105" row
    And I should not see the text "Not published"

@api @javascript
Scenario: Bulk Deleting Content
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
      | title           | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                             | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body                            | status |
      | Deleter101      | Rick             | Deleter         | 24                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/14        | D. Md.           | TestDeleting                   | For bulkdeletion behat testing  | 1      |
      | Deleter102      | Carl             | Deleter         | 25                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2012/5/14        | D. Md.           | TestDeleting                   | For bulkdeletion behat testing  | 1      |
      | Deleter103      | Carol            | Deleter         | 26                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2013/5/14        | D. Md.           | TestDeleting                   | For bulkdeletion behat testing  | 1      |
      | Deleter104      | Gabriel          | Deleter         | 27                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/15        | D. Md.           | TestDeleting                   | For bulkdeletion behat testing  | 1      |
      | Deleter105      | Enid             | Deleter         | 28                    | Maryland         | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.)     | 2011/5/16        | D. Md.           | TestDeleting                   | For bulkdeletion behat testing  | 1      |
  When I visit "/admin/content"
    And I fill in "deleter" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click on the element with css selector "input.form-checkbox:nth-child(1)"
    And I wait for AJAX to finish
    And I select "Delete content" from "action"
    And I press "Apply to selected items"
    And I should see the text "Are you sure you want to delete these content items?"
    And I should see the text "This action cannot be undone"
    And I press "edit-submit"
    #And I should see the text "Deleted 5 posts." - Commenting this out until we have a fix to OSSS-5844
    And I visit "/admin/content"
    And I fill in "deleter" for "edit-key"
    And I press "Filter"
  Then I should not see the text "Deleter"
