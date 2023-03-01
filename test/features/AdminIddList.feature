Feature: Administrative List of Defendants
  As an Admin or bad-actor
  I want to be able to view a list of defendants
  So that I can update, publish/unpublish, delete defendant record on the list

  # Date Filed = YYYY-MM-DD
  # Current Age will not be populated if Date filed data isn't available
  # Current Age= Y1 - Y2;
  # Current Age= Y1 - Y2; Y1= ((Current Year- Date of Filing) + Age at Filing)-1; Y2= ((Current Year- Date of Filing) + Age at Filing)+1;

@api
Scenario: Validate Display of Admin IDD Search Screen- Individual Defendant role
  Given I am logged in as a user with the "bad_actors" role
    And I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file  | field_description_abstract | status |
      | Behat Test File | static file          | behat-form1.pdf   | This is description abs    | 1      |
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body        | status |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original | 1      |
      | George Clooney                   | George           | Clooney         | A-02005-B           | George101   | 37                    | New York         | State/License            | SEC v. Where's my coffee LLC. et al. 2017 CV 12345 (D. Mass)    | 2011-02-03        | N. D. N. Y       | Test123                                      | So original | 0      |
  When I visit "/admin/content/idd"
  Then I should see the text "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" in the "Donna" row
    And I should see the text "SEC v. Where's my coffee LLC. et al. 2017 CV 12345 (D. Mass)" in the "George" row
    And I should see the text "2011-02-03" in the "George" row
    And I should see the text "A-02003-B" in the "Donna" row
    And I should see the text "George101" in the "George" row
    And I should see the text "Drupal ID"
    And I should see the text "First"
    And I should see the text "Last"
    And I should see the text "Action #"
    And I should see the text "Action Related Name ID"
    And I should see the text "Action Name"
    And I should see the text "Date Filed"
    And I should not see the text "BEHAT Test File" in the "Donna" row
    And I should not see the text "BEHAT Test File" in the "George" row

@api
Scenario: Validation of administrator view of Admin IDD Search Screen
  Given I am logged in as a user with the "administrator" role
    And I create "media" of type "static_file":
      | name            | field_display_title  | field_media_file  | field_description_abstract | status |
      | Behat Test File | static file          | behat-form1.pdf   | This is description abs    | 1      |
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body        | status |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original | 1      |
      | George Clooney                   | George           | Clooney         | A-02005-B           | George101   | 37                    | New York         | State/License            | SEC v. Where's my coffee LLC. et al. 2017 CV 12345 (D. Mass)    | 2011-02-03        | N. D. N. Y       | Test123                                      | So original | 0      |
  When I visit "/admin/content/idd"
  Then I should see the text "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" in the "Donna" row
    And I should see the text "SEC v. Where's my coffee LLC. et al. 2017 CV 12345 (D. Mass)" in the "George" row
    And I should see the text "2011-02-03" in the "George" row
    And I should see the text "A-02003-B" in the "Donna" row
    And I should see the text "George101" in the "George" row
    And I should see the text "Drupal ID"
    And I should see the text "First"
    And I should see the text "Last"
    And I should see the text "Action #"
    And I should see the text "Action Related Name ID"
    And I should see the text "Action Name"
    And I should see the text "Date Filed"
    And I should not see the text "BEHAT Test File" in the "Donna" row
    And I should not see the text "BEHAT Test File" in the "George" row

@api
Scenario: Default sorting of Admin List of Defendants page by Last Name in alphabetical order
#Given I run drush "cr"
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
  Then "Clooney" should precede "Graham" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Graham" should precede "Smith" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Smith" should precede "Smithereens" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Smithereens" should precede "Smithsonian" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Last Name in reverse alphabetical order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
   And I click the sort filter "Last"
  Then "Smithsonian" should precede "Smithereens" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Smithereens" should precede "Smith" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Smith" should precede "Graham" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"
    And "Graham" should precede "Clooney" for the query "//td[contains(@class, 'views-field views-field-field-last-name')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by First Name in alphabetical order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "First"
  Then "Alexandra" should precede "Chris" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "Chris" should precede "Donna" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "Donna" should precede "John" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "John" should precede "Julia" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by First Name in reverse alphabetical order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "First"
    And I click the sort filter "First"
  Then "Chris" should precede "Alexandra" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "Donna" should precede "Chris" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "John" should precede "Donna" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"
    And "Julia" should precede "John" for the query "//td[contains(@class, 'views-field views-field-field-first-name is-active')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Number in ascending order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action #"
  Then "A-01999-B" should precede "A-02001-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02001-B" should precede "A-02002-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02002-B" should precede "A-02003-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02003-B" should precede "A-02004-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Number in descending order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action #"
    And I click the sort filter "Action #"
  Then "A-02004-B" should precede "A-02003-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02003-B" should precede "A-02002-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02002-B" should precede "A-02001-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"
    And "A-02001-B" should precede "A-01999-B" for the query "//td[contains(@class, 'views-field views-field-field-action-number')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Related Name ID in ascending order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action Related Name ID"
  Then "Alexandra12" should precede "Chris101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "Chris101" should precede "Donna101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "Donna101" should precede "John101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "John101" should precede "Julia101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Related Name ID in descending order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action Related Name ID"
    And I click the sort filter "Action Related Name ID"
  Then "Julia101" should precede "John101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "John101" should precede "Donna101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "Donna101" should precede "Chris101" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"
    And "Chris101" should precede "Alexandra12" for the query "//td[contains(@class, 'priority-low views-field views-field-title')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Name in alphabetical order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action Name"
  Then "Crackers Enterprises SEC File No. 4-15614" should precede "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)" should precede "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" should precede "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)" should precede "Smithsonian Enterprises SEC File No. 3-23121" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Action Name in reverse order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Action Name"
    And I click the sort filter "Action Name"
  Then "Smithsonian Enterprises SEC File No. 3-23121" should precede "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)" should precede "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" should precede "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"
    And "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)" should precede "Crackers Enterprises SEC File No. 4-15614" for the query "//td[contains(@class, 'views-field views-field-field-action-name-in-document')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Date Filed in oldest to newest order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Date Filed"
  Then "2011-02-04" should precede "2012-03-22" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2012-03-22" should precede "2012-03-23" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2012-03-23" should precede "2013-05-12" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2013-05-12" should precede "2014-06-17" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"

@api @javascript
Scenario: Sort Admin List of Defendants page by Date Filed in newest to oldest order
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
    | title                 | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
    | John D. Smith         | John             | Smith           | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
    | Julia Graham          | Julia            | Graham          | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
    | Alexandra Smithereens | Alexandra        | Smithereens     | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
    | Donna Clooney         | Donna            | Clooney         | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
    | Chris T. Smithsonian  | Chris            | Smithsonian     | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I click the sort filter "Date Filed"
    And I wait for ajax to finish
    And I click the sort filter "Date Filed"
    And I wait for ajax to finish
  Then "2012-03-22" should precede "2011-02-04" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2012-03-23" should precede "2012-03-22" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2013-05-12" should precede "2012-03-23" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"
    And "2014-06-17" should precede "2013-05-12" for the query "//td[contains(@class, 'views-field views-field-field-date-filed')]"

  #Administrative List of Defendants Filters
@api
Scenario: Search Admin List of Defendants by Last Name
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
   When I visit "/admin/content/idd"
    And I fill in "Search Last Name or Action Number" with "Clooney"
    And I press the "Apply" button
  Then I should see the text "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" in the "Donna" row
    And I should see the text "2011-02-04" in the "Donna" row
    And I should see the text "Donna101" in the "Donna" row
    And I should see the text "A-02003-B" in the "Donna" row

@api
Scenario: Search Admin List of Defendants by Action Number
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I fill in "Search Last Name or Action Number" with "A-02001-B"
    And I press the "Apply" button
  Then I should see the text "Crackers Enterprises SEC File No. 4-15614" in the "Julia" row
    And I should see the text "2013-05-12" in the "Julia" row
    And I should see the text "Julia101" in the "Julia" row
    And I should see the text "A-02001-B" in the "Julia" row

@api @javascript
Scenario: View only Published IDD records on Search Admin List of Defendants
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I select "Yes" from "Published"
    And I wait for ajax to finish
    And I press the "Apply" button
  Then I should see the text "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)" in the "John" row
    And I should see the text "Smith" in the "John" row
    And I should see the text "John101" in the "John" row
    And I should see the text "A-01999-B" in the "John" row
    And I should not see the text "Smithereens"
    And I should not see the text "A-02002-B"
    And I should not see the text "Alexandra12"
    And I should not see the text "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)"
    And I should see the text "Crackers Enterprises SEC File No. 4-15614" in the "Julia" row
    And I should see the text "2013-05-12" in the "Julia" row
    And I should see the text "Julia101" in the "Julia" row
    And I should see the text "A-02001-B" in the "Julia" row
    And I should see the text "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)" in the "Donna" row
    And I should see the text "2011-02-04" in the "Donna" row
    And I should see the text "Donna101" in the "Donna" row
    And I should see the text "A-02003-B" in the "Donna" row
    And I should see the text "Smithsonian" in the "Chris" row
    And I should see the text "2014-06-17" in the "Chris" row
    And I should see the text "Chris101" in the "Chris" row
    And I should see the text "A-02004-B" in the "Chris" row

@api @javascript
Scenario: View Only Unpublished IDD Records On Search Admin List Of Defendants
  Given I am logged in as a user with the "administrator" role
    And I create "node" of type "ba":
      | field_individual_name_in_documen | field_first_name | field_last_name | field_action_number | title       | field_age_in_document | field_state_idd  | field_basis_for_state    | field_action_name_in_document                                   | field_date_filed  | field_court      | field_civ_action_no_ap_file_no               | body                                                      | status |
      | John D. Smith                    | John             | Smith           | A-01999-B           | John101     | 49                    | Massachusetts    | State/License            | SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)          | 2012-03-23        | D. Mass          | SEC Complaint; LR-12007; LR-13343            | Reinstated to practice before the Commission on 2/24/2009 | 1      |
      | Julia Graham                     | Julia            | Graham          | A-02001-B           | Julia101    | 35                    | New York         | State/ Registrant Locale | Crackers Enterprises SEC File No. 4-15614                       | 2013-05-12        | N.D.N.Y          | File No. 4-15614 Case Dosuments              | Crackers were not crispy                                  | 1      |
      | Alexandra Smithereens            | Alexandra        | Smithereens     | A-02002-B           | Alexandra12 | 43                    | North Dakota     | State/Resident           | SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)   | 2012-03-22        | S.D.N.Y          | SEC Complaint; LR-12343; LR-13212            | test field 123                                            | 0      |
      | Donna Clooney                    | Donna            | Clooney         | A-02003-B           | Donna101    | 31                    | Alabama          | State/Other Basis        | SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)            | 2011-02-04        | S.D.Ala.         | SEC Complaint; LR-12456; LR-14897; LR- 26541 | So original                                               | 1      |
      | Chris T. Smithsonian             | Chris            | Smithsonian     | A-02004-B           | Chris101    | 65                    | California       | State/License            | Smithsonian Enterprises SEC File No. 3-23121                    | 2014-06-17        | E.D.Cal.         | File No. 3-23121 Case Documents              | Dragon Claw doesn't work                                  | 1      |
  When I visit "/admin/content/idd"
    And I select "No" from "Published"
    And I wait for ajax to finish
    And I press the "Apply" button
  Then I should not see the text "SEC v. Smith Properties et al. 2017 CV 12345 (D. Mass)"
    And I should not see the text "John101"
    And I should not see the text "A-01999-B"
    And I should see the text "Smithereens" in the "Alexandra" row
    And I should see the text "A-02002-B" in the "Alexandra" row
    And I should see the text "Alexandra12" in the "Alexandra" row
    And I should see the text "SEC v. Cranberries Music Corp. et al. 2017 CV 12345 (S.D.N.Y)" in the "Alexandra" row
    And I should not see the text "Crackers Enterprises SEC File No. 4-15614"
    And I should not see the text "2013-05-12"
    And I should not see the text "Julia101"
    And I should not see the text "A-02001-B"
    And I should not see the text "SEC v. Mary Jane LLC. et al. 2017 CV 12345 (D. Mass)"
    And I should not see the text "2011-02-04"
    And I should not see the text "Donna101"
    And I should not see the text "A-02003-B"
    And I should not see the text "Smithsonian"
    And I should not see the text "2014-06-17"
    And I should not see the text "Chris101"
    And I should not see the text "A-02004-B"

@api @javascript
Scenario: Fields on the List of Defendants
  Given I am logged in as a user with the "administrator" role
  When I visit "/admin/content/idd"
  Then "Drupal ID" should precede "First" for the query "//table//th/a"
    And I click the sort filter "Drupal ID"
    And "First" should precede "Last" for the query "//table//th/a"
    And "Last" should precede "Action #" for the query "//table//th/a"
    And "Action #" should precede "Action Related Name ID" for the query "//table//th/a"
    And "Action Related Name ID" should precede "Action Name" for the query "//table//th/a"
    And "Action Name" should precede "Date Filed" for the query "//table//th/a"
    And "Action Name" should precede "Published" for the query "//table//th/a"

@api
Scenario: Default 100 records per page and view up to 500 records per page
  Given I am logged in as a user with the "administrator" role
    And "ba" content:
    | title |
    | 001   |
    | 002   |
    | 003   |
    | 004   |
    | 005   |
    | 006   |
    | 007   |
    | 008   |
    | 009   |
    | 010   |
    | 011   |
    | 012   |
    | 013   |
    | 014   |
    | 015   |
    | 016   |
    | 017   |
    | 018   |
    | 019   |
    | 020   |
    | 021   |
    | 022   |
    | 023   |
    | 024   |
    | 025   |
    | 026   |
    | 027   |
    | 028   |
    | 029   |
    | 030   |
    | 031   |
    | 032   |
    | 033   |
    | 034   |
    | 035   |
    | 036   |
    | 037   |
    | 038   |
    | 039   |
    | 040   |
    | 041   |
    | 042   |
    | 043   |
    | 044   |
    | 045   |
    | 046   |
    | 047   |
    | 048   |
    | 049   |
    | 050   |
    | 051   |
    | 052   |
    | 053   |
    | 054   |
    | 055   |
    | 056   |
    | 057   |
    | 058   |
    | 059   |
    | 060   |
    | 061   |
    | 062   |
    | 063   |
    | 064   |
    | 065   |
    | 066   |
    | 067   |
    | 068   |
    | 069   |
    | 070   |
    | 071   |
    | 072   |
    | 073   |
    | 074   |
    | 075   |
    | 076   |
    | 077   |
    | 078   |
    | 079   |
    | 080   |
    | 081   |
    | 082   |
    | 083   |
    | 084   |
    | 085   |
    | 086   |
    | 087   |
    | 088   |
    | 089   |
    | 090   |
    | 091   |
    | 092   |
    | 093   |
    | 094   |
    | 095   |
    | 096   |
    | 097   |
    | 098   |
    | 099   |
    | 100   |
    | 101   |
    | 102   |
    | 103   |
    | 104   |
    | 105   |
    | 106   |
    | 107   |
    | 108   |
    | 109   |
    | 110   |
    | 111   |
    | 112   |
    | 113   |
    | 114   |
    | 115   |
    | 116   |
    | 117   |
    | 118   |
    | 119   |
    | 120   |
    | 121   |
    | 122   |
    | 123   |
    | 124   |
    | 125   |
    | 126   |
    | 127   |
    | 128   |
    | 129   |
    | 130   |
    | 131   |
    | 132   |
    | 133   |
    | 134   |
    | 135   |
    | 136   |
    | 137   |
    | 138   |
    | 139   |
    | 140   |
    | 141   |
    | 142   |
    | 143   |
    | 144   |
    | 145   |
    | 146   |
    | 147   |
    | 148   |
    | 149   |
    | 150   |
    | 151   |
    | 152   |
    | 153   |
    | 154   |
    | 155   |
    | 156   |
    | 157   |
    | 158   |
    | 159   |
    | 160   |
    | 161   |
    | 162   |
    | 163   |
    | 164   |
    | 165   |
    | 166   |
    | 167   |
    | 168   |
    | 169   |
    | 170   |
    | 171   |
    | 172   |
    | 173   |
    | 174   |
    | 175   |
    | 176   |
    | 177   |
    | 178   |
    | 179   |
    | 180   |
    | 181   |
    | 182   |
    | 183   |
    | 184   |
    | 185   |
    | 186   |
    | 187   |
    | 188   |
    | 189   |
    | 190   |
    | 191   |
    | 192   |
    | 193   |
    | 194   |
    | 195   |
    | 196   |
    | 197   |
    | 198   |
    | 199   |
    | 200   |
    | 201   |
    | 202   |
    | 203   |
    | 204   |
    | 205   |
    | 206   |
    | 207   |
    | 208   |
    | 209   |
    | 210   |
    | 211   |
    | 212   |
    | 213   |
    | 214   |
    | 215   |
    | 216   |
    | 217   |
    | 218   |
    | 219   |
    | 220   |
    | 221   |
    | 222   |
    | 223   |
    | 224   |
    | 225   |
    | 226   |
    | 227   |
    | 228   |
    | 229   |
    | 230   |
    | 231   |
    | 232   |
    | 233   |
    | 234   |
    | 235   |
    | 236   |
    | 237   |
    | 238   |
    | 239   |
    | 240   |
    | 241   |
    | 242   |
    | 243   |
    | 244   |
    | 245   |
    | 246   |
    | 247   |
    | 248   |
    | 249   |
    | 250   |
    | 251   |
    | 252   |
    | 253   |
    | 254   |
    | 255   |
    | 256   |
    | 257   |
    | 258   |
    | 259   |
    | 260   |
    | 261   |
    | 262   |
    | 263   |
    | 264   |
    | 265   |
    | 266   |
    | 267   |
    | 268   |
    | 269   |
    | 270   |
    | 271   |
    | 272   |
    | 273   |
    | 274   |
    | 275   |
    | 276   |
    | 277   |
    | 278   |
    | 279   |
    | 280   |
    | 281   |
    | 282   |
    | 283   |
    | 284   |
    | 285   |
    | 286   |
    | 287   |
    | 288   |
    | 289   |
    | 290   |
    | 291   |
    | 292   |
    | 293   |
    | 294   |
    | 295   |
    | 296   |
    | 297   |
    | 298   |
    | 299   |
    | 300   |
    | 301   |
    | 302   |
    | 303   |
    | 304   |
    | 305   |
    | 306   |
    | 307   |
    | 308   |
    | 309   |
    | 310   |
    | 311   |
    | 312   |
    | 313   |
    | 314   |
    | 315   |
    | 316   |
    | 317   |
    | 318   |
    | 319   |
    | 320   |
    | 321   |
    | 322   |
    | 323   |
    | 324   |
    | 325   |
    | 326   |
    | 327   |
    | 328   |
    | 329   |
    | 330   |
    | 331   |
    | 332   |
    | 333   |
    | 334   |
    | 335   |
    | 336   |
    | 337   |
    | 338   |
    | 339   |
    | 340   |
    | 341   |
    | 342   |
    | 343   |
    | 344   |
    | 345   |
    | 346   |
    | 347   |
    | 348   |
    | 349   |
    | 350   |
    | 351   |
    | 352   |
    | 353   |
    | 354   |
    | 355   |
    | 356   |
    | 357   |
    | 358   |
    | 359   |
    | 360   |
    | 361   |
    | 362   |
    | 363   |
    | 364   |
    | 365   |
    | 366   |
    | 367   |
    | 368   |
    | 369   |
    | 370   |
    | 371   |
    | 372   |
    | 373   |
    | 374   |
    | 375   |
    | 376   |
    | 377   |
    | 378   |
    | 379   |
    | 380   |
    | 381   |
    | 382   |
    | 383   |
    | 384   |
    | 385   |
    | 386   |
    | 387   |
    | 388   |
    | 389   |
    | 390   |
    | 391   |
    | 392   |
    | 393   |
    | 394   |
    | 395   |
    | 396   |
    | 397   |
    | 398   |
    | 399   |
    | 400   |
    | 401   |
    | 402   |
    | 403   |
    | 404   |
    | 405   |
    | 406   |
    | 407   |
    | 408   |
    | 409   |
    | 410   |
    | 411   |
    | 412   |
    | 413   |
    | 414   |
    | 415   |
    | 416   |
    | 417   |
    | 418   |
    | 419   |
    | 420   |
    | 421   |
    | 422   |
    | 423   |
    | 424   |
    | 425   |
    | 426   |
    | 427   |
    | 428   |
    | 429   |
    | 430   |
    | 431   |
    | 432   |
    | 433   |
    | 434   |
    | 435   |
    | 436   |
    | 437   |
    | 438   |
    | 439   |
    | 440   |
    | 441   |
    | 442   |
    | 443   |
    | 444   |
    | 445   |
    | 446   |
    | 447   |
    | 448   |
    | 449   |
    | 450   |
    | 451   |
    | 452   |
    | 453   |
    | 454   |
    | 455   |
    | 456   |
    | 457   |
    | 458   |
    | 459   |
    | 460   |
    | 461   |
    | 462   |
    | 463   |
    | 464   |
    | 465   |
    | 466   |
    | 467   |
    | 468   |
    | 469   |
    | 470   |
    | 471   |
    | 472   |
    | 473   |
    | 474   |
    | 475   |
    | 476   |
    | 477   |
    | 478   |
    | 479   |
    | 480   |
    | 481   |
    | 482   |
    | 483   |
    | 484   |
    | 485   |
    | 486   |
    | 487   |
    | 488   |
    | 489   |
    | 490   |
    | 491   |
    | 492   |
    | 493   |
    | 494   |
    | 495   |
    | 496   |
    | 497   |
    | 498   |
    | 499   |
    | 500   |
  When I visit "/admin/content/idd"
  Then I should see the text "Displaying 1 - 100"
# View up to 500 records per page
  When I visit "/admin/content/idd"
    And I select "500" from "Items per page"
    And I press the "Apply" button
  Then I should see the text "Displaying 1 - 500"

@api
Scenario: View max allowed records per page - 500
  Given I am logged in as a user with the "administrator" role
  When I visit "/admin/content/idd"
    And I select "500" from "Items per page"
    And I press the "Apply" button
  Then the response status code should be 200
