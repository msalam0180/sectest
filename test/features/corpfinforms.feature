Feature: Submit CorpFin Webforms
   As a Content Creator
   I want to be able to create a webform and submit it
   So that content creator receives and views my form input values

   Background:
     Given "shareholder_proposal" terms:
     | name                                   |
     | Rule 14a-8(x) - Number of Proposals    |
     | Rule 14a-8(x) - Procedural/Eligibility |
     | Rule (123x)                            |
     | Rule 14a-8(x) - Attendance             |

 # Do not uncomment until webforms are enabled
 #
 #/*
 #@api
 #Scenario: Successfully submit CorpFin when required fields are filled out including validation of reCaptcha
 ##this test is for /forms/corp_fin_interpretive
 ##Given I am logged in as a user with the "administrator" role
 #    And I am on "/forms/corp_fin_interpretive"
 #    When I fill in "your_name" with "Tester SB"
 #    And I fill in "your_email_address" with "balmakhtars@sec.gov"
 #    And I fill in "your_phone_number" with "7031231234"
 #    And I fill in "best_time_of_day_eastern_us_time_to_reach_you_by_phone" with "Morning"
 #    And I select "5" from "division_office_to_receive_your_request_field"
 #    And I fill in "general_subject_matter_of_your_request" with " text goes here"
 #    Then I should see the link "[Info]"
 #    And I fill in "your_request" with "my request"
 #    And I fill in "additional_information" with "additional information"
 #	Then I should see the text "reCAPTCHA"
 #    And I press "Submit"
 #	Then I should see the text "Thank you."
 #
 #@api
 #Scenario: Failure to submit corp_fin_interpretive when one required field is not filled out
 ##this test is for /forms/corp_fin_interpretive
 ##Given I am logged in as a user with the "administrator" role
 #    And I am on "/forms/corp_fin_interpretive"
 #    When I fill in "your_name" with ""
 #    And I fill in "your_email_address" with "balmakhtars@sec.gov"
 #    And I fill in "your_phone_number" with "7031231234"
 #    And I fill in "best_time_of_day_eastern_us_time_to_reach_you_by_phone" with "Morning"
 #    And I select "6" from "division_office_to_receive_your_request_field"
 #    And I fill in "general_subject_matter_of_your_request" with " text goes here"
 #    Then I should see the link "[Info]"
 #    And I fill in "your_request" with "my request"
 #    And I fill in "additional_information" with "additional information"
 #    And I press "Submit"
 #	Then I should not see the text "Thank you."
 #
 # #@javascript
 #  @api
 #  Scenario: Successfully submit corp_fin_noaction when required fields are filled out
 ##this test is for /forms/corp_fin_noaction
 ##Given I am logged in as a user with the "administrator" role
 #      Given I am on "/forms/corp_fin_noaction"
 #    Then I should see the text "Corporation Finance Request Form for No Action, Exemptive Letters, Waiver Requests, Formal Guidance, and Other Assistance"
 #      When I fill in "edit-your-name" with "Tester SB"
 #      And I fill in "your_phone_number" with "7031231234"
 #      And I fill in "your_email_address" with "balmakhtars@sec.gov"
 #      And I fill in "best_time_of_day" with "morning"
 #      And I wait 5 seconds
 #      And I select "noaction" from "type_of_request_field"
 #      And I wait 5 seconds
 #      And I select "1" from "division_office_field"
 #     Then I should see the link "[Info]"
 #      And I select "Revised" from "please_also_indicate_whether_this_is_an_initial_or_a_revised_sub"
 #      And I fill in "general_subject_matter_of_your_request" with "Subject matter text"
 #      And I fill in "your_request" with "my request"
 #      And I fill in "additional_information" with "additional information"
 #      And I attach the file "behat-corpfinformuploadtest.pdf" to "edit-upload-your-request-upload"
 #  	 # And I should see the text "reCAPTCHA"
 #      And I press "Submit"
 #  	Then I should see the text "Thank you."
 #
 #
 #  @api
 #  Scenario: Failure to submit corp_fin_noaction when one required field is not filled out
 ##this test is for /forms/corp_fin_noaction
 ##Given I am logged in as a user with the "administrator" role
 #  And I am on "/forms/corp_fin_noaction"
 #  When I fill in "edit-your-name" with ""
 #  And I fill in "your_phone_number" with "7031231234"
 #  And I fill in "your_email_address" with "balmakhtars@sec.gov"
 #  And I fill in "best_time_of_day" with "morning"
 #  And I wait 5 seconds
 #  And I select "noaction" from "type_of_request_field"
 #  And I select "1" from "division_office_field"
 #  Then I should see the link "[Info]"
 #  And I select "Revised" from "please_also_indicate_whether_this_is_an_initial_or_a_revised_sub"
 #  And I fill in "general_subject_matter_of_your_request" with "Subject matter text"
 #  And I fill in "your_request" with "my request"
 #  And I fill in "additional_information" with "additional information"
 #  And I attach the file "behat-corpfinformuploadtest.pdf" to "edit-upload-your-request-upload"
 #  #And I should see the text "reCAPTCHA"
 #  And I press "Submit"
 #Then I should not see the text "Thank you." */
 #


#**********************************************************************************************************************************************************************************
#Note: Before running these scenarios and to avoid failures, ensure that submissions data and files are completely removed by cleanup of your local database as well as the
# "_sid_" folder on your local at:
#1) For corp_fin_noaction:
#----------------------
# \\wsl$\Ubuntu\home\<<your username here>>\sites\secgov\files-private\webform\corp_fin_noaction\_sid_
#2) For shareholder_proposal:
#-------------------------
# \\wsl$\Ubuntu\home\<<your username here>>\sites\secgov\files-private\webform\shareholder_proposal\_sid_
#**********************************************************************************************************************************************************************************

#Disable corp_fin_noaction handler that is used to route webform submission data to external applications to avoid error "Our systems are down please try again later"
@api @javascript
  Scenario: Disable handler for corp_fin_noaction webform
    Given I am logged in as a user with the "administrator" role
    When I am on "/admin/structure/webform/manage/corp_fin_noaction/handlers"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I click on the element with css selector "tr:nth-child(1) > td:nth-child(6) > div > div > div > ul > li.dropbutton-toggle"
      And I wait 1 seconds
      And I click on the element with css selector "tr:nth-child(1) > td:nth-child(6) > div > div > div > ul > li.status.dropbutton-action.secondary-action > a"
      And I scroll to the bottom
      And I press the "Save handlers" button
      And I wait for ajax to finish
    Then I should see the text "Webform Requests for No-Action, Interpretive, Exemptive, and Waiver Letters handler saved."

@api
  Scenario Outline: Successfully Submit Interpretive Exemptive And Waiver Letters Webform
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "Tester dude"
      And I fill in "your_email_address" with "imaginary_email@sec.gov"
      And I fill in "your_phone_number" with "999-123-1234"
      And I select "Morning" from "edit-best-time-of-day-eastern-us-time-to-reach-you-by-phone"
      And I check the box "No Action Request"
      And I select the radio button "Office of International Corporate Finance"
      And I select the radio button "Initial"
      And I attach the file "<file>" to "edit-upload-your-request-upload"
      And I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

    Examples:
      | file                        |
      | behat-corpfin2-wts-wf1.doc  |
      | behat-corpfin2-wts-wf1.docx |
      | behat-corpfin2-wts-wf1.pdf  |

@api
  Scenario: Webform displays server validation when missing file upload on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "Tester dude"
      And I fill in "your_email_address" with "imaginary_email@sec.gov"
      And I fill in "your_phone_number" with "999-123-1234"
      And I select "Morning" from "edit-best-time-of-day-eastern-us-time-to-reach-you-by-phone"
      And I check the box "No Action Request"
      And I select the radio button "Office of International Corporate Finance"
      And I select the radio button "Initial"
      And I press "Submit"
    Then I should see the text "Please attach one or more files to your request."

@api
  Scenario Outline: Webform Mandatory Fields - Name Email & Phone on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "<Name>"
      And I fill in "your_email_address" with "<Email>"
      And I fill in "your_phone_number" with "<Telephone>"
      And I check the box "No Action Request"
      And I select the radio button "Initial"
      And I attach the file "behat-corpfin2-wts-wf2.doc" to "edit-upload-your-request-upload"
      And I press the "Submit" button
    Then I should not see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

    Examples:
      | Name | Email                 | Telephone  |
      |      | drupalsupport@sec.gov | 2025550000 |
      | Joe  |                       | 2025550000 |
      | Joe  | drupalsupport@sec.gov |            |

@api
  Scenario: Webform Mandatory Fields - Type of Request on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "Tester dude"
      And I fill in "your_email_address" with "imaginary_email@sec.gov"
      And I fill in "your_phone_number" with "999-123-1234"
      And I select the radio button "Initial"
      And I attach the file "behat-corpfin2-wts-wf2.docx" to "edit-upload-your-request-upload"
      And I press "Submit"
    Then I should not see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api
  Scenario: Webform Mandatory Fields - Initial or Revised on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "Tester dude"
      And I fill in "your_email_address" with "imaginary_email@sec.gov"
      And I fill in "your_phone_number" with "999-123-1234"
      And I check the box "No Action Request"
      And I attach the file "behat-corpfin2-wts-wf2.pdf" to "edit-upload-your-request-upload"
      And I press "Submit"
    Then I should not see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
  Scenario: Webform displays validation for unsupported Upload file format on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the heading "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I attach the file "behat-corpfin2-wts-wf1.pptx" to "edit-upload-your-request-upload"
    Then I should see the text "The selected file behat-corpfin2-wts-wf1.pptx cannot be uploaded. Only files with the following extensions are allowed: pdf, doc, docx"

@api @javascript
  Scenario: Webform displays validation for Upload file size limit being exceeded on Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the text "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I attach the file "behat-corpfin2-wts-wf_10_12mb.pdf" to "edit-upload-your-request-upload"
      And I wait for ajax to finish
    Then I should see the text "The specified file behat-corpfin2-wts-wf_10_12mb.pdf could not be uploaded."
      And I should see the text "The file is 10.12 MB exceeding the maximum file size of 10 MB."

@api @javascript
  Scenario: Webform max number of upload files allowed for Interpretive Exemptive and Waiver Letters form
    Given I am on "/forms/corp_fin_noaction"
    Then I should see the text "Requests for No-Action, Interpretive, Exemptive, and Waiver Letters"
    When I fill in "edit-your-name" with "Tester dude"
      And I fill in "your_email_address" with "imaginary_email@sec.gov"
      And I fill in "your_phone_number" with "999-123-1234"
      And I check the box "No Action Request"
      And I select the radio button "Initial"
      And I attach the file "behat-corpfin2-wts-wf3.doc" to "Upload Your Request"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf3.docx" to "Upload Your Request"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf3.pdf" to "Upload Your Request"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf4.doc" to "Upload Your Request"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf4.docx" to "Upload Your Request"
      And I wait for ajax to finish
    Then I should see the "input" element with the "style" attribute set to "display:none" in the "webform_fileupload" region

#Disable shareholder_proposal handler that is used to route webform submission data to external applications to avoid error "Our systems are down please try again later"
@api @javascript @shareholder
  Scenario: Disable handler for shareholder_proposal webform
    Given I am logged in as a user with the "administrator" role
    When I am on "/admin/structure/webform/manage/shareholder_proposal/handlers"
    Then I should see the heading "Shareholder Proposal"
    When I click on the element with css selector "tr:nth-child(1) > td:nth-child(6) > div > div > div > ul > li.dropbutton-toggle"
      And I wait 1 seconds
      And I click on the element with css selector "tr:nth-child(1) > td:nth-child(6) > div > div > div > ul > li.status.dropbutton-action.secondary-action > a"
      And I scroll to the bottom
      And I press the "Save handlers" button
      And I wait for ajax to finish
    Then I should see the text "Webform Shareholder Proposal handler saved."

@api @javascript @shareholder
  Scenario: Successfully Submit Initial Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Tony Stark"
      And I fill in "Proponent Contact Name" with "Iron Man"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I check the box "Rule 14a-8(x) - Number of Proposals"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Company"
      And I should see the text "Initial Request"
      And I should see the text "Metadata Metrics Encapsulation Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Tony Stark"
      And I should see the text "Iron Man"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "Rule 14a-8(x) - Number of Proposals"
      And I should see the text "behat-corpfin2-wts-shp-wf1.doc"
      And I should see the text "behat-corpfin2-wts-shp-wf1.docx"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @shareholder
  Scenario: Successfully Submit Supplemental Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Supplemental Correspondence"
      And I wait for ajax to finish
    Then I should see the text "Reference ID"
      And I should see the text "Date of 14a-8 initial request letter:"
      And I should see the text "Company relating to original request"
      And I should see the text "Proponent relating to original request"
      And I type "12345" in css selector "#edit-reference-id-supplemental"
      And I fill in "letter_date" with "06/24/2050"
      And I fill in "Company relating to original request" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Proponent relating to original request" with "Tony Stark"
      And I fill in "Company Name" with "Mars Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Howard Stark"
      And I fill in "Proponent Contact Name" with "Larry Stark"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I check the box "Rule (123x)"
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Company"
      And I should see the text "Supplemental Correspondence"
      And I should see the text "12345"
      And I should see the text "06/24/2050"
      And I should see the text "Metadata Metrics Encapsulation Inc"
      And I should see the text "Tony Stark"
      And I should see the text "Mars Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Howard Stark"
      And I should see the text "Larry Stark"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "Rule (123x)"
      And I should see the text "behat-corpfin2-wts-shp-wf1.docx"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @shareholder
  Scenario: Successfully Submit Reconsideration Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Show type of request"
      And I wait for ajax to finish
    Then I should see the text "Reference ID"
      And I type "12345" in css selector "#edit-reference-id-reconsideration"
      And I fill in "Company Name" with "Mars Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Howard Stark"
      And I fill in "Proponent Contact Name" with "Larry Stark"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I check the box "Rule 14a-8(x) - Attendance"
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Company"
      And I should see the text "Reconsideration Request"
      And I should see the text "12345"
      And I should see the text "Mars Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Howard Stark"
      And I should see the text "Larry Stark"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "Rule 14a-8(x) - Attendance"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @shareholder
  Scenario: Successfully Submit Initial Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Tony Stark"
      And I fill in "Proponent Contact Name" with "Iron Man"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I check the box "Rule 14a-8(x) - Number of Proposals"
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Proponent"
      And I should see the text "Initial Request"
      And I should see the text "Metadata Metrics Encapsulation Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Tony Stark"
      And I should see the text "Iron Man"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "Rule 14a-8(x) - Number of Proposals"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @shareholder
  Scenario: Successfully Submit Supplemental Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Supplemental Correspondence"
      And I wait for ajax to finish
    Then I should see the text "Reference ID"
      And I should see the text "Date of 14a-8 initial request letter:"
      And I should see the text "Company relating to original request"
      And I should see the text "Proponent relating to original request"
      And I type "12345" in css selector "#edit-reference-id-supplemental"
      And I fill in "letter_date" with "06/24/2050"
      And I fill in "Company relating to original request" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Proponent relating to original request" with "Tony Stark"
      And I fill in "Company Name" with "Mars Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Howard Stark"
      And I fill in "Proponent Contact Name" with "Larry Stark"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Proponent"
      And I should see the text "Supplemental Correspondence"
      And I should see the text "12345"
      And I should see the text "06/24/2050"
      And I should see the text "Metadata Metrics Encapsulation Inc"
      And I should see the text "Tony Stark"
      And I should see the text "Mars Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Howard Stark"
      And I should see the text "Larry Stark"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "behat-corpfin2-wts-shp-wf1.docx"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @shareholder
  Scenario: Successfully Submit Reconsideration Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Show type of request"
      And I wait for ajax to finish
    Then I should see the text "Reference ID"
      And I type "12345" in css selector "#edit-reference-id-reconsideration"
      And I fill in "Company Name" with "Mars Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Howard Stark"
      And I fill in "Proponent Contact Name" with "Larry Stark"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I should see the text "Division of Corporation Finance Informal Procedures Regarding Shareholder Proposals"
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "Proponent"
      And I should see the text "Reconsideration Request"
      And I should see the text "12345"
      And I should see the text "Mars Inc"
      And I should see the text "Jhonny Appleseed"
      And I should see the text "999-123-1111"
      And I should see the text "testemail+1@testemail.com"
      And I should see the text "Howard Stark"
      And I should see the text "Larry Stark"
      And I should see the text "999-123-2222"
      And I should see the text "testemail+2@testemail.com"
      And I should see the text "March 24, 2050"
      And I should see the text "This is a resolved clause statement"
      And I should see the text "Rule 14a-8(x) - Procedural/Eligibility"
      And I should see the text "behat-corpfin2-wts-shp-wf1.doc"
      And I should see the text "behat-corpfin2-wts-shp-wf1.docx"
      And I should see the text "behat-corpfin2-wts-shp-wf1.pdf"
    When I press "Submit"
    Then I should see the text "Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @shareholder
  Scenario: Webform Displays Server Validation When Missing File Upload On Shareholders Proposal Webform
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I press "Preview"
    Then I should see the text "Please attach one or more files to your request."

@api @shareholder
  Scenario: Webform Displays Server Validation When Taxomomy-Based Bases Asserted Checkbox Is Not Checked
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I fill in "Resolved Clause" with "This is a resolved clause statement"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I press "Preview"
    Then I should see the text "Bases Asserted: field is required."

@api @javascript  @shareholder
  Scenario: Webform Displays Validation For Unsupported Upload File Format On Shareholders Proposal Webform
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I attach the file "behat-corpfin2-wts-wf1.pptx" to "files[upload_request][]"
      And I wait for ajax to finish
    Then I should see the text "The selected file behat-corpfin2-wts-wf1.pptx cannot be uploaded. Only files with the following extensions are allowed: pdf, doc, docx"

@api @javascript @shareholder
  Scenario: Webform Displays Validation For Upload File Size Limit Being Exceeded On Shareholders Proposal Webform
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I attach the file "behat-corpfin2-wts-wf_10_12mb.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
    Then I should see the text "The specified file behat-corpfin2-wts-wf_10_12mb.pdf could not be uploaded."
      And I should see the text "The file is 10.12 MB exceeding the maximum file size of 10 MB."

@api @javascript @shareholder
  Scenario: Max Number Of Upload Files Allowed For Shareholders Proposal Webform
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I attach the file "behat-corpfin2-wts-wf3.doc" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf3.docx" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf3.pdf" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf4.doc" to "files[upload_request][]"
      And I wait for ajax to finish
      And I attach the file "behat-corpfin2-wts-wf4.docx" to "files[upload_request][]"
      And I wait for ajax to finish
    Then I should see the "input" element with the "style" attribute set to "display:none" in the "webform_fileupload" region

@api @javascript @shareholder
  Scenario: Max Character Limit for Resolved Clause section of Shareholders Proposal Webform
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "Metadata Metrics Encapsulation Inc"
      And I fill in "Contact Name" with "Jhonny Appleseed"
      And I fill in "Contact Phone Number" with "999-123-1111"
      And I fill in "Contact Email" with "testemail+1@testemail.com"
      And I fill in "Proponent Name" with "Tony Stark"
      And I fill in "Proponent Contact Name" with "Iron Man"
      And I fill in "Proponent Contact Phone Number" with "999-123-2222"
      And I fill in "Proponent Contact Email" with "testemail+2@testemail.com"
      And I fill in "proxy_print_date" with "03/24/2050"
      And I should see the text "The maximum character limit is 2000."
      And I fill in "Resolved Clause" with "This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit testtt<-2000 characters here"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I wait for ajax to finish
      And I press "Preview"
    Then I should see the text "Please take a minute to review what you've written"
      And I should see the text "This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit test. This is the 2000 characters limit testtt"

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Initial Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Initial Request"
      And I fill in "Company Name" with "<company_name>"
      And I fill in "Contact Name" with "<contact_name>"
      And I fill in "Contact Phone Number" with "<contact_phone>"
      And I fill in "Contact Email" with "<contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | company_name                       | contact_name     | contact_phone | contact_email             | proxy_print_date | resolved_clause                     |
      |                                    | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc |                  | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed |               | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  |                           | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       |                                     |

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Supplemental Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Supplemental Correspondence"
      And I fill in "letter_date" with "<letter_date>"
      And I fill in "Company relating to original request" with "<company_original_request>"
      And I fill in "Proponent relating to original request" with "<proponent_original_request>"
      And I fill in "Company Name" with "<company_name>"
      And I fill in "Contact Name" with "<contact_name>"
      And I fill in "Contact Phone Number" with "<contact_phone>"
      And I fill in "Contact Email" with "<contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | letter_date | company_original_request           | proponent_original_request | company_name                       | contact_name     | contact_phone | contact_email             | proxy_print_date | resolved_clause                     |
      |             | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  |                                    | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc |                            | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 |                                    | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc |                  | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed |               | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  |                           | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       |                                     |

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Reconsideration Shareholders Proposal Webform With Company As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Company"
      And I select the radio button "Show type of request"
      And I fill in "Company Name" with "<company_name>"
      And I fill in "Contact Name" with "<contact_name>"
      And I fill in "Contact Phone Number" with "<contact_phone>"
      And I fill in "Contact Email" with "<contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.doc" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | company_name                       | contact_name     | contact_phone | contact_email             | proxy_print_date | resolved_clause                     |
      |                                    | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc |                  | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed |               | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  |                           | 03/24/2050       | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | Metadata Metrics Encapsulation Inc | Jhonny Appleseed | 999-123-1111  | testemail+1@testemail.com | 03/24/2050       |                                     |

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Initial Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Initial Request"
      And I fill in "Proponent Name" with "<proponent_name>"
      And I fill in "Proponent Contact Name" with "<proponent_contact_name>"
      And I fill in "Proponent Contact Phone Number" with "<proponent_contact_phone>"
      And I fill in "Proponent Contact Email" with "<proponent_contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | proponent_name | proponent_contact_name | proponent_contact_phone | proponent_contact_email   | proxy_print_date | resolved_clause                     |
      |                | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     |                        | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               |                         | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            |                           | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       |                                     |

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Supplemental Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Supplemental Correspondence"
      And I fill in "letter_date" with "<letter_date>"
      And I fill in "Company relating to original request" with "<company_original_request>"
      And I fill in "Proponent relating to original request" with "<proponent_original_request>"
      And I fill in "Proponent Name" with "<proponent_name>"
      And I fill in "Proponent Contact Name" with "<proponent_contact_name>"
      And I fill in "Proponent Contact Phone Number" with "<proponent_contact_phone>"
      And I fill in "Proponent Contact Email" with "<proponent_contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.docx" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | letter_date | company_original_request           | proponent_original_request | proponent_name | proponent_contact_name | proponent_contact_phone | proponent_contact_email   | proxy_print_date | resolved_clause                     |
      |             | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  |                                    | Tony Stark                 | Larry Stark    | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc |                            | Larry Stark    | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 |                | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    |                        | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    | Iron Man               |                         | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    | Iron Man               | 999-123-1111            |                           | 03/24/2050       | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    | Iron Man               | 999-123-1111            | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | 06/24/2050  | Metadata Metrics Encapsulation Inc | Tony Stark                 | Larry Stark    | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       |                                     |

@api @shareholder
  Scenario Outline: Webform Mandatory Fields - Reconsideration Shareholders Proposal Webform With Proponent As Submitting Party
    Given I am logged in as a user with the "authenticated" role
      And I am on "/forms/shareholder-proposal"
    Then I should see the heading "Shareholder Proposal"
    When I select the radio button "Proponent"
      And I select the radio button "Show type of request"
       And I fill in "Proponent Name" with "<proponent_name>"
      And I fill in "Proponent Contact Name" with "<proponent_contact_name>"
      And I fill in "Proponent Contact Phone Number" with "<proponent_contact_phone>"
      And I fill in "Proponent Contact Email" with "<proponent_contact_email>"
      And I fill in "proxy_print_date" with "<proxy_print_date>"
      And I fill in "Resolved Clause" with "<resolved_clause>"
      And I check the box "Rule 14a-8(x) - Procedural/Eligibility"
      And I attach the file "behat-corpfin2-wts-shp-wf1.pdf" to "files[upload_request][]"
      And I press "Preview"
    Then I should not see the text "Please take a minute to review what you've written"

    Examples:
      | proponent_name | proponent_contact_name | proponent_contact_phone | proponent_contact_email   | proxy_print_date | resolved_clause                     |
      |                | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     |                        | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               |                         | testemail+1@testemail.com | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            |                           | 03/24/2050       | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            | testemail+1@testemail.com |                  | This is a resolved clause statement |
      | Tony Stark     | Iron Man               | 999-123-1111            | testemail+1@testemail.com | 03/24/2050       |                                     |
