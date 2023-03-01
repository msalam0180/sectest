Feature: News Content Type
  As a content creator
  I want to be able to create News Type content
  So that visitors to SEC.gov can view news about the SEC

@api @javascript
Scenario Outline: Create Different News Types With File Upload
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "static_file":
      | name                     | field_display_title | field_media_file    | field_description_abstract | field_link_text_override | status |
      | Behat live static file 1 | published media     | behat-file_data.pdf | This is description abs    | Behat 1                  | 1      |
  When I visit "/node/add/news"
    And I select "<news_type>" from "News Type"
    And I fill in "Behat News Test" for "Title"
    And I select the first autocomplete option for "OCRNews" on the "Tags" field
    And I fill in "<display_title>" for "Display Title"
    And I fill in "Behat description" for "Description/Abstract"
    And I select the first autocomplete option for "Adam T. Moore" on the "Speaker" field
    And I select the first autocomplete option for "Behat live static file 1" on the "Use existing media" field
    And I select "Credit Ratings" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "<news_type>"
    And I should see the heading "<display_title>"
    And I should see "Behat Live Static File 1"
  When I click "pdf"
    And I switch to the new window
  Then should be on "/files/behat-file_data.pdf"
    And I close the current window
  When I am not logged in
    And I visit "/news/speeches-statements"
  Then I should see the link "<click_link>"
  When I click "<click_link>"
  Then should be on "/files/behat-file_data.pdf"
    And I close the current window
  When I am logged in as a user with the "Content Approver" role
    And I visit "<edit>"
    And I scroll "#edit-body-wrapper" into view
    And I type "Detail body" in the "Body" WYSIWYG editor
    And I publish it
    And I am not logged in
    And I visit "/news/speeches-statements"
  Then I should see the link "<display_title>"
  When I click "<display_title>"
    And I click "pdf"
    And I switch to the new window
  Then should be on "/files/behat-file_data.pdf"
    And I close the current window

    Examples:
      | news_type | display_title                 | click_link                          | edit                                 |
      | Speech    | Behat display Speech title    | Behat display Speech title (PDF)    | /news/speech/behat-news-test/edit    |
      | Statement | Behat display Statement title | Behat display Statement title (PDF) | /news/statement/behat-news-test/edit |
      | Testimony | Behat display Testimony title | Behat display Testimony title (PDF) | /news/testimony/behat-news-test/edit |

@api @javascript
Scenario: Create Press Release News Content Type With File Upload
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "static_file":
      | name                     | field_display_title | field_media_file    | field_description_abstract | field_link_text_override | status |
      | Behat live static file 1 | published media     | behat-file_data.pdf | This is description abs    | Behat 1                  | 1      |
  When I visit "/node/add/news"
    And I select "Press Release" from "News Type"
    And I fill in "Behat News Test" for "Title"
    And I select the first autocomplete option for "OCRNews" on the "Tags" field
    And I fill in "Behat News Display Title" for "Display Title"
    And I fill in "Behat description" for "Description/Abstract"
    And I fill in "34-1345" for "Release Number"
    And I select the first autocomplete option for "Behat live static file 1" on the "Use existing media" field
    And I select "Credit Ratings" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "Press Release"
    And I should see the heading "Behat News Display Title"
    And I should see "Behat Live Static File 1"
  When I click "pdf"
    And I switch to the new window
  Then should be on "/files/behat-file_data.pdf"
    And I close the current window
  When I am not logged in
    And I visit "/ocr/ocr-news-list-page-"
  Then I should see the link "Behat News Display Title (PDF)" in the "OCR_press_release" region
  When I click "Behat News Display Title (PDF)"
  Then should be on "/files/behat-file_data.pdf"
    And I close the current window
  When I am logged in as a user with the "Content Approver" role
    And I visit "/news/press-release/behat-news-test/edit"
    And I scroll "#edit-body-wrapper" into view
    And I type "Detail body" in the "Body" WYSIWYG editor
    And I publish it
    And I am not logged in
    And I visit "/ocr/ocr-news-list-page-"
  Then I should see the link "Behat News Display Title" in the "OCR_press_release" region
  When I click "Behat News Display Title"
    And I click "pdf"
    And I switch to the new window
  Then should be on "/files/behat-file_data.pdf"
