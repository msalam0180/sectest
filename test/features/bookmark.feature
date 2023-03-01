Feature: Perform Bookmarking of Content
  As an administrative user
  I want to be able to bookmark content records
  So that I can have easy access to these content records

@api @javascript
Scenario: Bookmarking Content
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
      | title        | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court | field_civ_action_no_ap_file_no | body                             | status |
      | publishex101 | John             | Publisher       | 34                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex102 | Jane             | Publisher       | 35                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2012/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex103 | Jack             | Publisher       | 36                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2013/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex104 | Jake             | Publisher       | 37                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/15        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex105 | Jim              | Publisher       | 38                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/16        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
  When I visit "/admin/content"
    And I fill in "publishex" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click "Edit" in the "publishex101" row
    And I press "Flags"
    And I check "edit-flag-bookmark"
    And I publish it
  Then I should see the text "Individual Defendant publishex101 has been updated"
  When I visit "/admin/bookmarks"
  Then I should see the link "publishex101"

@api @javascript
Scenario: Un-bookmarking Content
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
      | title        | field_first_name | field_last_name | field_age_in_document | field_state_idd | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court | field_civ_action_no_ap_file_no | body                             | status |
      | publishex101 | John             | Publisher       | 34                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex102 | Jane             | Publisher       | 35                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2012/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex103 | Jack             | Publisher       | 36                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2013/5/14        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex104 | Jake             | Publisher       | 37                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/15        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
      | publishex105 | Jim              | Publisher       | 38                    | Maryland        | State/Residence       | SEC v. Bookmarker LLC. et al., 2014 CV 12345 (D. MD.) | 2011/5/16        | D. Md.      | TestPublishing                 | For bulkpublishing behat testing | 1      |
  When I visit "/admin/content"
    And I fill in "publishex" for "edit-key"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click "Edit" in the "publishex102" row
    And I press "Flags"
    And I check "edit-flag-bookmark"
    And I publish it
  Then I should see the text "Individual Defendant publishex102 has been updated"
  When I visit "/admin/bookmarks"
  Then I should see the link "publishex102"
  When I click "Remove bookmark" in the "publishex102" row
    And I wait for AJAX to finish
  Then I should see the text "Bookmark this" in the "publishex102" row
  When I visit "/admin/bookmarks"
  Then I should not see the link "publishex102"
