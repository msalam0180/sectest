Feature: Create Static Files
  As an Admin or user with Individual Defendant role
  I want to be able to create Static Files
  So that related documents for IDD records can be uploaded to SEC.gov

  Background:
    Given "division_office" terms:
      | name              |
      | behat             |
      | office of justice |

@api @javascript
Scenario: Users with Individual Defendant role can create static file
  Given I am logged in as a user with the "bad_actors" role
  When I visit "/media/add/static_file"
    And I fill in the following:
      | Title         | Static test file 1    |
      | Display Title | This is Display Title |
    And I attach the file "behat-file-im.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "Chief Operating Officer" from "Primary Division/Office"
    And I press "Save"
  Then I should see the text "Static test file 1 has been created." in the status_message region
  When I click "Static test file 1" in the status_message region
  Then I should see the text "This is Display Title"
    And I should see the link "behat-file-im.pdf"
  # Clean up steps
  When I visit "/admin/content/media"
    And I click "Edit" in the "Static test file 1" row
    And I click "Delete"
    And I press "Delete"
  Then I should see the text "The media item Static test file 1 has been deleted."

@api @javascript
Scenario: Individual Defendant role can edit static file
  Given I am logged in as a user with the "bad_actors" role
    And I create "media" of type "static_file":
      | name            | field_display_title | field_description_abstract | status |
      | Behat Test File | aaaTest static file | This is description abs    | 1      |
  When I visit "/admin/content/media"
    And I click "Edit" in the "Behat Test File" row
    And I fill in the following:
      | Title         | aaa Static test file 1    |
      | Display Title | aaa This is Display Title |
    And I attach the file "behat-file-im.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "Credit Ratings" from "Primary Division/Office"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the text "Static File aaa Static test file 1 has been updated." in the status_message region
  When I click "aaa Static test file 1" in the status_message region
  Then I should see the text "aaa This is Display Title"
    And I should see the link "behat-file-im.pdf"

@api
Scenario Outline: Users Can Delete Static File Media
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_description_abstract | status |
      | BEHAT Test File | aaaTest static file | This is description abs    | 1      |
    And I am logged in as a user with the "<role>" role
  When I visit "/admin/content/media"
    And I click "Edit" in the "BEHAT Test File" row
    And I click "edit-delete"
    And I press the "Delete" button
  Then I should not see the link "BEHAT Test File" in the "medialist" region

    Examples:
    | role                  |
    | Administrator         |
    | Sitebuilder           |
    | Content Approver      |
    | Individual Defendants |
    | Division/Office Admin |
    | Content Creator       |

@api @javascript
Scenario Outline: Test the ability to download the .doc and .docx files
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/media/add/static_file"
    And I fill in "Title" with "<title>"
    And I fill in "Display Title" with "This is Display Title"
    And I attach the file "<file_upload>" to "File Upload"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the text "<title> has been created." in the status_message region
  When I click "<title>" in the status_message region
  Then I should see the text "This is Display Title"
    And I should see the link "<file_upload>"
  When I click "<file_upload>"
  Then I should not see "Temporarily Unavailable"
  When I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "OSSS3984"
    And I fill in "Display Title" with "Display Title 3984"
    And I select the first autocomplete option for "<title>" on the "Use existing media" field
    And I wait for ajax to finish
    And I select "behat" from "Primary Division/Office"
    And I publish it
    And I click "<file_upload>"
  Then I should not see "Temporarily Unavailable"

    Examples:
      | title         | file_upload        |
      | Static file 1 | behat-file-dl.doc  |
      | Static file 2 | behat-file-dl.docx |

@api @javascript
Scenario: Content Creator Can Create And Delete Media Static File
  Given I am logged in as a user with the "Content Creator" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "BEHAT Static File"
    And I fill in "Display Title" with "behat display title"
    And I attach the file "behat-file.ics" to "File Upload"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I scroll to the bottom
    And I should not see an "#edit-status-value" element
    And I press "Save"
  Then I should see the text "BEHAT Static File has been created." in the status_message region
    And I should see the text "Unpublished" in the "BEHAT Static File" row
  When I click "BEHAT Static File" in the status_message region
  Then I should see the text "behat display title"
    And I should see the "a" element with the "href" attribute set to "/behat-file" in the "contentarea" region
  When I am on "/admin/content/media"
    And I click on the element with css selector "#edit-media-bulk-form-0"
    And I wait for AJAX to finish
    And I select "Delete media" from "Action"
    And I press "Apply to selected items"
    And I press "Delete"
  Then I should see the text "Deleted 1 item."

@api @javascript
Scenario Outline: Content Approver And Admin Can Publish Static File
  Given I am logged in as a user with the "<role>" role
  When I am on "/media/add/static_file"
    And I fill in the following:
      | Title         | BEHAT Static File   |
      | Display Title | behat display title |
    And I attach the file "<file>" to "File Upload"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I scroll to the bottom
  Then I should see an "#edit-status-value" element
    And I should see the text "Published"
    And I check the box "edit-status-value"
  When I press "Save"
  Then I should see the text "BEHAT Static File has been created." in the status_message region
    And I should see the text "Published" in the "BEHAT Static File" row
  When I click "BEHAT Static File" in the status_message region
  Then I should see the text "behat display title"
    And I should see the "a" element with the "href" attribute set to "/behat-file" in the "contentarea" region

    Examples:
    | role             | file              |
    | Content Approver | behat-file-im.txt |
    | Administrator    | behat-file.csv    |

@api @javascript
Scenario Outline: Edit Static File
  Given I create "media" of type "static_file":
    | name              | field_display_title | field_description_abstract | status |
    | BEHAT Static File | Create static file  | This is description abs    | 1      |
    And I am logged in as a user with the "<role>" role
  When I am on "/admin/content/media"
    And I click "Edit" in the "BEHAT Static File" row
    And I fill in the following:
      | Title         | Updated Static Test File |
      | Display Title | updated display title    |
    And I attach the file "<file>" to "File Upload"
    And I wait for ajax to finish
    And I select "behat" from "Primary Division/Office"
    And I press "Save"
  Then I should see the text "Static File Updated Static Test File has been updated." in the status_message region
  When I click "Updated Static Test File" in the status_message region
  Then I should see the text "updated display title"
    And I should see the "a" element with the "href" attribute set to "<link>" in the "contentarea" region

    Examples:
      | role             | file              | link           |
      | Content Approver | behat-file-im.pdf | /behat-file-im |
      | Content Creator  | behat-file.ics    | /behat-file    |

@api @javascript
Scenario: Static File Content Creation As Admin
  Given I am logged in as a user with the "administrator" role
  When I visit "/node/add/file"
    And I fill in the following:
      | Title         | BEHAT Static File               |
      | Display Title | behat static file display title |
    And I attach the file "behat-file-im.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I publish it
  Then I should see the text "behat static file display title"
    And I should see the link "behat-file-im.pdf"

@api @javascript
Scenario Outline: Authorized Users Can Delete Static File Media
  Given I create "media" of type "static_file":
    | name                   | field_display_title | field_media_file  | field_description_abstract | status |
    | Behat live static file | published media     | behat-file-im.txt | This is description abs    | 1      |
  When I visit "/files/behat-file-im.txt"
  Then I should see the text "this is a txt file"
  When I am logged in as a user with the "<role>" role
    And I am on "/file/behat-live-static-file/delete"
    And I press "Delete"
  Then I see the text "The media item Behat live static file has been deleted."
  When I am on "/admin/content/files"
  Then I should not see the link "behat-file-im.txt"
  # External users should not be able to view the deleted file
  When I am not logged in
    And I visit "/files/behat-file-im.txt"
  Then I should not see the text "this is a txt file"
    And I should see the heading "Not Found"

    Examples:
      | role                  |
      | content_creator       |
      | content_approver      |
      | Individual Defendants |
      | division_office_admin |
      | sitebuilder           |
      | administrator         |

@api @javascript
Scenario: Deleted Static File Media Should Not Be Accessible From LinkIt Referenced
  Given I create "media" of type "static_file":
    | name                        | field_display_title  | field_media_file  | field_description_abstract | status | mid      |
    | My Delete Media Linkit Test | published media file | behat-file-im.txt | This is description abs    | 1      | 98765432 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Deletion Linkit Test"
    And I fill in "Display Title" with "media deletion linkit test"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I fill in "/media/98765432" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I press "Link (Ctrl+L)" in the "Body" WYSIWYG Toolbar
    And I fill in "Display Text" with "Click Here"
    And I click "OK"
    And I select "behat" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "media deletion linkit test"
  When I click "Click Here"
    And I click "behat-file-im.txt"
  Then I should see the text "this is a txt file"
  When I visit "/file/my-delete-media-linkit-test/delete"
    And I press "Delete"
  Then I see the text "The media item My Delete Media Linkit Test has been deleted."
  # External users should not be able to view the deleted file
  When I am not logged in
    And I visit "/behat-media-deletion-linkit-test"
    And I click "Click Here"
  Then I should see the text "Page not found"
  When I visit "/files/behat-file-im.txt"
  Then I should see the heading "Not Found"
    And I should not see the text "this is a txt file"

@api @javascript
Scenario Outline: Replaced Static File Media Should Be Updated Immediately
  Given I create "media" of type "static_file":
    | name                      | field_display_title | field_media_file  | field_description_abstract | status |
    | Behat Replace Static File | published media     | behat-file-im.txt | This is description abs    | 1      |
  When I am on "/files/behat-file-im.txt"
  Then I should see the text "this is a txt file"
  When I am logged in as a user with the "content_approver" role
    And I am on "/file/behat-replace-static-file/edit"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I select "behat" from "Primary Division/Office"
    And I press "Save"
    And I am not logged in
    And I visit "/file/behat-replace-static-file"
  Then I should see the heading "published media"
    And I should see the link "<filename_displayed_as>"
  When I click "<filename_displayed_as>"
  Then I should see the text "this is an updated version of the txt file"
  When I am on "/files/behat-file-im.txt"
  Then I should see the text "<expected_text>"

  Examples:
    | checkbox_action | filename               | filename_displayed_as  | expected_text                              |
    | check           | behat-file-updated.txt | behat-file-im.txt      | this is an updated version of the txt file |
    | uncheck         | behat-file-updated.txt | behat-file-updated.txt | Not Found                                  |

@api @javascript
Scenario Outline: Replaced Static File Media Should Be Updated From LinkIt Referenced
  Given I create "media" of type "static_file":
    | name                         | field_display_title  | field_media_file  | field_description_abstract | status | mid      |
    | My Replace Media Linkit Test | published media file | behat-file-im.txt | This is description abs    | 1      | 98765432 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Replace Linkit Test"
    And I fill in "Display Title" with "media replace linkit test"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I fill in "/media/98765432" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I press "Link (Ctrl+L)" in the "Body" WYSIWYG Toolbar
    And I fill in "Display Text" with "Click Here"
    And I click "OK"
    And I select "behat" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "media replace linkit test"
  When I click "Click Here"
    And I click "behat-file-im.txt"
  Then I should see the text "this is a txt file"
  When I am on "/media/98765432/edit"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I select "office of justice" from "Primary Division/Office"
    And I press "Save"
  # External users should not be able to view the deleted file
  When I am not logged in
    And I visit "/behat-media-replace-linkit-test"
    And I click "Click Here"
  Then I should see the heading "published media file"
    And I click "<filename_displayed_as>"
  Then I should see the text "this is an updated version of the txt file"
  When I am on "/files/behat-file-im.txt"
  Then I should see the text "<expected_text>"

  Examples:
    | checkbox_action | filename               | filename_displayed_as  | expected_text                              |
    | check           | behat-file-updated.txt | behat-file-im.txt      | this is an updated version of the txt file |
    | uncheck         | behat-file-updated.txt | behat-file-updated.txt | Not Found                                  |
