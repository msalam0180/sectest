Feature: Use WYSIWYG Editor
  As a content creator
  I need to be able to use a WYSIWYG editor
  So I can format the content of my pages

  Background:
    Given "division_office" terms:
        | name                |
        | DERA                |
        | Corpfin             |

@api @javascript
Scenario Outline: Basic Formatting in WYSIWYG
  Given I am logged in as a user with the "content_creator" role
  When I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing WYSIWYG"
    And I fill in "Display Title" with "BEHAT Testing WYSIWYG"
    And I press "<Action>" in the "Body" WYSIWYG Toolbar
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I select "Corpfin" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see "Testing body" in the "<Element>" element

  Examples:
    | Action        | Element |
    | Bold          | strong  |
    | Underline     | u       |
    | Italic        | p > em  |
    | Strikethrough | s       |

@api @javascript
Scenario: Add Link in WYSIWYG
  Given I am logged in as a user with the "content_creator" role
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing WYSIWYG"
    And I fill in "Display Title" with "BEHAT Testing WYSIWYG"
    And I scroll "#edit-body-wrapper" into view
    And I type "To get to internet search: " in the "Body" WYSIWYG editor
    And I press "Link (Ctrl+L)" in the "Body" WYSIWYG Toolbar
    And I fill in "Display Text" with "Click Here"
    And I select "https://" from "Protocol"
    And I fill in "cke_327_textInput" with "www.investor.gov"
    And I click "OK"
    And I select "Corpfin" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the link "Click Here"
    And the hyperlink "Click Here" should match the Drupal url "https://www.investor.gov"
  When I click "Click Here"
  Then I should see the text "Introduction to Investing"

@api @javascript
Scenario: Add Node via LinkIt in WYSIWYG
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title    | status | body                    | field_display_title   | field_publish_date  | field_release_number | field_speaker_name_and_title    | nid     |
    | Testimony            | DERA                          | First TM | 1      | This is the first body. | First Behat Testimony | 2018-09-11 12:00:00 | 2018-09              | Commissioner Michael S. Piwowar | 5222019 |
    And I am logged in as a user with the "content_creator" role
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing WYSIWYG"
    And I fill in "Display Title" with "BEHAT Testing WYSIWYG"
    And I scroll "#edit-body-wrapper" into view
    And I type "Click to get to internal link: " in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I should see the modal "Add Link"
    And I fill in "/node/5222019" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I select "Corpfin" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "BEHAT Testing WYSIWYG"
    And I should see the link "/node/5222019"
    And the hyperlink "/node/5222019" should match the Drupal url "/node/5222019"
  When I click "/node/5222019"
  Then I should see the heading "First Behat Testimony"

@api @javascript
Scenario: Embed Image File in WYSIWYG
  Given I am logged in as a user with the "content_creator" role
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Image Embed"
    And I fill in "Display Title" with "BEHAT Testing Image Embed"
    And I scroll "#edit-body-wrapper" into view
    And I press "Image" in the "Body" WYSIWYG Toolbar
    And I attach the file "behat-monkey.jpg" to "Image"
    And I wait for ajax to finish
    And I fill in "Alternative text" with "picture of a monkey"
    And I click "Save" on the modal "Insert Image"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
    And I wait 2 seconds
  Then I should see the "img" element with the "alt" attribute set to "picture of a monkey" in the "contentarea" region

@api @javascript
Scenario: Embed Static File Media in WYSIWYG
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_media_file    | field_description_abstract | status |
    | Behat Cats Static File  | published media     | behat-file-lynx.pdf | This is description abs    | 1      |
  When I am logged in as a user with the "content_approver" role
    And I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Static File Media Embed"
    And I fill in "Display Title" with "BEHAT Testing SF Media Embed"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Cats Static File" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Embed" from "Display as"
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "BEHAT Testing SF Media Embed"
    And I should see the link "behat-file-lynx.pdf"
    And I should see the text "Embed level caption"

@api @javascript
Scenario: Embed Image Media in WYSIWYG
  Given I create "media" of type "image_media":
    | name              | field_media_image      | field_media_caption | status |
    | Black Rabbit Tail | behat-black_rabbit.jpg | rabbit caption      | 1      |
    And I am logged in as a user with the "content_creator" role
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Image Embed"
    And I fill in "Display Title" with "BEHAT DT Testing Image Embed"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Black Rabbit Tail" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Thumbnail" from "Display as"
    And I wait for ajax to finish
    And I fill in "Alternate text" with "picture of a black rabbit"
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "BEHAT DT Testing Image Embed"
    And I should see the "img" element with the "alt" attribute set to "picture of a black rabbit" in the "contentarea" region
    And I should see the text "Embed level caption"
    # Caption from embed should override the caption that comes with image media and should also not show both captions
    And I should not see the text "rabbit caption"

@api @javascript
Scenario: Embed Video Media in WYSIWYG
  Given I create "media" of type "video_media":
    | name            | field_display_title | field_remote_video_url                      | field_media_transcript | status |
    | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | cat transcript         | 1      |
    And I am logged in as a user with the "content_creator" role
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Video Media Embed"
    And I fill in "Display Title" with "BEHAT DT Testing Video Media Embed"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "BEHAT Cat Video" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Full content" from "Display as"
    And I wait for ajax to finish
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
    And I wait 2 seconds
  Then I should see the heading "BEHAT DT Testing Video Media Embed"
    And I should see the "iframe" element with the "src" attribute set to "https://www.youtube.com/embed/QIobikJiTuU?autoplay=0&start=0&rel=0" in the "contentarea" region
    And I should see the text "Embed level caption"

@api @javascript
Scenario: Embed Static File Media In WYSIWYG With Title Only Display Type
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_media_file    | field_description_abstract | status |
    | Behat Cats Static File  | published media     | behat-file-lynx.pdf | This is description abs    | 1      |
  When I am logged in as a user with the "content_approver" role
    And I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Static File Media Embed with Title Only"
    And I fill in "Display Title" with "BEHAT Testing SF Media Embed with Title Only"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Cats Static File" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Title Only" from "Display as"
    And I wait for ajax to finish
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "BEHAT Testing SF Media Embed with Title Only"
    And I should see the link "published media"
    And I should see the "span" element with the "data-entity-embed-display" attribute set to "view_mode:media.title_only" in the "articlecontent" region
    And I should see the text "Embed level caption"

@api @javascript
Scenario: Embed Static File Media In WYSIWYG With Title & Date Display Type
  Given I create "media" of type "static_file":
    | name                    | field_display_title | field_media_file    | field_description_abstract | status |
    | Behat Cats Static File  | published media     | behat-file-lynx.pdf | This is description abs    | 1      |
  When I am logged in as a user with the "content_approver" role
    And I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Static File Media Embed with Title & Date"
    And I fill in "Display Title" with "BEHAT Testing SF Media Embed with Title & Date"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Cats Static File" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Title and Date" from "Display as"
    And I wait for ajax to finish
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "DERA" from "Primary Division/Office"
    And I scroll to the bottom
    And I press "Save and Create New Draft"
  Then I should see the heading "BEHAT Testing SF Media Embed with Title & Date"
    And I should see the link "published media"
    And I should see an "span.file_embed_date" element
    And I should see the "span" element with the "data-entity-embed-display" attribute set to "view_mode:media.title_and_date" in the "articlecontent" region
    And I should see the text "Embed level caption"
