Feature: Create and View Media
As a Content Creator to the SEC.gov Drupal
I want to be able to add static files, images and videos
So that users can get information available in static files, images, and videos on SEC.gov

Background:

  Given "division_office" terms:
    | name       |
    | division 1 |
    | office 1   |
    And "file_path" terms:
      | name    | parent  |
      | Path A1 |         |
      | Path A2 | Path A1 |
      | Path A3 | Path A2 |
      | Path A4 | Path A3 |
      | Path N2 |         |
      | Path M3 |         |
      | Path P4 |         |

@api @javascript
Scenario Outline: Create and Delete Common Static Files Media
  Given I am logged in as a user with the "content_creator" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "<Title>"
    And I fill in "Display Title" with "<Display_Title>"
    And I fill in "Description/Abstract" with "This is <Title>"
    And I attach the file "<File_Type>" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I should not see an "#edit-status-value" element
    And I should see the text 'This media file is accessible to the public via the full path even if left "unpublished." You must delete the file to ensure it is inaccessible.'
    And I press "Save"
  Then I should see the text "has been created." in the status_message region
  When I click "<Title>" in the status_message region
  Then I should see the heading "<Display_Title>"
    And I should see the link "<File_Type>"
    And I should be on "/file/<URL_alias>"
  When I am logged in as a user with the "content_approver" role
    And I am on "/file/<URL_alias>/delete"
    And I press "Delete"
  Then I should see the text "The media item <Title> has been deleted."

  Examples:
    | Title             | Display_Title     | File_Type       | URL_alias         |
    | NTest CSV Format  | dtest csv format  | behat-file.csv  | ntest-csv-format  |
    | NTest DOC Format  | dtest doc format  | behat-file.doc  | ntest-doc-format  |
    | NTest DOCX Format | dtest docx format | behat-file.docx | ntest-docx-format |
    | NTest PDF Format  | dtest pdf format  | behat-file.pdf  | ntest-pdf-format  |
    | NTest PPT Format  | dtest ppt format  | behat-file.ppt  | ntest-ppt-format  |
    | NTest PPTX Format | dtest pptx format | behat-file.pptx | ntest-pptx-format |
    | NTest TXT Format  | dtest txt format  | behat-file.txt  | ntest-txt-format  |
    | NTest XLS Format  | dtest xls format  | behat-file.xls  | ntest-xls-format  |
    | NTest XLSX Format | dtest xlsx format | behat-file.xlsx | ntest-xlsx-format |
    | NTest XML Format  | dtest xml format  | behat-file.xml  | ntest-xml-format  |
    | NTest ICS Format  | dtest ics format  | behat-file.ics  | ntest-ics-format  |
    | NTest ZIP Format  | dtest zip format  | behat-file.zip  | ntest-zip-format  |

@api @javascript
Scenario Outline: Upload Unsupported File Type For Static File Media
  Given I am logged in as a user with the "content_creator" role
  When I am on "/media/add/static_file"
    And I attach the file "<file>" to "File Upload"
    And I wait for ajax to finish
  Then I should see the text "cannot be uploaded. Only files with the following extensions are allowed: asx, avi, css, csv, doc, docx, h, htm, html, idx, iff, js, json, map, midi, mov, mp3, mp4, mpg, pdf, ppt, pptx, rss, rtf, sdp, shtml, smi, txt, wav, wma, wmv, xfd, xls, xlsx, xml, xsd, xsl, xslt, zip, ics."

  Examples:
    | file               |
    | behat-cat.png      |
    | behat-doberman.jpg |
    | behat-bird.gif     |

@api
Scenario: PDF Static File Media Link Opens Inline
  Given I am logged in as a user with the "content_approver" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Behat File Open"
    And I fill in "Display Title" with "open pdf"
    And I fill in "Description/Abstract" with "This is the description and abstract"
    And I attach the file "behat-form.pdf" to "File Upload"
    And I select "office 1" from "Primary Division/Office"
    And I press "Save"
    And I fill in "Media name" with "Behat File Open"
    And I press "Filter"
    And I click "Behat File Open"
    And I click "behat-form.pdf"
  Then I should be on "/files/behat-form.pdf"
    And I am on "/file/behat-file-open/delete"
    And I press "Delete"

@api
Scenario: Verify Static File Type
  Given I am logged in as a user with the "content_approver" role
    And "static_file_type" terms:
      | name       |
      | Taxonomy 1 |
      | Taxonomy 2 |
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Behat File Media Type"
    And I fill in "Display Title" with "Static File Type"
    And I attach the file "behat-form.pdf" to "File Upload"
    And I select "Taxonomy 1" from "Static File Type"
    And I select "office 1" from "Primary Division/Office"
    And I press "Save"
  Then I visit "file/behat-file-media-type"
    And I should see the text "Static File Type"

@api @javascript
Scenario Outline: View Media Type Filter On Media Search Page
  Given I am logged in as a user with the "<role>" role
  When I am on "/admin/content/media"
    And I click on the element with css selector "#edit-type"
  Then I should see "Static File"
    And I should see "Image"
    And I should see "Video"
    But I should not see "Audio"

  Examples:
    | role                  |
    | administrator         |
    | sitebuilder           |
    | content_approver      |
    | content_creator       |
    | bad_actors            |
    | division_office_admin |

@api @javascript
Scenario: Media Search And Status/Type Filtering
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_description_abstract | status |
    | Behat live static file  | published media     | This is description abs    | 1      |
    | Behat draft static file | unpublished media   | This is description abs    | 0      |
    And I create "media" of type "video_media":
      | name            | field_display_title | field_remote_video_url                      | field_media_transcript | status |
      | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | cat transcript         | 1      |
      | BEHAT Dog Video | Dog on Vimeo        | https://vimeo.com/343314163                 | dog transcript         | 0      |
    And I create "media" of type "image_media":
      | name          | field_media_caption | status |
      | Gold Pig Tail | Pig Caption         | 1      |
      | Puppy Tail    | Puppy Caption       | 0      |
    And I am logged in as a user with the "content_approver" role
  When I am on "/admin/content/media"
    And I fill in "Media name" with "behat"
    And I press "Filter"
  Then I should see the link "Behat live static file"
    And I should see the link "Behat draft static file"
    And I should see the link "BEHAT Cat Video"
    And I should see the link "BEHAT Dog Video"
    And I should not see the link "Gold Pig Tail"
  When I am on "/admin/content/media"
    And I select "Unpublished" from "Published status"
    And I press the "Filter" button
  Then I should see the text "Unpublished" in the "Behat draft static file" row
    And I should see the text "Unpublished" in the "BEHAT Dog Video" row
    And I should see the text "Unpublished" in the "Puppy Tail" row
    And I should not see the link "Behat live static file"
  When I select "Published" from "Published status"
    And I press the "Filter" button
  Then I should see the text "Published" in the "Behat live static file" row
    And I should see the text "Published" in the "BEHAT Cat Video" row
    And I should see the text "Published" in the "Gold Pig Tail" row
    And I should not see the link "BEHAT Dog Video"
  When I select "-View All-" from "Published status"
    And I press the "Filter" button
  Then I should see the link "Behat live static file"
    And I should see the link "Behat draft static file"
    And I should see the link "BEHAT Cat Video"
    And I should see the link "BEHAT Dog Video"
    And I should see the link "Gold Pig Tail"
    And I should see the link "Puppy Tail"
  When I select "Static File" from "Type"
    And I press the "Filter" button
  Then I should see the link "Behat live static file"
    And I should see the link "Behat draft static file"
    And I should not see the link "BEHAT Cat Video"
    And I should not see the link "BEHAT Dog Video"
    And I should not see the link "Gold Pig Tail"
    And I should not see the link "Puppy Tail"
  When I select "Image" from "Type"
    And I press the "Filter" button
  Then I should see the link "Gold Pig Tail"
    And I should see the link "Puppy Tail"
    And I should not see the link "Behat live static file"
    And I should not see the link "Behat draft static file"
    And I should not see the link "BEHAT Cat Video"
    And I should not see the link "BEHAT Dog Video"
  When I select "Video" from "Type"
    And I press the "Filter" button
  Then I should see the link "BEHAT Cat Video"
    And I should see the link "BEHAT Dog Video"
    And I should not see the link "Gold Pig Tail"
    And I should not see the link "Puppy Tail"
    And I should not see the link "Behat live static file"
    And I should not see the link "Behat draft static file"
  When I select "-View All-" from "Type"
    And I press the "Filter" button
  Then I should see the link "Behat live static file"
    And I should see the link "Behat draft static file"
    And I should see the link "BEHAT Cat Video"
    And I should see the link "BEHAT Dog Video"
    And I should see the link "Gold Pig Tail"
    And I should see the link "Puppy Tail"

@api @javascript
Scenario: Create Static File Media With / In Title
  Given I am logged in as a user with the "bad_actors" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Behat Protection w/ Prohibited Personnel Practices"
    And I fill in "Display Title" with "display / title media"
    And I fill in "Description/Abstract" with "This is a slash to dash conversion test"
    And I attach the file "behat-file.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And I press "Save"
    And I am on "/admin/content/media"
    And I fill in "behat" for "Media name"
    And I press "Filter"
  Then I should see the link "Behat Protection w/ Prohibited Personnel Practices"
    And I am on "/file/behat-protection-w-prohibited-personnel-practices/delete"
    And I press "Delete"

@api @javascript
Scenario: File Path Update When Updating Static File Media With A Different File
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Update Media Path"
    And I fill in "Display Title" with "display title media"
    And I fill in "Description/Abstract" with "url alias switch test"
    And I attach the file "behat-file.txt" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And the "edit-status-value" checkbox should not be checked
    And I check the box "edit-status-value"
    And I press "Save"
    And I click "Update Media Path" in the status_message region
  Then I should be on "/file/update-media-path"
  When I click "behat-file.txt"
  Then I should be on "/files/behat-file.txt"
  When I am on "/file/update-media-path/edit"
    And I uncheck the box "edit-keep-original-filename"
    And I attach the file "behat-file-updated.txt" to "File"
    And I wait for ajax to finish
    And I scroll to the bottom
  Then I should see the text "URL alias"
  When I press "Save"
    And I click "Update Media Path" in the status_message region
  Then I should be on "/file/update-media-path"
  When I click "behat-file-updated.txt"
  Then I should be on "/files/behat-file-updated.txt"
    And I am on "/file/update-media-path/delete"
    And I press "Delete"

@api @javascript
Scenario: File Path Update When Updating Static File Media With Same File Name
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Update Same Media Static File"
    And I fill in "Display Title" with "display title update media"
    And I fill in "Description/Abstract" with "url alias same file update test"
    And I attach the file "Behat-file_pdf_mons.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And the "edit-status-value" checkbox should not be checked
    And I check the box "edit-status-value"
    And I press "Save"
    And I click "Update Same Media Static File" in the status_message region
  Then I should be on "/file/update-same-media-static-file"
  When I click "behat-file_pdf_mons.pdf"
  Then I should be on "/files/behat-file_pdf_mons.pdf"
  When I am on "/file/update-same-media-static-file/edit"
    And I check the box "edit-keep-original-filename"
    And I attach the file "Behat-file_pdf_mons.pdf" to "File"
    And I wait for ajax to finish
    And I scroll to the bottom
  Then I should see the text "URL alias"
  When I press "Save"
    And I click "Update Same Media Static File" in the status_message region
  Then I should be on "/file/update-same-media-static-file"
  When I click "behat-file_pdf_mons.pdf"
  Then I should be on "/files/behat-file_pdf_mons.pdf"
    And I am on "/file/update-same-media-static-file/delete"
    And I press "Delete"

@api @javascript
Scenario: Static File Media Title Update And Redirect
  Given I am logged in as a user with the "division_office_admin" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Original Media Title"
    And I fill in "Display Title" with "display title media"
    And I fill in "Description/Abstract" with "url alias update test"
    And I attach the file "behat-file.doc" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And the "edit-status-value" checkbox should not be checked
    And I check the box "edit-status-value"
    And I press "Save"
    And I click "Original Media Title" in the status_message region
  Then I should be on "/file/original-media-title"
  When I am on "/file/original-media-title/edit"
    And I fill in "Title" with "Updated Media Title"
    And I fill in "Display Title" with "display title media updated"
    And I scroll to the bottom
  Then I should see the text "URL alias"
  When I press "Save"
    And I click "Updated Media Title" in the status_message region
  Then I should be on "/file/updated-media-title"
  When I visit "/file/original-media-title"
  Then I should be on "/file/updated-media-title"
    And I should see the heading "display title media updated"
    And I should see the link "behat-file.doc"
  When I am on "/file/updated-media-title/delete"
    And I press "Delete"

@api @javascript
Scenario: Embed Static File Media Using Linkit
  Given I create "media" of type "static_file":
    | name           | field_display_title  | field_media_file | field_description_abstract | status | mid      |
    | My Linkit Test | published media file | behat-file.pdf   | This is description abs    | 1      | 98765432 |
    And I am logged in as a user with the "content_creator" role
  When I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Linkit Test"
    And I fill in "Display Title" with "media linkit test"
    And I scroll "#edit-body-wrapper" into view
    And I type "Click to get to internal link: " in the "Body" WYSIWYG editor
    And I wait 1 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I should see the modal "Add Link"
    And I fill in "/media/98765432" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I press "Link (Ctrl+L)" in the "Body" WYSIWYG Toolbar
    And I fill in "Display Text" with "Click Here"
    And I click "OK"
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "media linkit test"
    And I should see the link "Click Here"
    And the hyperlink "Click Here" should match the Drupal url "/media/98765432"
  When I click "Click Here"
  Then I should be on "/file/my-linkit-test"
    And I should see the link "behat-file.pdf"
    And I click "behat-file.pdf"
    And I should be on "/files/behat-file.pdf"

@api @javascript
Scenario: Embed Unpublished Static File Media Using Linkit
  Given I create "media" of type "static_file":
    | name           | field_display_title    | field_media_file | field_description_abstract | status | mid      |
    | My Linkit Test | unpublished media file | behat-file.pdf   | This is description abs    | 0      | 98765430 |
    And I am logged in as a user with the "content_creator" role
  When I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Linkit Test"
    And I fill in "Display Title" with "unpublished media linkit test"
    And I scroll "#edit-body-wrapper" into view
    And I type "Click to get to internal link: " in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I should see the modal "Add Link"
    And I fill in "/media/98765430" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I wait 2 seconds
    And I press "Save and Create New Draft"
  Then I should see the heading "unpublished media linkit test"
    And I should see the link "/media/98765430"
  When I click "/media/98765430"
  Then I should see the heading "unpublished media file"
  When I am not logged in
    And I visit "/file/my-linkit-test"
  Then I should see the text "You are receiving this error message because your browser is not authorized to access this file."

@api @javascript
Scenario: Manage File Path List Terms And Specify File Path
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/admin/structure/taxonomy/manage/file_path/overview"
    And I click "Edit" in the "Path M3" row
    And I click on the element with css selector "#edit-relations > summary"
    And I select "Path A1" from "Parent terms"
    And I press "Save"
    And I click "Edit" in the "Path N2" row
    And I click on the element with css selector "#edit-relations > summary"
    And I select "-Path M3" from "Parent terms"
    And I press "Save"
    And I click "Edit" in the "Path P4" row
    And I click on the element with css selector "#edit-relations > summary"
    And I select "--Path N2" from "Parent terms"
    And I press "Save"
    And I am logged in as a user with the "content_approver" role
    And I am on "/media/add/static_file"
    And I fill in "Title" with "File Path Test"
    And I fill in "Display Title" with "display title specified file path"
    And I fill in "Description/Abstract" with "to file path"
    And I attach the file "behat-file.pdf" to "File Upload"
    And I wait for ajax to finish
    And I click on the element with css selector "#edit-field-file-path"
  Then I should see "Files (root)"
    And I should see "Path A1"
    And I should see "-Path M3"
    And I should see "--Path N2"
    And I should see "---Path P4"
  When I select "---Path P4" from "File Path"
    And I select "division 1" from "Primary Division/Office"
    And I press "Save"
    And I click "File Path Test" in the status_message region
  Then I should be on "/file/file-path-test"
  When I click "behat-file.pdf"
  Then I should be on "/files/path-a1/path-m3/path-n2/path-p4/behat-file.pdf"
    And I am on "/file/file-path-test/delete"
    And I press "Delete"

@api @javascript
Scenario Outline: Create Image Media
  Given I am logged in as a user with the "division_office_admin" role
  When I am on "/media/add/image_media"
    And I fill in "Title" with "<Title>"
    And I attach the file "<File_name>" to "Image Upload"
    And I wait for ajax to finish
    And I fill in "Alternative text" with "image alt text"
    And I fill in "Caption" with "<Caption>"
    And I click "URL alias"
    And I fill in "URL alias" with "<URL_alias>"
    And I press "Save"
  Then I should see the text "has been created."
  When I click "<Title>" in the status_message region
  Then I should see the heading "<Title>"
    And I should see the "img" element with the "src" attribute set to "<Link>" in the "contentarea" region
    And I should see the "img" element with the "alt" attribute set to "image alt text" in the "contentarea" region
  When I am on "<URL_alias>/delete"
    And I press "Delete"
  Then I see the text "The media item <Title> has been deleted."

  Examples:
    | Title       | File_name         | Caption            | URL_alias    | Link                            |
    | Dogs Image  | behat-dogs.jpeg   | This is a dog jpeg | /media/dog1  | /files/images/behat-dogs.jpeg   |
    | Birds Image | behat-birds.gif   | This is a bird gif | /media/bird1 | /files/images/behat-birds.gif   |
    | Cats Image  | behat-kittens.png | This is a cat png  | /media/cat1  | /files/images/behat-kittens.png |

@api @javascript
Scenario Outline: Create Video Media With Custom URL Alias
  Given I am logged in as a user with the "division_office_admin" role
  When I am on "/media/add/video_media"
    And I fill in "Title" with "<Title>"
    And I fill in "Display Title" with "<Display_Title>"
    And I fill in "Remote Video URL" with "<Remote_Video_URL>"
    And I wait for ajax to finish
    And I type "<Body>" in the "Body" WYSIWYG editor
    And I click "URL alias"
    And I uncheck the box "edit-path-0-pathauto"
    And I fill in "URL alias" with "<URL_alias>"
    And I press "Save"
  Then I should see the text "has been created."
  When I click "<Title>" in the status_message region
    And I wait 2 seconds
  Then I should see the heading "<Display_Title>"
    And I should see the "iframe" element with the "src" attribute set to "<Video>" in the "contentarea" region
  When I am on "<URL_alias>/delete"
    And I press "Delete"
  Then I see the text "The media item <Title> has been deleted."

  Examples:
    | Title         | Display_Title | Remote_Video_URL             | Body        | URL_alias  | Video                                                              |
    | YouTube Video | YouTube Now   | https://youtu.be/J8G4yglCcT4 | YT attached | /media/yt1 | https://www.youtube.com/embed/J8G4yglCcT4?autoplay=0&start=0&rel=0 |
    | Vimeo Video   | Vimeo Now     | https://vimeo.com/343314163  | VM attached | /media/vm1 | https://player.vimeo.com/video/343314163?autoplay=0                |

@api @javascript
Scenario: Video and Image Thumbnail For Media Search
  Given I create "media" of type "video_media":
    | name            | field_display_title | field_remote_video_url                      | field_media_transcript | status |
    | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | cat transcript         | 1      |
    | BEHAT Dog Video | Dog on Vimeo        | https://vimeo.com/343314163                 | dog transcript         | 0      |
    And I create "media" of type "image_media":
      | name              | field_media_image      | field_media_caption | status |
      | Gold Pig Tail     | behat-gold-pig.png     | Pig Caption         | 1      |
      | Black Rabbit Tail | behat-black_rabbit.jpg | Rabbit Caption      | 0      |
    And I am logged in as a user with the "content_approver" role
  When I am on "/admin/content/media"
    And I select "Image" from "Type"
    And I press the "Filter" button
  Then I should see the link "Gold Pig Tail"
    And I should see the link "Black Rabbit Tail"
    And I should see the "img" element with the "class" attribute set to "image-style-thumbnail" in the "medialist" region
  When I select "Video" from "Type"
    And I press the "Filter" button
  Then I should see the link "BEHAT Cat Video"
    And I should see the link "BEHAT Dog Video"
    And I should see the "img" element with the "class" attribute set to "image-style-thumbnail" in the "medialist" region

@api @javascript
Scenario: Image file path
  Given I create "media" of type "image_media":
    | name              | field_media_image      | field_media_caption | status | mid    |
    | Gold Pig Tail     | behat-gold-pig.png     | Pig Caption         | 1      | 90210  |
     And I am logged in as a user with the "division_office_admin" role
  When I am on "/media/90210"
  Then I should see the heading "Gold Pig Tail"
    And I should see the "img" element with the "src" attribute set to "/files/images/behat-gold-pig.png" in the "contentarea" region
  When I am on "/media/90210/delete"
    And I press "Delete"
  Then I see the text "The media item Gold Pig Tail has been deleted."

@api @javascript
Scenario: File Path Filter
  Given I create "media" of type "static_file":
    | name                      | field_display_title | field_media_file  | field_description_abstract | status |
    | Behat live static file 1  | published media     | behat-file.pdf   | This is description abs    | 1      |
    | Behat live static file 2  | published media     | behat-file.pdf   | This is description abs    | 1      |
    | Behat live static file 3  | published media     | behat-file.pdf   | This is description abs    | 1      |
    And I am logged in as a user with the "division_office_admin" role
    #the next steps manually assign File Path to static files as we cannot figure out a direct way to assign them using behat at this time
  When I am on "/file/behat-live-static-file-1/edit"
    And I select "division 1" from "Primary Division/Office"
    And I select "Path A1" from "File Path"
    And I press "Save"
    And I am on "/file/behat-live-static-file-2/edit"
    And I select "division 1" from "Primary Division/Office"
    And I select "Path A2" from "File Path"
    And I press "Save"
    And I am on "/file/behat-live-static-file-3/edit"
    And I select "division 1" from "Primary Division/Office"
    And I select "Path A3" from "File Path"
    And I press "Save"
    #go to media list and filter by File Path
    And I am on "/admin/content/media"
    And I additionally select "Path A1" from "File Path"
    And I additionally select "Path A3" from "File Path"
    And I press the "Filter" button
  Then I should see the link "Behat live static file 1"
    And I should see the link "Behat live static file 3"
    And I should not see the link "Behat live static file 2"

@api @javascript
Scenario Outline: File Replacement For Static File Media
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_media_file | field_description_abstract | status |
    | Behat Cats Static File  | published media     | behat-file.pdf   | This is description abs    | 1      |
    And I am logged in as a user with the "content_approver" role
  When I am on "/file/behat-cats-static-file/edit"
    And I should see the text "REPLACE FILE"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I select "division 1" from "Primary Division/Office"
    And I press "Save"
    And I click "Behat Cats Static File" in the status_message region
  Then I should be on "/file/behat-cats-static-file"
    And I should see the link "<filename_displayed_as>"
  When I click "<filename_displayed_as>"
  Then the url should match "<filepath>"

  Examples:
    | checkbox_action  | filename            | filename_displayed_as | filepath                   |
    | check            | behat-file-cat.pdf  | behat-file.pdf        | /files/behat-file.pdf      |
    | uncheck          | behat-file-lynx.pdf | behat-file-lynx.pdf   | /files/behat-file-lynx.pdf |

@api @javascript
Scenario Outline: File Replacement For Image Media
  Given I create "media" of type "image_media":
    | name               | field_media_image | field_media_caption | status | mid    |
    | Behat Animal Image | behat-monkey.jpg  | This is an animal   | 1      | 902100 |
    And I am logged in as a user with the "content_approver" role
  When I am on "/media/902100/edit"
    And I should see the text "REPLACE FILE"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I fill in "Alternative text" with "image alt text"
    And I select "division 1" from "Primary Division/Office"
    And I press "Save"
  When I am on "/media/902100/edit"
  Then I should see the link "<filename_displayed_as>"
    And the link "<filename_displayed_as>" should match the Drupal url "<filepath>"

  Examples:
    | checkbox_action  | filename            | filename_displayed_as  | filepath                         |
    | check            | behat-puppy.jpg     | behat-monkey.jpg       | /files/images/behat-monkey.jpg   |
    | uncheck          | behat-doberman.jpg  | behat-doberman.jpg     | /files/images/behat-doberman.jpg |

@api @javascript
Scenario Outline: Upload Unsupported File Type For Static File Media File Replacement
  Given I create "media" of type "static_file":
    | name                  | field_display_title  | field_media_file | field_description_abstract | status | mid      |
    | My Replace Media Test | published media file | behat-file.txt   | This is description abs    | 1      | 98765432 |
  When I am logged in as a user with the "content_creator" role
    And I am on "/media/98765432/edit"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I check the box "edit-keep-original-filename"
    And I select "division 1" from "Primary Division/Office"
    And I press "Save"
  Then I should see the text "Unable to upload replacement file."
    And I should see the text "Only files with the following extensions are allowed: txt."

    Examples:
      | checkbox_action | filename        |
      | check           | behat-puppy.jpg |
      | uncheck         | behat-bird.gif  |

@api @javascript
Scenario: Specify URL Alias For Static File
  Given I am logged in as a user with the "bad_actors" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Static File URL"
    And I fill in "Display Title" with "url alias test"
    And I attach the file "behat-file-final_order.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I click "URL alias"
    And I uncheck the box "edit-path-0-pathauto"
    And I fill in "URL alias" with "/file/behat/myurl"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the text "has been created."
  When I click "Static File URL" in the status_message region
  Then I should see the heading "url alias test"
    And the url should match "/file/behat/myurl"
  When I am on "/file/behat/myurl/delete"
    And I press "Delete"
  Then I see the text "The media item Static File URL has been deleted."

@api @javascript
Scenario: Update URL Alias For Static File
  Given I create "media" of type "static_file":
    | name                   | field_display_title | field_media_file  | field_description_abstract | status |
    | Update Static File URL | published media     | behat-form1.pdf   | This is description abs    | 1      |
    And I am logged in as a user with the "bad_actors" role
  When I visit "/file/update-static-file-url"
  Then I should see the heading "published media"
    And I should see the link "behat-form1.pdf"
  When I am on "/file/update-static-file-url/edit"
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I click "URL alias"
    And I uncheck the box "edit-path-0-pathauto"
    And I fill in "URL alias" with "/file/behat/run"
    And I press "Save"
  Then I should see the text "Static File Update Static File URL has been updated."
  When I click "Update Static File URL" in the status_message region
  Then I should see the heading "published media"
    And I should see the link "behat-form1.pdf"
    And the url should match "/file/behat/run"

@api @javascript
Scenario: Unpublish Static File Media Does Not Delete Static File
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_media_file   | field_description_abstract | status |
    | Behat Cats Static File  | published media     | behat-file-cat.pdf | This is description abs    | 1      |
    And I am logged in as a user with the "content_approver" role
  When I am on "/file/behat-cats-static-file/edit"
    And I select "division 1" from "Primary Division/Office"
    And I scroll to the bottom
    And I uncheck the box "edit-status-value"
    And I press "Save"
  Then I should see the text "Static File Behat Cats Static File has been updated."
    And I should see the text "Unpublished" in the "Behat Cats Static File" row
  When I click "Behat Cats Static File" in the status_message region
  Then I should be on "/file/behat-cats-static-file"
    And I should see the link "behat-file-cat.pdf"
  When I click "behat-file-cat.pdf"
  Then the url should match "/files/behat-file-cat.pdf"
  When I visit "/admin/content/files"
  Then I should see the link "behat-file-cat.pdf"
    And I should see the text "Permanent" in the "behat-file-cat.pdf" row

@api @javascript
Scenario: Unpublish Image Media Does Not Delete Image File
  Given I create "media" of type "image_media":
    | name              | field_media_image  | field_media_caption | status | mid    |
    | Behat Puppy Image | behat-puppy.jpg    | This is a puppy     | 1      | 902100 |
    And I am logged in as a user with the "content_approver" role
  When I am on "/media/902100/edit"
    And I fill in "Alternative text" with "image alt text"
    And I scroll to the bottom
    And I uncheck the box "edit-status-value"
    And I press "Save"
  Then I should see the text "Image Behat Puppy Image has been updated."
    And I should see the text "Unpublished" in the "Behat Puppy Image" row
  When I click "Behat Puppy Image" in the status_message region
  Then I should be on "/media/902100"
    And I should see the "img" element with the "src" attribute set to "/files/images/behat-puppy.jpg" in the "contentarea" region
    And I should see the "img" element with the "alt" attribute set to "image alt text" in the "contentarea" region
  When I visit "/admin/content/files"
  Then I should see the link "behat-puppy.jpg"
    And I should see the text "Permanent" in the "behat-puppy.jpg" row

@api @javascript
Scenario: Static File Upload With Special Characters
  Given I am logged in as a user with the "content_approver" role
  When I am on "/media/add/static_file"
    And I fill in "Title" with "Behat Static File Spchar"
    And I fill in "Display Title" with "spchar pdf"
    And I fill in "Description/Abstract" with "This is the description and abstract"
    And I attach the file "behat-file@work$ & 100% and p!ay#(2).pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "office 1" from "Primary Division/Office"
    And I check the box "edit-status-value"
    And I press "Save"
    And I click "Behat Static File Spchar" in the status_message region
  Then I should see the link "behat-filework-100-and-pay2.pdf"
  When I click "behat-filework-100-and-pay2.pdf"
  Then I should be on "/files/behat-filework-100-and-pay2.pdf"

@api @javascript
Scenario: Image Media File Upload With Special Characters
  Given I am logged in as a user with the "division_office_admin" role
  When I am on "/media/add/image_media"
    And I fill in "Title" with "Behat Image Spchar"
    And I attach the file "behat-doberman@work$ & 99% and p!ay#(3).jpg" to "Image Upload"
    And I wait for ajax to finish
    And I fill in "Alternative text" with "image alt text"
    And I fill in "Caption" with "dog spchar test"
    And I press "Save"
    And I click "Edit" in the "Behat Image Spchar" row
  Then I should see the link "behat-dobermanwork-99-and-pay3.jpg"
    And the hyperlink "behat-dobermanwork-99-and-pay3.jpg" should match the Drupal url "/files/images/behat-dobermanwork-99-and-pay3.jpg"

@api @javascript
Scenario: Create, Edit, Filter, and Delete Link Media
  Given I am logged in as a user with the "content_creator" role
    And I create "media" of type "static_file":
      | name                     | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
      | Behat live static file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
  When I am on "/media/add/link"
    And I fill in "Name" with "Behat Link 2022"
    And I fill in "field_media_entity_link[0][uri]" with "https://sec.lndo.site/litigation/suspensions"
    And I fill in "field_media_entity_link[0][title]" with "Trading Suspension"
    And I click "URL alias"
    And I fill in "path[0][alias]" with "/media/behatmedialink"
    And I press "Save"
  Then I should see the text "has been created." in the status_message region
  When I click "Behat Link 2022" in the status_message region
  Then I should be on "/media/behatmedialink"
    And I should see the heading "Behat Link 2022"
    And I should see the link "Trading Suspension"
  When I am on "/admin/content/media"
    And I select "Link" from "Type"
    And I press the "Filter" button
  Then I should see the link "Behat Link 2022" in the "media_content_table" region
    And I should not see the link "Behat live static file 1" in the "media_content_table" region
  When  I am on "/media/behatmedialink/edit"
    And I fill in "field_media_entity_link[0][title]" with "Edited Trading Suspension"
    And I press "Save"
    And I should see the text "has been updated." in the status_message region
  Then I am on "/media/behatmedialink"
    And I should see the heading "Behat Link 2022"
    And I should see the link "Edited Trading Suspension"
  When I am logged in as a user with the "content_approver" role
    And I am on "/media/behatmedialink/delete"
    And I press "Delete"
  Then I should see the text "The media item Behat Link 2022 has been deleted."
  When I am on "/media/behatmedialink"
  Then I should see the heading "Oops! Page Not Found."
