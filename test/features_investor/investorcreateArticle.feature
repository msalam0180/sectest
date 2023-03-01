Feature: Create Investor Article
  As a Content Creator, I want to be able to create articles so that visitors to investor.gov can learn about the investor

@api @javascript @investor
Scenario: Investor Create Article
  Given I am logged in as a user with the "Content Creator" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I fill in "Alternate Name" with "Behat Test"
    And I press the "Save" button
  Then I should see the text "Article Investor Behat Test Article has been created"

@api @javascript @investor
Scenario: Investor Create Article Embed Links
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary "
    And I type "Investor Behat Display Title http://www.finra.org/" in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Article Investor Behat Test Article has been created"
    And I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test Article"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Investor Behat Test Article" in the maincontent region
    And I should see the text "Investor Behat Display Title http://www.finra.org/"

@api @javascript @investor
Scenario: Investor Create Article Embed Video
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/media/add/video"
    And I fill in "Name" with "Best Video"
    And I select "Upload" from "Video Origin"
    And attach the file "behat-sample.mp4" to "Video file"
    And I wait 2 seconds
    And I wait for ajax to finish
    And I press the "Save" button
    And I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article video"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Investor Behat Display Title http://www.finra.org" in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press "Embed Entity" in the "Body" WYSIWYG Toolbar
    And I wait 2 seconds
    And I select the first autocomplete option for "Best Video" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I click "Embed" on the modal "Embed media item"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
    And I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test Article video"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Investor Behat Test Article video" in the maincontent region

@api @javascript @investor
Scenario: Investor Edit and Delete Article
  Given "article" content:
    | title                           | body                                               | status | moderation_state |
    | Investor Behat E&D Test Article | Investor Behat Display Title http://www.finra.org/ | 1      | published        |
    And I am logged in as a user with the "Content Approver" role
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat E&D Test Article" row
    And I fill in "Title" with "Investor Behat Edit and Delete Test Article"
    And I type "Editing Behat Display Title http://www.SEC.gov/" in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Edit and Delete Test Article"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Investor Behat Edit and Delete Test Article" in the maincontent region
    And I click "Investor Behat Edit and Delete Test Article" in the maincontent region
    And I should see the text "Editing Behat Display Title http://www.SEC.gov/"
    And I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Edit and Delete Test Article" row
    And I click "edit-delete"
    And I wait 2 seconds
    And I press "edit-submit"
  Then I should see the text "The Article Investor Behat Edit and Delete Test Article has been deleted."

@api @javascript @investor
Scenario: Investor Create Article Embed Images
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/media/add/image"
    And I fill in "Name" with "Gold pig"
    And attach the file "behat-gold-pig.png" to "Image"
    And I wait 5 seconds
    And I fill in "Alternative text" with "goldy"
    And I wait for ajax to finish
    And I press the "Save" button
    And I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article Image"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Investor Behat Display Title http://www.pig.org" in the "Body" WYSIWYG editor
    And I wait 3 seconds
    And I press "Embed" in the "Body" WYSIWYG Toolbar
    And I select the first autocomplete option for "Gold pig" on the "Name" field on a modal
    And I wait 1 seconds
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I click "Embed" on the modal "Embed media item"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
    And I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test Article Image"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Investor Behat Test Article Image" in the maincontent region
    And I click "Investor Behat Test Article Image" in the maincontent region
  Then I should see the text "INVESTOR BEHAT TEST ARTICLE IMAGE"
    And I should see the text "Investor Behat Display Title http://www.pig.org"

@api @javascript @investor
Scenario Outline: Create Media Files and Embed to an Article
  Given I am logged in as a user with the "content_approver" role
  When I am on "/media/add/file"
    And I fill in "Name" with "<Name>"
    And I attach the file "<File Upload>" to "File Upload"
    And I wait for ajax to finish
    And I wait 5 seconds
    And I press the "edit-submit" button
    And I wait 5 seconds
    And I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article Media File"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Investor Behat PDF Title" in the "Body" WYSIWYG editor
    And I press "Embed" in the "Body" WYSIWYG Toolbar
    And I select the first autocomplete option for "<Name>" on the "Name" field on a modal
    And I wait 1 seconds
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I click "Embed" on the modal "Embed media item"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Article Investor Behat Test Article Media File has been created."
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test Article Media File"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Investor Behat Test Article Media File" in the maincontent region

  Examples:
    | Name        | File Upload     |
    | DOC Format  | behat-file.doc  |
    | DOCX Format | behat-file.docx |
    | PDF Format  | behat-file.pdf  |
    | PPT Format  | behat-file.ppt  |
    | PPTX Format | behat-file.pptx |
    | TXT Format  | behat-file.txt  |
    | XLS Format  | behat-file.xls  |
    | XLSX Format | behat-file.xlsx |
    | VCS Format  | behat-file.vcs  |
    | XML Format  | behat-file.xml  |
    | ICS Format  | behat-file.ics  |
    | ZIP Format  | behat-file.zip  |
    | CSV Format  | behat-file.csv  |

@api @javascript @investor
Scenario: Update Embeded File on Article
  Given I am logged in as a user with the "content_approver" role
  When I am on "/media/add/file"
    And I fill in "Name" with "Embeded File"
    And I attach the file "behat-file.doc" to "File Upload"
    And I wait for ajax to finish
    And I wait 5 seconds
    And I press the "edit-submit" button
    And I wait 5 seconds
    And I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test File"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test File Article"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Investor Behat File Title" in the "Body" WYSIWYG editor
    And I press "Embed" in the "Body" WYSIWYG Toolbar
    And I select the first autocomplete option for "Embeded File" on the "Name" field on a modal
    And I wait 1 seconds
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I click "Embed" on the modal "Embed media item"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Article Investor Behat Test File has been created."
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test File"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
    And I should see the link "Investor Behat Test File" in the maincontent region
    And I click "Investor Behat Test File" in the maincontent region
    And I should see the link "embeded-file.doc"
    And I am on "/admin/content/media"
    And I click "Edit" in the "Embeded File" row
    And I press the "Remove" button
    And I wait 2 seconds
    And I attach the file "behat-file.pdf" to "File Upload"
    And I wait for ajax to finish
    And I wait 5 seconds
    And I press the "edit-submit" button
    And I wait 5 seconds
  Then I should see the text "has been updated."
    And I run cron
  When I am on "/user/logout"
    And I fill in "Search Investor.gov" with "Investor Behat Test File"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Investor Behat Test File" in the maincontent region
  When I click "Investor Behat Test File" in the maincontent region
    And I should see the link "embeded-file.pdf" in the maincontent region

@api @javascript @investor
Scenario: Link File On Article
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "file":
      | name                | field_media_file | mid     |
      | BEHAT PDF File Test | behat-file.pdf   | 8272100 |
    And I run cron
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article PDF File"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Click Here for Link to Media File >> " in the "Body" WYSIWYG editor
    And I scroll "#edit-body-wrapper" into view
    And I press "Link (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait 1 seconds
    And I fill in "URL" with "/media/8272100"
    And I wait 2 seconds
    And I click on the element with css selector "button.button"
    And I wait 2 seconds
    And I scroll to the bottom
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Article Investor Behat Test Article PDF File has been created."
    And I should see the text "Click Here for Link to Media File >>"
    And I should see the link "/media/8272100"
    And the hyperlink "/media/8272100" should match the Drupal url "/media/8272100"

 @api @javascript @investor
  Scenario: Verify Texts are Showing Bold When Using Strong Tag for Article
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "Testing ticket 13871"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Article"
      And I press "Bold" in the "Body" WYSIWYG Toolbar
      And I type "Testing body" in the "Body" WYSIWYG editor
      And I select "Published" from "edit-moderation-state-0-state"
      And I wait 1 seconds
      And I press the "edit-submit" button
    Then I should see the text "Testing ticket 13871"
      And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div.layout.layout--threecol-25-50-25 > div.layout__region.layout__region--second > div.block.block-layout-builder.block-field-blocknodearticlebody.block-title- > div > p > strong" element
