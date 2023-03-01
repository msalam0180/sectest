Feature: Validate Rule Making Comments Webform
  As an end user
  I want to be able to fill-in and submit a rule making comments webform with questionnaire so as to provide comments/feedback on proposed SEC rulings

@api @javascript
Scenario Outline: Create and Submit a Published Node-Based Rule Making Comments Webform
  Given I am logged in as a user with the "webform, <role>" role
  When I am on "/node/add/customized_comment_form"
  Then I should see the heading "Create Comment Form"
  When I fill in "Title" with "Proposed Ruling XYZ Comment Form 1"
    And I fill in "Display Title" with "Display Title for Proposed Ruling XYZ Comment Form 1"
    And I fill in "ruling" with "ab-12-cd"
    And I fill in "rule_path" with "/comments/ab-12-cd"
    And I fill in "File Number" with "ab-12-cd"
    And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
    And I publish it
  Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form 1 has been created."
    And I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Proposed Ruling XYZ Comment Form 1"
  When I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Address" with "100 Easy Road"
    And I fill in "City/Town" with "Easyville"
    And I select "Virginia" from "State/Province"
    And I fill in "ZIP/Postal Code" with "20002"
    And I select "United States" from "Country"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I check the box "I am submitting on behalf of a third party"
    And I fill in "Submitter's Representative" with "Dr Strange"
    And I fill in "Organization's Name" with "Avengers Defenders Illuminati Infinity Watch"
    And I fill in "Affiliation Name" with "Clea Wong Ancient One"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
    # Files upload - Validation for Upload total file size limit 12mb being exceeded
  When I attach the file "behat-12.1mb.txt" to "files[upload_comments][]"
    And I wait for ajax to finish
  Then I should see the text "The specified file behat-12.1mb.txt could not be uploaded."
    And I should see the text "The file is 12.18 MB exceeding the maximum file size of 12 MB."
    # Unsupported Upload file formats
  When I attach the file "behat-corpfin2-wts-wf1.pptx" to "files[upload_comments][]"
    And I wait for ajax to finish
  Then I should see the text "The selected file behat-corpfin2-wts-wf1.pptx cannot be uploaded. Only files with the following extensions are allowed: txt, doc, docx, pdf."
  When I attach the file "behat-corpfin2-wts-wf1.doc" to "files[upload_comments][]"
    And I wait for ajax to finish
    And I attach the file "behat-corpfin2-wts-wf1.docx" to "files[upload_comments][]"
    And I wait for ajax to finish
    And I attach the file "behat-corpfin2-wts-wf1.pdf" to "files[upload_comments][]"
    And I wait for ajax to finish
    # Max number of upload files (3) allowed where "Choose Files" button becomes hidden
  Then I should see the "input" element with the "style" attribute set to "display:none" in the "ruling_comment_webform_fileupload" region
  When I press "Continue"
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "We post all comments on our website, so please make sure that the text beneath the word comments below does not include:"
    And I should see the text "account numbers"
    And I should see the text "social security numbers, or"
    And I should see the text "other personal identifying information"
    And I should see the text "Tester Dude"
    And I should see the text "Bug Busters & Beyond"
    And I should see the text "100 Easy Road"
    And I should see the text "Easyville"
    And I should see the text "Virginia"
    And I should see the text "20002"
    And I should see the text "United States"
    And I should see the text "testerdude@email.com"
    And I should see the text "999-123-1234"
    And I should see the text "Dr Strange"
    And I should see the text "Avengers Defenders Illuminati Infinity Watch"
    And I should see the text "Clea Wong Ancient One"
    And I should see the text "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I press "Submit"
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd on"
    # List of webform submission (Including own webform submission) on the webform overview Page
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/webform/results/submissions"
  Then I should see the text "Tester Dude" in the "Bug Busters & Beyond" row
    And I should see the text "Bug Busters & Beyond" in the "Tester Dude" row
    And I should see the text "100 Easy Road" in the "Tester Dude" row
    And I should see the text "testerdude@email.com" in the "Tester Dude" row
    # Unique URL should be generated
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit?destination=/admin/content/search"
  Then I should see the text " (Alias: /comments/ab-12-cd/proposed-ruling-xyz-comment-form-1)"
    And the "URL alias" field should contain "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1"
    # Ability to manually override the webform's URL
  When I fill in "URL alias" with "/comments/myurl"
    And I publish it
  Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form 1 has been updated."
  When I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
  Then the "URL alias" field should contain "/comments/myurl"
    # Edit own webform submission
  When I am on "/comments/myurl/webform/results/submissions"
    And I click "Edit" in the "Tester Dude" row
    And I fill in "Commenter's Name (Individual or Organization)" with "Tester Person"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Zappers & Beyond"
    And I press "Continue"
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "Tester Person"
    And I should see the text "Bug Zappers & Beyond"
  When I press "Save"
   And I wait for ajax to finish
  Then I should see the text "Submission updated in Proposed Ruling XYZ Comment Form 1."
    # Ability to download the webform data submitted
  When I am on "/comments/myurl/webform/results/download"
  Then I see the text "The Download page allows a webform node's submissions to be exported into a customizable CSV (Comma Separated Values) file and other common data formats."
    And I should see the "Download" button
    # Delete own webform submission
  When I am on "/admin/structure/webform/submissions/manage"
    And I fill in "Clea Wong" for "edit-search"
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the text "Ruling Comments Form" in the "Proposed Ruling XYZ Comment Form 1" row
    And I press the "List additional actions" button
    And I wait 1 seconds
    And I click on the element with css selector "li.delete.dropbutton-action.secondary-action > a"
    And I click on the element with css selector ".button--primary.js-form-submit.form-submit.ui-button.ui-corner-all.ui-widget"
  Then I should see the text "has been deleted."
    # Delete own webform content type
  When I am on "/admin/content/search"
    And I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
    And I click "edit-delete"
  Then I should see the text "Are you sure you want to delete the content item Proposed Ruling XYZ Comment Form 1?"
  When I press "Delete"
  Then I should see the text "The Comment Form Proposed Ruling XYZ Comment Form 1 has been deleted."

  Examples:
    | role             |
    | sitebuilder      |
    | content_approver |

@api @javascript
Scenario Outline: Edit Others Node-Based Rule Making Comments Webform and Submission
  Given "customized_comment_form" content:
    | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, <role1>" role
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit"
    And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
    And I publish it
  Then I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Proposed Ruling XYZ Comment Form 1"
  When I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
    And I press "Continue"
  Then I should see the text "Please take a minute to review what you've written"
  When I press "Submit"
    And I wait for ajax to finish
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd on"
  # Edit others webform submission
  When I am logged in as a user with the "webform, <role2>" role
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/webform/results/submissions"
    And I click "Edit" in the "Tester Dude" row
    And I fill in "Commenter's Name (Individual or Organization)" with "Tester Person"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Zappers & Beyond"
    And I press "Continue"
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "Tester Person"
    And I should see the text "Bug Zappers & Beyond"
  When I press "Save"
  Then I should see the text "Submission updated in Proposed Ruling XYZ Comment Form 1."

  Examples:
    | role1            | role2            |
    | sitebuilder      | content_approver |
    | content_approver | sitebuilder      |

@api @javascript
Scenario: End User Can Submit a Published Node-Based Rule Making Comments Webform
   Given "customized_comment_form" content:
    | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, sitebuilder" role
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1/edit"
    And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
    And I publish it
  Then I should see the text "Submit Comments on ab-12-cd"
  When I am not logged in
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
  Then I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Proposed Ruling XYZ Comment Form by enduser 1"
  When I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Address" with "100 Easy Road"
    And I fill in "City/Town" with "Easyville"
    And I select "Virginia" from "State/Province"
    And I fill in "ZIP/Postal Code" with "20002"
    And I select "United States" from "Country"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I check the box "I am submitting on behalf of a third party"
    And I fill in "Submitter's Representative" with "Dr Strange"
    And I fill in "Organization's Name" with "Avengers Defenders Illuminati Infinity Watch"
    And I fill in "Affiliation Name" with "Clea Wong Ancient One"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
    And I attach the file "behat-corpfin2-wts-wf1.doc" to "files[upload_comments][]"
    And I wait for ajax to finish
    And I press "Continue"
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "We post all comments on our website, so please make sure that the text beneath the word comments below does not include:"
    And I should see the text "account numbers"
    And I should see the text "social security numbers, or"
    And I should see the text "other personal identifying information"
    And I should see the text "Tester Dude"
    And I should see the text "Bug Busters & Beyond"
    And I should see the text "100 Easy Road"
    And I should see the text "Easyville"
    And I should see the text "Virginia"
    And I should see the text "20002"
    And I should see the text "United States"
    And I should see the text "testerdude@email.com"
    And I should see the text "999-123-1234"
    And I should see the text "Dr Strange"
    And I should see the text "Avengers Defenders Illuminati Infinity Watch"
    And I should see the text "Clea Wong Ancient One"
    And I should see the text "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I press "Submit"
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd on"

@api @javascript
Scenario: End User Cannot Access a Closed Node-based Rule Making Comments Webform
  Given "customized_comment_form" content:
    | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, sitebuilder" role
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1/edit"
    And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
    And I select the radio button "Closed"
    And I publish it
  Then I should see the text "Submit Comments on ab-12-cd"
  When I am not logged in
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
  Then I should see the text "This form is closed to new submissions."

@api @javascript
Scenario: End User Cannot Access a Scheduled Node-Based Rule Making Comments Webform
  Given "customized_comment_form" content:
    | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, sitebuilder" role
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1/edit"
    And I select the first autocomplete option for "Ruling Comments Form" on the "Custom Webform Attachment" field
    And I select the radio button "Scheduled"
    And I fill in the following:
      | field_custom_webform_attachment[0][settings][scheduled][open][date]  | 02/01/2022 |
      | field_custom_webform_attachment[0][settings][scheduled][open][time]  | 12:00:00PM |
      | field_custom_webform_attachment[0][settings][scheduled][close][date] | 02/15/2022 |
      | field_custom_webform_attachment[0][settings][scheduled][close][time] | 12:00:00PM |
    And I publish it
  Then I should see the text "Submit Comments on ab-12-cd"
  When I am not logged in
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
  Then I should see the text "This form is closed to new submissions."

@api
Scenario: End User Cannot Access a Draft Node-Based Rule Making Comments Webform
  Given "customized_comment_form" content:
    | title                                         | field_display_title                                             | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form by enduser 1 | Display Title for Proposed Ruling XYZ Comment Form by enduser 1 | 0      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
  When I am not logged in
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-enduser-1"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file."

@api @javascript
Scenario Outline: Create and Submit a Published Template-Based Rule Making Comments Webform
  Given "customized_comment_form" content:
    | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, <role>" role
    # Template creation
  When I am on "/admin/structure/webform/manage/custom_comments_form/duplicate"
  Then I should see the text "Duplicate 'Custom Comments Form' form"
  When I press the "Edit" button
    And I click the "span.admin-link" element
    And I fill in "Machine-readable name" with "template_based_proposed_ruling_xyz_comment_form_1"
    And I fill in "Title" with "Template-based Proposed Ruling XYZ Comment Form 1"
    And I press "Save"
  Then I should see the text "Webform Template-based Proposed Ruling XYZ Comment Form 1 created."
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit"
    And I select the first autocomplete option for "Template-based Proposed Ruling XYZ Comment Form 1" on the "Custom Webform Attachment" field
    And I publish it
  Then I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Display Title for Proposed Ruling XYZ Comment Form 1"
    And I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Address" with "100 Easy Road"
    And I fill in "City/Town" with "Easyville"
    And I select "Virginia" from "State/Province"
    And I fill in "ZIP/Postal Code" with "20002"
    And I select "United States" from "Country"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I check the box "I am submitting on behalf of a third party"
    And I fill in "Submitter's Representative" with "Dr Strange"
    And I fill in "Organization's Name" with "Avengers Defenders Illuminati Infinity Watch"
    And I fill in "Affiliation Name" with "Clea Wong Ancient One"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I attach the file "behat-corpfin2-wts-wf1.doc" to "files[upload_comments][]"
    And I wait for ajax to finish
  Then I should see the heading "Questions"
  When I fill in "Text field title text" with "This is the title text for the questions"
    And I select the radio button "Answer is 1" with the id "edit-likert-field-type-a"
    And I select the radio button "Answer is 3" with the id "edit-likert-field-type-b--3"
    And I select the radio button "Answer is 6" with the id "edit-likert-field-type-c--6"
    And I select the radio button "No" with the id "edit-radio-field-type-no"
    And I select the radio button "Other (explain)" with the id "edit-radios-field-other-radios-other-"
    And I type "This is an option 'Other' with text field" in css selector "#edit-radios-field-other-other"
    And I fill in "Text field in a group" with "This is a text field in a group"
    And I press "Preview"
    And I wait for ajax to finish
    # Confirmation page steps here
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "We post all comments on our website, so please make sure that the text beneath the word comments below does not include:"
    And I should see the text "account numbers"
    And I should see the text "social security numbers, or"
    And I should see the text "other personal identifying information"
    And I should see the text "Questions"
    And I should see the text "This is the title text for the questions"
    And I should see the text "1st First Question?: Answer is 1"
    And I should see the text "2nd Second Question?: Answer is 3"
    And I should see the text "3th Third Question?: Answer is 6"
    And I should see the text "No"
    And I should see the text "This is an option 'Other' with text field"
    And I should see the text "This is a text field in a group"
    And I should see the text "Bug Busters & Beyond"
    And I should see the text "100 Easy Road"
    And I should see the text "Easyville"
    And I should see the text "Virginia"
    And I should see the text "20002"
    And I should see the text "United States"
    And I should see the text "testerdude@email.com"
    And I should see the text "999-123-1234"
    And I should see the text "Dr Strange"
    And I should see the text "Avengers Defenders Illuminati Infinity Watch"
    And I should see the text "Clea Wong Ancient One"
    And I should see the text "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I press "Submit"
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd"
    # List of webform submission (Including own webform submission) on the webform overview Page
  When I am on "/admin/structure/webform/manage/template_based_proposed_ruling_x/results/submissions"
  Then I should see the text "Tester Dude" in the "Bug Busters & Beyond" row
    And I should see the text "Bug Busters & Beyond" in the "Tester Dude" row
    And I should see the text "100 Easy Road" in the "Tester Dude" row
    And I should see the text "testerdude@email.com" in the "Tester Dude" row
    # Unique URL should be generated
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit?destination=/admin/content/search"
  Then I should see the text " (Alias: /comments/ab-12-cd/proposed-ruling-xyz-comment-form-1)"
    And the "URL alias" field should contain "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1"
    # Ability to manually override the webform's URL
  When I fill in "URL alias" with "/comments/myurl"
    And I press "Save and Create New Draft"
  Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form 1 has been updated."
  When I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
  Then the "URL alias" field should contain "/comments/myurl"
    # Ability to download the webform data submitted
  When I am on "/comments/myurl/webform/results/download"
  Then I see the text "The Download page allows a webform node's submissions to be exported into a customizable CSV (Comma Separated Values) file and other common data formats."
    And I should see the "Download" button
    # Delete own submission
  When I am on "/admin/structure/webform/submissions/manage"
    And I fill in "Clea Wong" for "edit-search"
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the text "Template-based Proposed Ruling XYZ Comment Form 1" in the "Proposed Ruling XYZ Comment Form 1" row
  When I press the "List additional actions" button
    And I wait 1 seconds
    And I click on the element with css selector "li.delete.dropbutton-action.secondary-action > a"
    And I click on the element with css selector ".button--primary.js-form-submit.form-submit.ui-button.ui-corner-all.ui-widget"
  Then I should see the text "has been deleted."
    # Delete content type and template
  When I am on "/admin/structure/webform/manage/template_based_proposed_ruling_x/delete"
    And I check the box "Yes, I want to delete the "
    And I press "Delete"
  Then I should see the text "The webform Template-based Proposed Ruling XYZ Comment Form 1 has been deleted."
  When I am on "/admin/content/search"
    And I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
    And I click "edit-delete"
  Then I should see the text "Are you sure you want to delete the content item Proposed Ruling XYZ Comment Form 1?"
  When I press "Delete"
  Then I should see the text "The Comment Form Proposed Ruling XYZ Comment Form 1 has been deleted."

  Examples:
    | role             |
    | sitebuilder      |
    | content_approver |

@api @javascript
Scenario Outline: Edit Others Template-Based Rule Making Comments Webform and Submission
  Given "customized_comment_form" content:
    | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, <role1>" role
  When I am on "/admin/structure/webform/manage/custom_comments_form/duplicate"
  Then I should see the text "Duplicate 'Custom Comments Form' form"
  When I press the "Edit" button
    And I click the "span.admin-link" element
    And I fill in "Machine-readable name" with "template_based_proposed_ruling_xyz_comment_form_1"
    And I fill in "Title" with "Template-based Proposed Ruling XYZ Comment Form 1"
    And I press "Save"
  Then I should see the text "Webform Template-based Proposed Ruling XYZ Comment Form 1 created."
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit"
    And I select the first autocomplete option for "Template-based Proposed Ruling XYZ Comment Form 1" on the "Custom Webform Attachment" field
    And I publish it
    # Steps here for commenter's info section (same as node-based form)
  Then I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Display Title for Proposed Ruling XYZ Comment Form 1"
  When I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
    And I attach the file "behat-corpfin2-wts-wf1.doc" to "files[upload_comments][]"
    And I wait for ajax to finish
    # Steps here for custom questions section
    And I should see the heading "Questions"
    And I fill in "Text field title text" with "This is the title text for the questions"
    And I select the radio button "Answer is 1" with the id "edit-likert-field-type-a"
    And I select the radio button "Answer is 3" with the id "edit-likert-field-type-b--3"
    And I select the radio button "Answer is 6" with the id "edit-likert-field-type-c--6"
    And I select the radio button "No" with the id "edit-radio-field-type-no"
    And I select the radio button "Other (explain)" with the id "edit-radios-field-other-radios-other-"
    And I type "This is an option 'Other' with text field" in css selector "#edit-radios-field-other-other"
    And I fill in "Text field in a group" with "This is a text field in a group"
    And I press "Preview"
    And I wait for ajax to finish
  Then I should see the text "Please take a minute to review what you've written"
  When I press "Submit"
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd"
    # Edit others webform submission
  When I am logged in as a user with the "webform, <role2>" role
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/webform/results/submissions"
    And I click "Edit" in the "Tester Dude" row
    And I fill in "Commenter's Name (Individual or Organization)" with "Tester Person"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Zappers & Beyond"
    And I scroll to the bottom
    And I press "Preview"
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "Tester Person"
    And I should see the text "Bug Zappers & Beyond"
  When I press "Save"
    And I wait for ajax to finish
  Then I should see the text "Submission updated in Proposed Ruling XYZ Comment Form 1."
    # Cleanup: Delete webform content type and template
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/structure/webform/manage/template_based_proposed_ruling_x/delete"
    And I check the box "Yes, I want to delete the "
    And I press "Delete"
  Then I should see the text "The webform Template-based Proposed Ruling XYZ Comment Form 1 has been deleted."
  When I am on "/admin/content/search"
    And I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
    And I click "edit-delete"
  Then I should see the text "Are you sure you want to delete the content item Proposed Ruling XYZ Comment Form 1?"
  When I press "Delete"
  Then I should see the text "The Comment Form Proposed Ruling XYZ Comment Form 1 has been deleted."

  Examples:
    | role1            | role2            |
    | content_approver | sitebuilder      |
    | sitebuilder      | content_approver |

@api @javascript
Scenario: End User Can Submit a Published Template-Based Rule Making Comments Webform
  Given "customized_comment_form" content:
    | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
    | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    And I am logged in as a user with the "webform, sitebuilder" role
  When I am on "/admin/structure/webform/manage/custom_comments_form/duplicate"
  Then I should see the text "Duplicate 'Custom Comments Form' form"
  When I press the "Edit" button
    And I click the "span.admin-link" element
    And I fill in "Machine-readable name" with "template_based_proposed_ruling_xyz_comment_form_1"
    And I fill in "Title" with "Template-based Proposed Ruling XYZ Comment Form 1"
    And I press "Save"
  Then I should see the text "Webform Template-based Proposed Ruling XYZ Comment Form 1 created."
  When I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1/edit"
    And I select the first autocomplete option for "Template-based Proposed Ruling XYZ Comment Form 1" on the "Custom Webform Attachment" field
    And I publish it
  Then I should see the text "Comment Form Proposed Ruling XYZ Comment Form 1 has been updated."
  When I am not logged in
    And I am on "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1"
    # Steps here for commenter's info section (same as node-based form)
  Then I should see the text "Submit Comments on ab-12-cd"
    And I should see the text "Display Title for Proposed Ruling XYZ Comment Form 1"
    And I fill in "Commenter's Name (Individual or Organization)" with "Tester Dude"
    And I fill in "Commenter's Professional Affiliation (if any)" with "Bug Busters & Beyond"
    And I fill in "Address" with "100 Easy Road"
    And I fill in "City/Town" with "Easyville"
    And I select "Virginia" from "State/Province"
    And I fill in "ZIP/Postal Code" with "20002"
    And I select "United States" from "Country"
    And I fill in "Email Address" with "testerdude@email.com"
    And I fill in "Phone Number" with "999-123-1234"
    And I check the box "I am submitting on behalf of a third party"
    And I fill in "Submitter's Representative" with "Dr Strange"
    And I fill in "Organization's Name" with "Avengers Defenders Illuminati Infinity Watch"
    And I fill in "Affiliation Name" with "Clea Wong Ancient One"
    And I fill in "Comments:" with "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I attach the file "behat-corpfin2-wts-wf1.doc" to "files[upload_comments][]"
    And I wait for ajax to finish
   # Steps here for custom questions section
    And I should see the heading "Questions"
    And I fill in "Text field title text" with "This is the title text for the questions"
    And I select the radio button "Answer is 1" with the id "edit-likert-field-type-a"
    And I select the radio button "Answer is 3" with the id "edit-likert-field-type-b--3"
    And I select the radio button "Answer is 6" with the id "edit-likert-field-type-c--6"
    And I select the radio button "No" with the id "edit-radio-field-type-no"
    And I select the radio button "Other (explain)" with the id "edit-radios-field-other-radios-other-"
    And I type "This is an option 'Other' with text field" in css selector "#edit-radios-field-other-other"
    And I fill in "Text field in a group" with "This is a text field in a group"
    And I press "Preview"
    And I wait for ajax to finish
  # Confirmation page steps here
  Then I should see the text "Please take a minute to review what you've written"
    And I should see the text "We post all comments on our website, so please make sure that the text beneath the word comments below does not include:"
    And I should see the text "account numbers"
    And I should see the text "social security numbers, or"
    And I should see the text "other personal identifying information"
    And I should see the text "Questions"
    And I should see the text "This is the title text for the questions"
    And I should see the text "1st First Question?: Answer is 1"
    And I should see the text "2nd Second Question?: Answer is 3"
    And I should see the text "3th Third Question?: Answer is 6"
    And I should see the text "No"
    And I should see the text "This is an option 'Other' with text field"
    And I should see the text "This is a text field in a group"
    And I should see the text "Bug Busters & Beyond"
    And I should see the text "100 Easy Road"
    And I should see the text "Easyville"
    And I should see the text "Virginia"
    And I should see the text "20002"
    And I should see the text "United States"
    And I should see the text "testerdude@email.com"
    And I should see the text "999-123-1234"
    And I should see the text "Dr Strange"
    And I should see the text "Avengers Defenders Illuminati Infinity Watch"
    And I should see the text "Clea Wong Ancient One"
    And I should see the text "These are some comments I would like to add for this particular ruling so that the rulers can make informed decision"
  When I press "Submit"
  Then I should see the text "Thank you for submitting a comment to the U.S. Securities and Exchange Commission to file ab-12-cd"
    # Cleanup: Delete webform content type and template
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/structure/webform/manage/template_based_proposed_ruling_x/delete"
    And I check the box "Yes, I want to delete the "
    And I press "Delete"
  Then I should see the text "The webform Template-based Proposed Ruling XYZ Comment Form 1 has been deleted."
  When I am on "/admin/content/search"
    And I click "Edit" in the "Proposed Ruling XYZ Comment Form 1" row
    And I click "edit-delete"
  Then I should see the text "Are you sure you want to delete the content item Proposed Ruling XYZ Comment Form 1?"
  When I press "Delete"
  Then I should see the text "The Comment Form Proposed Ruling XYZ Comment Form 1 has been deleted."

@api
Scenario Outline: Rule Making Comments Webform Mandatory Fields Validations
  Given I am logged in as a user with the "webform, content_creator" role
  When I am on "/forms/ruling-comments-form"
  Then I should see the heading "Ruling Comments Form"
  When I fill in "Commenter's Name (Individual or Organization)" with "<Name>"
    And I fill in "Email Address" with "<Email>"
    And I fill in "Phone Number" with "<Telephone>"
    And I fill in "Comments" with "<Comments>"
    And I press "Continue"
  Then I should not see the text "Please take a minute to review what you've written"

  Examples:
    | Name | Email                 | Telephone  | Comments     |
    |      | drupalsupport@sec.gov | 2025550000 | Some comment |
    | Joe  |                       | 2025550000 | Some comment |
    | Joe  | drupalsupport@sec.gov |            | Some comment |
    | Joe  | drupalsupport@sec.gov | 2025550000 |              |
