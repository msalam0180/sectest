Feature: Validate Migrated Webform
  As an end user
  I want to be able to see and fill-in the correct fields for a webform
  So that I can submit the correct information to SEC.gov

@api @javascript
Scenario: Submit Request for Copies of Documents Webform
  Given I am on "/forms/request_public_docs"
    And I select "Mr" from "Title"
    And I fill in "First" with "John"
    And I fill in "MI" with "Q"
    And I fill in "Last" with "Doe"
    And I fill in "Suffix (If any)" with "Senior"
    And I fill in "Telephone" with "1234567890"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I fill in "Company Name, if Applicable" with "SEC"
    And I select "United States" from "Country"
    And I wait for AJAX to finish
    And I fill in "Street address" with "100 F Street"
    And I fill in "Zip code" with "20112"
    And I fill in "City" with "Manassas"
    And I select "Virginia" from "State"
    And I fill in "Subject/Company Name" with "ABC Company"
    And I fill in "Date or range of document" with "Year 2018"
    And I select "Administrative Proceeding" from "Type of document"
    And I select the radio button "Willing to Pay $61"
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for Copies of Documents Webform (Negative)
  Given I am on "/forms/request_public_docs"
    And I fill in "First" with "John"
    And I fill in "MI" with "Q"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Request for FOIA Feedback Survey
  Given I am on "/forms/foia_feedback"
    And I fill in "Please tell us how we are doing." with "This is a test data submission. Please Delete."
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for FOIA Feedback Survey (Negative)
  Given I am on "/forms/foia_feedback"
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Request for Freedom of Information Act Appeal
  Given I am on "/forms/request_appeal"
    And I select "Dr" from "Prefix"
    And I fill in "First" with "Ceelo"
    And I fill in "MI" with "A"
    And I fill in "Last" with "Devin"
    And I fill in "Suffix" with "III"
    And I fill in "Telephone" with "123-123-1234"
    And I fill in "Email" with "testing@testing.123"
    And I fill in "Company Name, if Applicable" with "Apple"
    And I select "Philippines" from "Country"
    And I wait for ajax to finish
    And I fill in "Street address" with "1234 Bataan Street"
    And I fill in "Postal code" with "1006"
    And I fill in "City" with "Manila"
    And I select "Metro Manila" from "Province"
    And I fill in "FOIA Request Number" with "FOIA Number 1234"
    And I fill in "FOIA Request Subject" with "FOIA Validation"
    And I fill in "Name of the Deciding Official" with "Judge Judy"
    And I fill in "Date of Denial" with "12/31/2000"
    And I select "FEE CLASSIFICATION" from "Adverse Decision"
    And I fill in "Your FOIA Appeal" with "Appealing as it is a test data and should not be considered."
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for Freedom of Information Act Appeal (Negative)
  Given I am on "/forms/request_appeal"
    And I fill in "First" with "Ceelo"
    And I fill in "MI" with "A"
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Request for Reasonable Accommodation for Participation in Job Application Process
  Given I am on "/forms/ADA4Applicants"
    And I fill in "Name" with "John"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I fill in "Alternate Contact Information - Telephone" with "1234567890"
    And I fill in "Describe Accommodation" with "10142000"
    And I fill in "Date Accommodation Needed" with "12/31/2000"
    And I fill in "Time Accommodation Needed" with "0101PM"
    And I fill in "Place accommodation needed - address and room number" with "100 F Street"
    And I fill in "Name of SEC Hiring Official or HR Contact" with "ABC Company"
    And I fill in "Optional Comments" with "20112"
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for Reasonable Accommodation for Participation in Job Application Process (Negative)
  Given I am on "/forms/ADA4Applicants"
    And I fill in "Name" with "John"
    And I fill in "Optional Comments" with "20112"
  #Need to disable captcha to pass the feature.
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Request for Reasonable Accommodation for Participation in SEC Public Programs
  Given I am on "/forms/ADA4Programs"
    And I fill in "Name" with "John"
    And I fill in "Your Email Address" with "drupalsupport@sec.gov"
    And I fill in "Alternate Contact Information - Telephone" with "1234567890"
    And I fill in "Describe Accommodation" with "10142000"
    And I fill in "Date Accommodation Needed" with "12/31/2000"
    And I fill in "Time Accommodation Needed" with "0101PM"
    And I fill in "Place accommodation needed - address and room number" with "100 F Street"
    And I fill in "Name of SEC Public Program" with "ABC Company"
#  And I fill in "Optional Comments" with "20112"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for Reasonable Accommodation for Participation in SEC Public Programs (Negative)
  Given I am on "/forms/ADA4Programs"
    And I wait 2 seconds
    And I fill in "Name" with "John"
#  And I fill in "Optional Comments" with "20112"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Request for SEC Government-Business Forum on Small Business Capital Formation
  Given I am on "/forms/surveysbforum"
    And I select the radio button "High priority" with the id "edit-question1-1"
    And I select the radio button "Medium priority" with the id "edit-question1-2"
    And I select the radio button "Low priority" with the id "edit-question1-3"
    And I select the radio button "No priority" with the id "edit-question1-4"
    And I select the radio button "High priority" with the id "edit-question2-1"
    And I select the radio button "Medium priority" with the id "edit-question2-2"
    And I select the radio button "Low priority" with the id "edit-question2-3"
    And I select the radio button "No priority" with the id "edit-question2-4"
    And I select the radio button "High priority" with the id "edit-question3-1"
    And I select the radio button "Medium priority" with the id "edit-question3-2"
    And I select the radio button "Low priority" with the id "edit-question3-3"
    And I select the radio button "No priority" with the id "edit-question3-4"
    And I select the radio button "High priority" with the id "edit-question4-1"
    And I select the radio button "Medium priority" with the id "edit-question4-2"
    And I select the radio button "Low priority" with the id "edit-question4-3"
    And I select the radio button "No priority" with the id "edit-question4-4"
    And I select the radio button "High priority" with the id "edit-question5-1"
    And I select the radio button "Medium priority" with the id "edit-question5-2"
    And I select the radio button "Low priority" with the id "edit-question5-3"
    And I select the radio button "No priority" with the id "edit-question5-4"
    And I select the radio button "High priority" with the id "edit-question6-1"
    And I select the radio button "Medium priority" with the id "edit-question6-2"
    And I select the radio button "Low priority" with the id "edit-question6-3"
    And I select the radio button "No priority" with the id "edit-question6-4"
    And I select the radio button "High priority" with the id "edit-question7-1"
    And I select the radio button "Medium priority" with the id "edit-question7-2"
    And I select the radio button "Low priority" with the id "edit-question7-3"
    And I select the radio button "No priority" with the id "edit-question7-4"
    And I select the radio button "High priority" with the id "edit-question8-1"
    And I select the radio button "Medium priority" with the id "edit-question8-2"
    And I select the radio button "Low priority" with the id "edit-question8-3"
    And I select the radio button "No priority" with the id "edit-question8-4"
    And I select the radio button "High priority" with the id "edit-question9-1"
    And I select the radio button "Medium priority" with the id "edit-question9-2"
    And I select the radio button "Low priority" with the id "edit-question9-3"
    And I select the radio button "No priority" with the id "edit-question9-4"
    And I select the radio button "High priority" with the id "edit-question10-1"
    And I select the radio button "Medium priority" with the id "edit-question10-2"
    And I select the radio button "Low priority" with the id "edit-question10-3"
    And I select the radio button "No priority" with the id "edit-question10-4"
    And I fill in "Feel free to leave comments below" with "drupalsupport@sec.gov"
    And I fill in "Your e-mail address" with "drupalsupport@sec.gov"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Request for SEC Government-Business Forum on Small Business Capital Formation (Negative)
  Given I am on "/forms/surveysbforum"
    And I fill in "Feel free to leave comments below" with "drupalsupport@sec.gov"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Non-Competitive Hiring Authorities Webform
  Given I am on "/forms/schedaselectiveplacement"
  When I fill in "First Name" with "John"
    And I fill in "Last Name" with "Doe III"
    And I select the radio button "Yes"
    And I select "Maryland" from "State"
    And I fill in "Phone Number" with "+44 7911 123456 EXT 7945"
    And I fill in "Your Email Address" with "drupalsupport@sec.gov"
    And I select the radio button "Yes" with the id "edit-federal-government-employee-yes"
    And I fill in "Title" with "Beef Inspector"
    And I fill in "Series" with "Wagyu"
    And I fill in "Grade" with "A5"
    And I fill in "Start Date (approximate)" with "11/12/2000"
    And I fill in "End Date (approximate)" with "11/13/2000"
    And I fill in "Agency" with "USDA"
    And I fill in "Highest Grade Held" with "A4"
    And I select the radio button "No" with the id "edit-schedule-c-appointment-no"
    And I check the box "Schedule A: People with Disabilities"
    And I check the box "Veterans Recruitment Appointment (VRA)"
    And I select "Washington, DC" from "Select the one (1) location you wish to be placed."
    And I attach the file "behat-file.pdf" to "Resume"
    And I wait for ajax to finish
    And I attach the file "behat-file.pdf" to "Schedule A Certification"
    And I wait for ajax to finish
    And I attach the file "behat-file.pdf" to "DD-214, Member-4 Copy"
    And I wait for ajax to finish
    And I attach the file "behat-file.pdf" to "Veterans Affairs Letter (to include compensable service-connected disability %)"
    And I wait for ajax to finish
    And I attach the file "behat-file.pdf" to "Transcript(s)"
    And I wait for ajax to finish
    And I press the "Submit" button
    And I wait for ajax to finish
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Non-Competitive Hiring Authorities Webform (Negative)
  Given I am on "/forms/schedaselectiveplacement"
    And I fill in "First Name" with "John"
    And I fill in "Last Name" with "Needs Help"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Notice of Representation Pursuant to SEC Conduct Rule 8(b) and Request for Waiver Pursuant to SEC Conduct Rule 8(d) Webform
  Given I am on "/forms/8b-letter"
  When I attach the file "behat-file.pdf" to "Upload letter"
    And I wait for ajax to finish
    And I fill in "Additional Comments" with "Nice work"
    And I press the "Submit" button
    And I wait for ajax to finish
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Notice of Representation Pursuant to SEC Conduct Rule 8(b) and Request for Waiver Pursuant to SEC Conduct Rule 8(d) Webform (Negative)
  Given I am on "/forms/8b-letter"
    And I fill in "Additional Comments" with "Nice work"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Notice of Representation Pursuant to SEC Conduct Rule 8(b) and Request for Waiver Pursuant to SEC Conduct Rule 8(d) Webform (PDF)
  Given I am on "/forms/8b-letter"
    And I click "sample Rule 8"
  Then I should be on "/about/offices/ethics/post-emp-sample-ltrs.pdf"

@api @javascript
Scenario: Download Notice of Representation Pursuant to SEC Conduct Rule 8(b) and Request for Waiver Pursuant to SEC Conduct Rule 8(d) Webform Attachments as Sitebuilder
  Given I am on "/forms/8b-letter"
  When I attach the file "behat-file_stfpaper.pdf" to "Upload letter"
    And I wait for ajax to finish
    And I fill in "Additional Comments" with "Nice work"
    And I press the "Submit" button
    And I wait for ajax to finish
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Sitebuilder" role
    And I am on "/admin/content/files"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
    And I am on "/admin/structure/webform/manage/8b_letter/results/submissions"
  Then I should see the text "Anonymous" in the "Nice work" row
    And I should see the link "behat-file_stfpaper.pdf"
  #Checking that attachment links don't open up or download files for sitebuilder
  When I click "behat-file_stfpaper.pdf" in the "Nice work" row
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I wait 1 seconds
    And I click "Edit" in the "Nice work" row
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "View"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Table"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Resend"
    And I scroll to the bottom
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I scroll to the top
    And I click on the element with css selector "li.tabs__tab:nth-child(2) > a:nth-child(1)"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
    And I switch to the new window
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript
Scenario: Submit Voluntary Submission of General Solicitation Materials Used in Rule 506(c) Offerings Webform
  Given I am on "/forms/rule506c"
  When I attach the file "behat-file.doc" to "Attach documents"
    And I wait for ajax to finish
    And I fill in "First name" with "John"
    And I fill in "Last name" with "Nick"
    And I fill in "Email address" with "drupalsupport@sec.gov"
    And I fill in "Phone number" with "1234567890"
    And I fill in "ZIP Code" with "61202"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Voluntary Submission of General Solicitation Materials Used in Rule 506(c) Offerings Webform (Negative)
  Given I am on "/forms/rule506c"
    And I fill in "First name" with "John"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Submit Rule 506(c) Webform with Multiple Attachments
  Given I am on "/forms/rule506c"
  #Validate multiple attachments upload
  When I attach the file "behat-webform.pdf" to "Attach documents"
    And I wait for ajax to finish
    And I attach the file "behat-webform.docx" to "Attach documents"
    And I wait for ajax to finish
    And I attach the file "behat-webform.txt" to "Attach documents"
    And I wait for ajax to finish
  Then I should see the text "behat-webform.docx"
    And I should see the text "behat-webform.txt"
    And I should see the text "behat-webform.pdf"
  When I fill in "First name" with "Jane"
    And I fill in "Last name" with "Doe"
    And I fill in "Email address" with "jane@test.test"
    And I fill in "Phone number" with "202-555-5555"
    And I fill in "ZIP Code" with "20001"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Sitebuilder" role
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Anonymous" in the "Jane Doe" row
  #Checking that attachment links show up for drupal users
    And I should see the link "behat-webform.docx"
    And I should see the link "behat-webform.txt"
    And I should see the link "behat-webform.pdf"

@api @javascript
Scenario: Role Access To Rule 506(c) Webform Submissions
  Given I am on "/forms/rule506c"
  When I attach the file "behat-form1.pdf" to "Attach documents"
    And I wait for ajax to finish
  Then I should see the text "behat-form1.pdf"
  When I fill in "First name" with "Jill"
    And I fill in "Last name" with "Doe"
    And I fill in "Email address" with "jill@test.test"
    And I fill in "Phone number" with "202-555-5557"
    And I fill in "ZIP Code" with "20003"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Content Creator" role
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Error 403: Forbidden"
    And I am on "/admin/content/files"
  Then I should see the link "behat-form1.pdf"
  When I click "behat-form1.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I am logged in as a user with the "Content Approver" role
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Error 403: Forbidden"
  When I am on "/admin/content/files"
  Then I should see the link "behat-form1.pdf"
  When I click "behat-form1.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I am logged in as a user with the "Individual Defendants" role
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Error 403: Forbidden"
  When I am on "/admin/content/files"
  Then I should see the link "behat-form1.pdf"
  When I click "behat-form1.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I am logged in as a user with the "Division/Office Admin" role
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Error 403: Forbidden"
  When I am on "/admin/content/files"
  Then I should see the link "behat-form1.pdf"
  When I click "behat-form1.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript
Scenario: Download Rule 506(c) Webform Attachments As Sitebuilder
  Given I am on "/forms/rule506c"
  When I attach the file "behat-wbform.pdf" to "Attach documents"
    And I wait for ajax to finish
  Then I should see the text "behat-wbform.pdf"
  #Checking attachments don't show up as links from public user's view
    But I should not see the link "behat-wbform.pdf"
  When I fill in "First name" with "John"
    And I fill in "Last name" with "Doe"
    And I fill in "Email address" with "john@test.test"
    And I fill in "Phone number" with "202-555-5556"
    And I fill in "ZIP Code" with "20002"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Sitebuilder" role
    And I am on "/admin/content/files"
  Then I should see the link "behat-wbform.pdf"
  When I click "behat-wbform.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Anonymous" in the "John Doe" row
    And I should see the link "behat-wbform.pdf"
  #Checking that attachment links don't open up or download files for sitebuilder
  When I click "behat-wbform.pdf" in the "John Doe" row
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I wait 1 seconds
    And I click "Edit" in the "John Doe" row
  Then I should see the link "behat-wbform.pdf"
  When I click "View"
  Then I should see the link "behat-wbform.pdf"
  When I click "behat-wbform.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Table"
  Then I should see the link "behat-wbform.pdf"
  When I click "behat-wbform.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Resend"
    And I click on the element with css selector "#edit-message-handler-id-email-1"
    And I wait for ajax to finish
  Then I should see the link "behat-wbform.pdf"
  When I click "behat-wbform.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I scroll to the top
    And I click on the element with css selector "li.tabs__tab:nth-child(2) > a:nth-child(1)"
  Then I should see the link "behat-wbform.pdf"
  When I click "behat-wbform.pdf"
    And I switch to the new window
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript
Scenario: Download Rule 506(c) Webform Attachments As Administrator
  Given I am on "/forms/rule506c"
  When I attach the file "behat-file_mkstr.pdf" to "Attach documents"
    And I wait for ajax to finish
  Then I should see the text "behat-file_mkstr.pdf"
  When I fill in "First name" with "Jason"
    And I fill in "Last name" with "Doe"
    And I fill in "Email address" with "json@test.test"
    And I fill in "Phone number" with "202-555-5558"
    And I fill in "ZIP Code" with "20004"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Administrator" role
    And I am on "/admin/content/files"
  Then I should see the link "behat-file_mkstr.pdf"
  When I click "behat-file_mkstr.pdf"
  Then I should not see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
    And I am on "/admin/structure/webform/manage/rule506c/results/submissions"
  Then I should see the text "Anonymous" in the "Jason Doe" row
    And I should see the link "behat-file_mkstr.pdf"
  #Checking that attachment links do open up or download files for sitebuilder
  When I click "behat-file_mkstr.pdf" in the "Jason Doe" row
  Then I should not see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I click "Edit" in the "Jason Doe" row
  Then I should see the link "behat-file_mkstr.pdf"
  When I click "View"
  Then I should see the link "behat-file_mkstr.pdf"
  When I click "behat-file_mkstr.pdf"
  Then I should not see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I click "Table"
  Then I should see the link "behat-file_mkstr.pdf"
  When I click "behat-file_mkstr.pdf"
  Then I should not see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I click "Resend"
    And I click on the element with css selector "#edit-message-handler-id-email-1"
    And I wait for ajax to finish
  Then I should see the link "behat-file_mkstr.pdf"
  When I click "behat-file_mkstr.pdf"
  Then I should not see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript
Scenario: Submit Applications for Exemption under Section 36 of the Securities Exchange Act of 1934 Webform
  Given I am on "/forms/exemptive_application"
    And I fill in "Email address" with "drupalsupport@sec.gov"
  When I attach the file "behat-file.doc" to "Upload Documents"
    And I wait for ajax to finish
    And I fill in "Additional Comments (Optional)" with "Need Help"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

@api
Scenario: Submit Applications for Exemption under Section 36 of the Securities Exchange Act of 1934 Webform (Negative)
  Given I am on "/forms/exemptive_application"
    And I fill in "Email address" with "drupalsupport@sec.gov"
    And I fill in "Additional Comments (Optional)" with "Need Help"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript
Scenario: Download Applications for Exemption under Section 36 of the Securities Exchange Act of 1934 Webform as Sitebuilder
  Given I am on "/forms/exemptive_application"
    And I fill in "Email address" with "exemptive_application@test.test"
  When I attach the file "behat-file_stfpaper.pdf" to "Upload Documents"
    And I wait for ajax to finish
    And I fill in "Additional Comments (Optional)" with "Need Help"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  When I am logged in as a user with the "Sitebuilder" role
    And I am on "/admin/content/files"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
    And I am on "/admin/structure/webform/manage/exemptive_application/results/submissions"
  Then I should see the text "Anonymous" in the "exemptive_application@test.test" row
    And I should see the link "behat-file_stfpaper.pdf"
  #Checking that attachment links don't open up or download files for sitebuilder
  When I click "behat-file_stfpaper.pdf" in the "exemptive_application@test.test" row
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I wait 1 seconds
    And I click "Edit" in the "exemptive_application@test.test" row
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "View"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Table"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I click "Resend"
    And I click on the element with css selector "#edit-message-handler-id-email-1"
    And I wait for ajax to finish
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."
  When I move backward one page
    And I scroll to the top
    And I click on the element with css selector "li.tabs__tab:nth-child(2) > a:nth-child(1)"
  Then I should see the link "behat-file_stfpaper.pdf"
  When I click "behat-file_stfpaper.pdf"
    And I switch to the new window
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript @IMWF
Scenario Outline: Submit IM No-Action and Interpretive Letters Webform
  Given I am on "/forms/im-no-action"
    And I should see the heading "Division of Investment Management Submission Form for No-Action and Interpretive Letters"
    And the hyperlink "issued by the Division of Investment Management" should match the Drupal url "https://www.sec.gov/investment/investment-management-no-action-letters"
    And the hyperlink "Privacy Act Notice" should match the Drupal url "https://www.sec.gov/privacy.htm"
  When I attach the file "<filetype>" to "Attachment File(s)"
    And I wait for ajax to finish
    And I fill in "Name" with "<Name>"
    And I fill in "Telephone" with "+44 7911 123456 EXT 7945"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I select the radio button "<Type>"
    And I fill in "Topic" with "<Topic>"
    And I press the "Submit" button
  Then I should see the heading "Division of Investment Management Submission Form for No-Action and Interpretive Letters"
    And I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"

  Examples:
    | filetype           | Name               | Type    | radio_button                       | Topic              |
    | behat-webform.docx | John O'Jello       | Initial | edit-type-of-request-field-initial | An initial request |
    | behat-webform.pdf  | Plain Jane Johnson | Revised | edit-type-of-request-field-revised | A revised request  |

@api @javascript @IMWF
Scenario: Validate Attachment Field for IM No-Action and Interpretive Letters Webform Submission
  Given I am on "/forms/im-no-action"
  When I fill in "Name" with "John Negative"
    And I fill in "Telephone" with "2025550000"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I select the radio button "Revised"
    And I fill in "Topic" with "validate attachment"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @IMWF
Scenario: Validate Request Type Field for IM No-Action and Interpretive Letters Webform
  Given I am on "/forms/im-no-action"
  When I attach the file "behat-webform.txt" to "Attachment File(s)"
    And I wait for ajax to finish
    And I fill in "Name" with "Just Jeff"
    And I fill in "Telephone" with "2025550000"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I fill in "Topic" with "validate request type"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

@api @javascript @IMWF
Scenario Outline: Mandatory Fields Populated for IM No-Action and Interpretive Letters Webform Submission
  Given I am on "/forms/im-no-action"
    And I should see the heading "Division of Investment Management Submission Form for No-Action and Interpretive Letters"
  When I attach the file "behat-webform.pdf" to "Attachment File(s)"
    And I wait for ajax to finish
    And I fill in "Name" with "<Name>"
    And I fill in "Telephone" with "<Telephone>"
    And I fill in "Email" with "<Email>"
    And I select the radio button "Initial"
    And I fill in "Topic" with "<Topic>"
    And I press the "Submit" button
  Then I should not see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."

  Examples:
    | Name | Telephone  | Email                 | Topic      |
    |      | 2025550000 | drupalsupport@sec.gov | Validation |
    | John |            | drupalsupport@sec.gov | Validation |
    | John | 2025550000 |                       | Validation |
    | John | 2025550000 | drupalsupport@sec.gov |            |

@api @javascript @IMWF
Scenario: Multiple Attachments On IM No-Action and Interpretive Letters Webform Submission
  Given I am on "/forms/im-no-action"
  #Validate multiple attachments with different type upload
  When I attach the file "behat-file-im.pdf" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.docx" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.txt" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.doc" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.ppt" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.pptx" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.xls" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-file-im.xlsx" to "Attachment File(s)"
    And I wait for ajax to finish
  Then I should see the text "behat-file-im.docx"
    And I should see the text "behat-file-im.txt"
    And I should see the text "behat-file-im.pdf"
    And I should see the text "behat-file-im.doc"
    And I should see the text "behat-file-im.ppt"
    And I should see the text "behat-file-im.pptx"
    And I should see the text "behat-file-im.xls"
    And I should see the text "behat-file-im.xlsx"
  When I fill in "Name" with "Jack O'Connor"
    And I fill in "Telephone" with "2025550000"
    And I fill in "Email" with "drupalsupport@sec.gov"
    And I select the radio button "Initial"
    And I fill in "Topic" with "Multiple files and formats"
    And I press the "Submit" button
  Then I should see the text "Thank you. Your request was successfully submitted and sent to the appropriate SEC division or office."
    And I should see the link "Back to form"
  #Validate files removal after submission as well as not keeping any submission record in drupal
  When I am logged in as a user with the "Administrator" role
    And I visit "/admin/structure/webform"
  Then I should see the text "0" in the "Division of Investment Management Submission Form for No-Action and Interpretive Letters" row
  When I visit "/admin/structure/webform/manage/im_no_action/results/submissions"
  Then I should not see the text "Jack O'Connor"
    And I should not see the text "2025550000"
    And I should not see the text "drupalsupport@sec.gov"
    And I should not see the text "behat-file-im.docx"
    And I should not see the text "behat-file-im.txt"
    And I should not see the text "behat-file-im.pdf"
    And I should not see the text "behat-file-im.doc"
    And I should not see the text "behat-file-im.ppt"
    And I should not see the text "behat-file-im.pptx"
    And I should not see the text "behat-file-im.xls"
    And I should not see the text "behat-file-im.xlsx"
  When I am on "/admin/content/files"
  Then I should not see the link "behat-file-im.docx"
    And I should not see the link "behat-file-im.txt"
    And I should not see the link "behat-file-im.pdf"
    And I should not see the link "behat-file-im.doc"
    And I should not see the link "behat-file-im.ppt"
    And I should not see the link "behat-file-im.pptx"
    And I should not see the link "behat-file-im.xls"
    And I should not see the link "behat-file-im.xlsx"

@api @javascript @IMWF
Scenario: Uploading Unsupported File Type to IM No-Action and Interpretive Letters Webform
  Given I am on "/forms/im-no-action"
    And I should see the text "Multiple number of files can be uploaded to this field."
    And I should see the text "14 MB limit total size."
    And I should see the text "Allowed types: txt, pdf, doc, docx, ppt, pptx, xls, xlsx"
  When I attach the file "behat-file.zip" to "Attachment File(s)"
    And I wait for ajax to finish
  Then I should see the text "The selected file behat-file.zip cannot be uploaded. Only files with the following extensions are allowed: txt, pdf, doc, docx, ppt, pptx, xls, xlsx."

@api @javascript @IMWF
Scenario: Uploading Files Exceeding 14MB Limit to IM No-Action and Interpretive Letters Webform
  Given I am on "/forms/im-no-action"
  When I attach the file "behat-15mb.txt" to "Attachment File(s)"
    And I wait for ajax to finish
  Then I should see the text "The specified file behat-15mb.txt could not be uploaded."
    And I should see the text "The file is 15 MB exceeding the maximum file size of 14 MB."
  When I attach the file "behat-14mb.txt" to "Attachment File(s)"
    And I wait for ajax to finish
    And I attach the file "behat-1mb.txt" to "Attachment File(s)"
    And I wait for ajax to finish
  Then I should see the text "This form's file upload quota of 14 MB has been exceeded. Please remove some files."

@api @javascript
Scenario: Default File Attachment Settings For Webform Email Handler
  Given I am logged in as a user with the "administrator" role
  When I am on "/admin/structure/webform"
    And I click "Add webform"
    And I wait 2 seconds
    And I fill in "title" with "Testing Ticket 14445"
    And I wait 2 seconds
    And I select "SEC Forms" from "category[select]"
    And I click on the element with css selector "body > div.ui-dialog.ui-corner-all.ui-widget.ui-widget-content.ui-front.webform-ui-dialog.ui-dialog-buttons > div.ui-dialog-buttonpane.ui-widget-content.ui-helper-clearfix > div > button"
    And I wait 20 seconds
  Then I should see the text "Webform Testing Ticket 14445 created."
  When I click "Add element"
    And I wait 2 seconds
    And I fill in "filter" with "File"
    And I click "Add element" in the "File" row
    And I wait 2 seconds
    And I fill in "title" with "Adding Element"
    And I wait 2 seconds
    And I press "Save"
    And I wait 3 seconds
    And I press "Save elements"
    And I wait 2 seconds
  When I am on "/admin/structure/webform"
    And I scroll to the bottom
    And I wait 2 seconds
    And I click "Build" in the "Testing Ticket 14445" row
    And I click on the element with css selector "#block-adminimal-theme-primary-local-tasks > nav > nav > ul > li:nth-child(5) > a"
    And I click "Emails / Handlers"
    And I wait 2 seconds
    And I click "Add email"
    And I wait 2 seconds
    And I press "Expand all"
    And I wait 2 seconds
    And I select "Custom To email address…" from "settings[to_mail][select]"
    And I wait 2 seconds
    And I fill in "settings[to_mail][other]" with "json@test.test"
    And I scroll to the bottom
    And the "settings[exclude_attachments]" checkbox should be checked
    And the "settings[attachments]" checkbox should be checked
    And I press "Save"
    And I wait 2 seconds
  When I am on "/admin/structure/webform"
    And I scroll to the bottom
    And I click "Testing Ticket 14445"
    And I attach the file "behat-file_stfpaper.pdf" to "files[adding_element]"
    And I wait 2 seconds
    And I press "Submit"
  When I am on "/admin/structure/webform"
    And I wait 2 seconds
    And I scroll to the bottom
    And I click "Build" in the "Testing Ticket 14445" row
    And I click on the element with css selector "#block-adminimal-theme-primary-local-tasks > nav > nav > ul > li:nth-child(3) > a"
    And I wait 2 seconds
    And I click "1"
    And I click "Resend"
    And I scroll to the bottom
    And I wait 2 seconds
  Then I should see the link "behat-file_stfpaper.pdf"
    And I should see the text "behat-file_stfpaper.pdf (application/pdf) - 111.91 KB"
  When I am on "/admin/structure/webform/manage/testing_ticket_14445/handlers"
    And I click "Edit" in the "Email" row
    And I wait 2 seconds
    And I scroll to the bottom
    And I wait 2 seconds
    And I uncheck the box "settings[attachments]"
    And I press "Save"
    And I wait 2 seconds
    And I click on the element with css selector "#block-adminimal-theme-primary-local-tasks > nav > nav > ul > li.tabs__tab.is-active > a"
    And I click "Results"
    And I wait 2 seconds
    And I click "1"
    And I wait 2 seconds
    And I click "Resend"
  Then I should not see the text "behat-file_stfpaper.pdf (application/pdf) - 111.91 KB"

@api @javascript
Scenario: End User Access To ARO Moorehouse Registration
  Given I am on "/forms/registration-aro-moorehouse"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file. If you believe you received this message as an error, please try again. If the problem continues, please email the webmaster."

@api @javascript
Scenario: Submit Request For Individual Access to Records Under the Privacy Act
  Given I am on "/forms/request_for_individual_access"
  When I fill in "First Name" with "Jeannie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "III"
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with "12-12345-abCD"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "District of Columbia" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "United States" from "Country"
    And I fill in "Email Address of Requester" with "jastest@test.com"
    And I fill in "Signature" with "Jeannie Apple Seed"
    And I fill in "Date Signed" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date-signed.js-form-item-date-signed > img"
    And I press the "Submit" button
  Then I should see the text "New submission added to Request for Individual Access to Records under the Privacy Act."
  When I check notification
    And I wait 1 seconds
  Then I should see "Webform submission from Request for Individual Access to Records under the Privacy Act" followed by "a few seconds ago"

@api @javascript
Scenario: Submit Request For Individual Access to Records Under the Privacy Act (Negatives)
  Given I am on "/forms/request_for_individual_access"
  When I fill in "First Name" with "Jeannie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "III"
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with "11-11011-ZyxV"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "District of Columbia" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "United States" from "Country"
    And I fill in "Email Address of Requester" with "jastest@test.com"
    And I press the "Submit" button
  #No signature found
  Then I should not see the text "New submission added to Request for Individual Access to Records under the Privacy Act."
  When I uncheck the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "Signature" with "Jeannie Apple Seed"
    And I fill in "Date Signed" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date-signed.js-form-item-date-signed > img"
    And I press the "Submit" button
  #SEC Request No. confirmation box not checked
  Then I should not see the text "New submission added to Request for Individual Access to Records under the Privacy Act."
  When I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with ""
    And I press the "Submit" button
  #SEC Request No. field not filled
  Then I should not see the text "New submission added to Request for Individual Access to Records under the Privacy Act."
  #Country field not selected
  When I fill in "SEC Request No." with "11-11011-ZyxV"
    And I select "- Select -" from "Country"
    And I press the "Submit" button
  Then I should not see the text "New submission added to Request for Individual Access to Records under the Privacy Act."

@api @javascript
Scenario: SEC Request No. Field Validation For Request For Individual Access to Records Under the Privacy Act
  Given I am on "/forms/request_for_individual_access"
  When I fill in "First Name" with "Jeannie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "III"
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
  #First two characters are always numbers
    And I fill in "SEC Request No." with "A3-12345-abCD"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "District of Columbia" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "United States" from "Country"
    And I fill in "Email Address of Requester" with "jastest@test.com"
    And I fill in "Signature" with "Jeannie Apple Seed"
    And I fill in "Date Signed" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date-signed.js-form-item-date-signed > img"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #Characters 4-8 are always numbers
  When I fill in "SEC Request No." with "13-A2345-abCD"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #Last 1-4 characters are always letters
  When I fill in "SEC Request No." with "13-12345-1bCD"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #10-13 characters only + "-" allowed for characters 4-8
  When I fill in "SEC Request No." with "13-12045-abCD"
    And I press the "Submit" button
  Then I should see the text "New submission added to Request for Individual Access to Records under the Privacy Act."
  When I check notification
    And I wait 1 seconds
  Then I should see "Webform submission from Request for Individual Access to Records under the Privacy Act" followed by "a few seconds ago"

@api @javascript
Scenario: Submit Consent for Disclosure of Records Protected under the Privacy Act (Negatives)
  Given I am on "/forms/consent_for_disclosure"
  When I fill in "First Name" with "Jamie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "Jr."
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with "00-00000-zYXv"
    And I fill in "Name of Recipient (Person or Entity) to Whom Disclosure is Authorized:" with "John Doe"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "District of Columbia" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "United States" from "Country"
    And I fill in "Email Address of Recipient" with "jastest@test.com"
    And I press the "Submit" button
  #No signature found
  Then I should not see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."
  When I uncheck the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "Signature" with "Jamie Apple Seed"
    And I fill in "Date" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date.js-form-item-date > img"
    And I press the "Submit" button
  #SEC Request No. confirmation box not checked
  Then I should not see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."
  When I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with ""
    And I press the "Submit" button
  #SEC Request No. field not filled
  Then I should not see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."
  #Country field not selected
  When I fill in "SEC Request No." with "11-11011-ZyxV"
    And I select "- Select -" from "Country"
    And I press the "Submit" button
  Then I should not see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."

@api @javascript
Scenario: Submit Consent for Disclosure of Records Protected under the Privacy Act
  Given I am on "/forms/consent_for_disclosure"
  When I fill in "First Name" with "Jamie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "Jr."
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
    And I fill in "SEC Request No." with "98-76543-DCba"
    And I fill in "Name of Recipient (Person or Entity) to Whom Disclosure is Authorized:" with "John Doe"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "Alaska" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "Canada" from "Country"
    And I fill in "Email Address of Recipient" with "jastest@test.com"
    And I fill in "Signature" with "Jamie Apple Seed"
    And I fill in "Date" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date.js-form-item-date > img"
    And I press the "Submit" button
  Then I should see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."
  When I check notification
    And I wait 1 seconds
  Then I should see "Webform submission from Consent for Disclosure of Records Protected under the Privacy Act" followed by "a few seconds ago"

@api @javascript
Scenario: SEC Request No. Field Validation For Consent for Disclosure of Records Protected under the Privacy Act
  Given I am on "/forms/consent_for_disclosure"
  When I fill in "First Name" with "Jamie"
    And I fill in "Middle Name" with "Apple"
    And I fill in "Last Name" with "Seed"
    And I fill in "Suffix" with "Jr."
    And I check the box "i_confirm_that_i_have_already_submitted_a_privacy_act_request_to"
  #First two characters are always numbers
    And I fill in "SEC Request No." with "4a-76543-DCba"
    And I fill in "Name of Recipient (Person or Entity) to Whom Disclosure is Authorized:" with "John Doe"
    And I fill in "Street Address 1" with "100 F Street NE"
    And I fill in "Street Address 2" with "Station Place"
    And I fill in "City/Town" with "Washington"
    And I select "Alaska" from "State"
    And I fill in "ZIP/Postal Code" with "20549"
    And I select "Canada" from "Country"
    And I fill in "Email Address of Recipient" with "jastest@test.com"
    And I fill in "Signature" with "Jamie Apple Seed"
    And I fill in "Date" with "02/28/2031"
    And I click on the element with css selector "#edit-electronic-signature-and-date > div > div.js-form-item.form-item.js-form-type-date.form-item-date.js-form-item-date > img"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #Characters 4-8 are always numbers + 9th character is always a "-"
  When I fill in "SEC Request No." with "19-9345-abCD"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #Last 1-4 characters are always letters + 10-13 characters only
  When I fill in "SEC Request No." with "14-12345-1bC"
    And I press the "Submit" button
  Then I should see the text "SEC Request No. field is not in the right format."
  #First two characters are always numbers + 10-13 characters only
  When I fill in "SEC Request No." with "4-12345-abCD"
    And I press the "Submit" button
   Then I should see the text "SEC Request No. field is not in the right format."
  When I fill in "SEC Request No." with "08-06543-DCba"
    And I press the "Submit" button
  Then I should see the text "New submission added to Consent for Disclosure of Records Protected under the Privacy Act."
  When I check notification
    And I wait 1 seconds
  Then I should see "Webform submission from Consent for Disclosure of Records Protected under the Privacy Act" followed by "a few seconds ago"

@api
Scenario: Webforms contain Non-US Citizen option
  When I am on "/forms/request_for_individual_access"
  Then the "#edit-state" element should contain "Non-U.S. Citizen" 
  When I am on "/forms/consent_for_disclosure"
  Then the "#edit-state" element should contain "Non-U.S. Citizen" 

# @api @javascript
# Scenario: OIEA Questions and Feedback Webform Submission
#   Given I visit "/oiea/QuestionsAndComments.html"
#   Then I should be on "/oiea/questions-comments#no-back"
#     And I should see the heading "Questions and Feedback"
#     And I should see the text "November 30, 2023"
#   When I select "Mrs." from "Title"
#     And I fill in "First name" with "Lilibet"
#     And I fill in "Middle initial" with "A"
#     And I fill in "Last name" with "Mary"
#     And I fill in "Daytime phone" with "2025505000"
#     And I fill in "E-mail" with "queen@test.com"
#     And I fill in "Your Question or Feedback" with "Thank you your majesty"
#     And I press the "Submit" button
#   Then I should see the text "New submission added to Questions and Feedback."
#     And I should see the link "Back to form"
#   When I click "Back to form"
#   Then I should be on "/oiea/questions-comments#no-back"
#     And I should see the heading "Questions and Feedback"
#   When I check notification
#     And I wait 1 seconds
#   Then I should see "Webform submission from Questions and Feedback" followed by "a few seconds ago"

# @api
# Scenario: Mandatory Fields for OIEA Questions and Comments Webform
#   Given I am on "/oiea/questions-comments"
#   When I select "Mrs." from "Title"
#     And I fill in "First name" with "Lilibet"
#     And I fill in "Middle initial" with "A"
#     And I fill in "Last name" with "Mary"
#     And I fill in "Daytime phone" with "2025505000"
#     And I fill in "Your Question or Feedback" with "Thank you your majesty"
#     And I press the "Submit" button
#   Then I should not see the text "New submission added to Questions and Feedback."
