Feature: Related Content On Investor
  As a Site Visitor, the CC/CA should be able to create related content blocks so users can see more information related to the page

Background:
  Given I create "media" of type "file":
    | name                | field_media_file | mid     |
    | BEHAT PDF File Test | behat-file.pdf   | 8272101 |
    And I create "media" of type "image":
      | name             | field_media_image  | mid     |
      | BEHAT Image Test | behat-gold-pig.png | 8272102 |
    And I create "media" of type "video":
      | name               | field_video_origin | field_video                                 | mid     | field_caption  | field_transcript | field_media_video_file |
      | BEHAT Rabbit Video | upload             |                                             | 8272105 | Rabbit caption |                  | behat-sample.mp4       |
      | BEHAT Bird Image   | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312  | Bird caption   | Transcript       |                        |
      | BEHAT Rabbit Image | upload             |                                             | 221313  | Rabbit caption |                  | behat-sample.mp4       |
      | BEHAT Cat Image    | youtubevimeo       | https://www.youtube.com/watch?v=QIobikJiTuU | 312123  |                |                  |                        |
      | BEHAT Dog Image    | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313  | Dog caption    |                  |                        |

@api @javascript @investor
Scenario: Create Article With Related Content Block
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat related content Article"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I fill in "Alternate Name" with "Related content Behat Test"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name1" in the "new_link" region
    And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/8272101" in the "new_link" region
    And I fill in "Link text" with "related name2" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-rabbit-video" in the "new_link" region
    And I fill in "Link text" with "related name3" in the "new_link" region
    And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
    And I wait 1 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Article Investor Behat related content Article has been created"
    And I wait 2 seconds
    And I click "related name1"
    And I should see the text "BEHAT Image Test"
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat related content Article"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Investor Behat related content Article" in the maincontent region
    And I click "Investor Behat related content Article" in the maincontent region
    And I wait 1 seconds
    And I click "related name3"
    And I should see the text "BEHAT Rabbit Video"
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat related content Article"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Investor Behat related content Article" in the maincontent region
    And I wait 1 seconds
    And I click "Investor Behat related content Article" in the maincontent region
    And I wait 1 seconds
    And I click "related name2"
    And the hyperlink "related name2" should match the Drupal url "/files/behat-pdf-file-test"

@api @javascript @investor
Scenario: Create Page And Delete Related Content Block
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/page"
    And I fill in "Title" with "Investor Behat related content Page"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I fill in "Alternate Name" with "Related content Behat Test Page"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/8272101" in the "new_link" region
    And I fill in "Link text" with "related name1" in the "new_link" region
    And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name2" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I wait 1 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
    And I wait 2 seconds
  Then I should see the text "Page Investor Behat related content Page has been created"
  When I am on "/admin/content"
    And I wait 1 seconds
    And I click "Edit" in the "Investor Behat related content Page" row
    And I wait 1 seconds
    #And I click on the element with css selector "#edit-field-related-content-0-top-links-edit-button"
    And I press "List additional actions"
    And I press "Remove"
    And I wait for ajax to finish
    And I press "Confirm removal"
    And I wait for ajax to finish
    And I press the "edit-submit" button
  Then I should see the text "Basic page Investor Behat related content Page has been updated."
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat related content Page"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Investor Behat related content Page" in the maincontent region
    And I wait 1 seconds
    And I click "Investor Behat related content Page" in the maincontent region
    And I wait 1 seconds
    And I should not see the text "related name1"
    And I should not see the text "BEHAT Related content Message one"

@api @javascript @investor
Scenario: Create Glossary And Edit Related Content Block
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/glossary_term"
    And I fill in "Title" with "Behat Test Glossary page"
    And I fill in "Glossary Category" with "#'s (5)"
    And I fill in "Alternate Name" with "Behat Test"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name1"
    And I type "BEHAT Related content glossary one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-video-test" in the "new_link" region
    And I fill in "Link text" with "related name2" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content glossary Two" in the "Description" WYSIWYG editor number "1"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Glossary Term Behat Test Glossary page has been created."
  When I am on "/"
    And I fill in "Search Investor.gov" with "Behat Test Glossary page"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Behat Test Glossary page" in the maincontent region
  When I wait 1 seconds
    And I click "Behat Test Glossary page" in the maincontent region
  Then I should see the text "related name1"
    And I should see the text "BEHAT Related content glossary one"
    And I should see the text "related name2"
    And I should see the text "BEHAT Related content glossary Two"
    And I am on "/admin/content"
    And I wait 1 seconds
    And I click "Edit" in the "Behat Test Glossary page" row
    And I wait 2 seconds
    And I click on the element with css selector "#edit-field-related-content-0-top-links-edit-button"
    And I wait for ajax to finish
    And I type "Edited : " in the "Description" WYSIWYG editor number "0"
    And I press "edit-submit"
    And I wait 1 seconds
  When I am on "/"
    And I fill in "Search Investor.gov" with "Behat Test Glossary page"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Behat Test Glossary page" in the maincontent region
  When I wait 1 seconds
    And I click "Behat Test Glossary page" in the maincontent region
  Then I should see the text "related name1"
    And I should see the text "Edited : BEHAT Related content glossary one"
    And I should see the text "related name2"
    And I should see the text "BEHAT Related content glossary Two"

@api @javascript @investor
Scenario: Create News And Validate Related Content Block
  Given "article" content:
    | title              | body                 | status | moderation_state |
    | Pizza Test Article | Free Free Free Pizza | 1      | published        |
    And "page" content:
      | title            | body           | status | nid | moderation_state |
      | Behat Basic Page | Free ice cream | 1      | 1   | published        |
  When I am logged in as a user with the "Content Approver" role
    And I am on "/node/add/news"
    And I fill in "Title" with "Behat RC News"
    And I wait 1 seconds
    And I type "Investor Behat News" in the "Body" WYSIWYG editor
    And I wait 1 seconds
    And I press the "Edit summary" button
    And I wait 1 seconds
    And I fill in "Summary" with "Investor Behat News Summary"
    And I wait 1 seconds
    And I select "Investor Alerts" from "News Type"
    And I fill in "Alternate Name" with "RC News"
    And I fill in "Related Content Label" with "RC Latest News"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/pizza-test-article" in the "new_link" region
    And I wait 2 seconds
    And I fill in "Link text" with "Free Pizza"
    And I type "BEHAT Related content news one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/node/1" in the "new_link" region
    And I fill in "Link text" with "Happy Hour starts at 6pm" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content news Two" in the "Description" WYSIWYG editor number "1"
    And I click on the element with css selector "#edit-field-show-featured-content-value"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
    And I wait 1 seconds
  Then I should see the text "News Behat RC News has been created."
    And I should see the text "Investor Behat News"
    And I should see the heading "RC Latest News"
    And I should see the link "Free Pizza"
    And I should see the link "Happy Hour starts at 6pm"
  When I click "Free Pizza"
  Then I should see the text "Free Free Free Pizza"
  When I move backward one page
    And I click "Happy Hour starts at 6pm" in the maincontent region
  Then I should see the text "Free ice cream"

@api @javascript @investor
Scenario: Create a RC Gallery
  Given "gallery" content:
    | title         | body           | field_media                       | moderation_state |
    | BEHAT Gallery | This is a test | BEHAT Bird Image, BEHAT Dog Image | published        |
    And I am logged in as a user with the "content_approver" role
  When I visit "/behat-gallery"
    And I wait 1 seconds
  Then I should see "BEHAT Bird Image"
    And I should see "BEHAT Dog Image"
  When I am on "/admin/content"
    And I click "Edit" in the "BEHAT Gallery" row
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-video-test" in the "new_link" region
    And I fill in "Link text" with "related name3" in the "new_link" region
    And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "0"
    And I wait 1 seconds
    And I press "edit-submit"
  Then I should see the text "Gallery BEHAT Gallery has been updated."
  When I am on "/"
    And I fill in "Search Investor.gov" with "BEHAT Gallery"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "BEHAT Gallery" in the maincontent region
  When I click "BEHAT Gallery" in the maincontent region
    And I wait 1 seconds
  Then I should see "BEHAT Bird Image"
    And I should see "BEHAT Dog Image"
    And I scroll to the bottom
    And I should see the text "Related Name3"
    And I should see the text "BEHAT Related content Message Three"

@api @javascript @investor
Scenario: No Related Content Is Displayed When User Does Not Add Any Related Content
  When I am logged in as a user with the "Content Approver" role
    And I am on "/node/add/news"
    And I fill in "Title" with "Behat News with no RC"
    And I type "Investor Behat News" in the "Body" WYSIWYG editor
    And I wait 1 seconds
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat News Summary"
    And I wait 1 seconds
    And I select "Investor Alerts" from "News Type"
    And I fill in "Alternate Name" with "RC News"
    And I fill in "Related Content" with ""
    And I wait 1 seconds
    And I click on the element with css selector "#edit-field-show-featured-content-value"
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press "edit-submit"
    And I wait 2 seconds
  Then I should see the text "News Behat News with no RC has been created."
    And I should not see "Related content"

@api @javascript @investor
Scenario: User Should Be Able To Add Any Number Of Related Content Blocks
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/page"
    And I fill in "Title" with "Investor Behat related content Page"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I fill in "Alternate Name" with "Related content Behat Test Page"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/8272101" in the "new_link" region
    And I fill in "Link text" with "related name1" in the "new_link" region
    And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name2" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-video-test" in the "new_link" region
    And I fill in "Link text" with "related name3" in the "new_link" region
    And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name4" in the "new_link" region
    And I type "BEHAT Related content Message Four" in the "Description" WYSIWYG editor number "3"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-video-test" in the "new_link" region
    And I fill in "Link text" with "related name5" in the "new_link" region
    And I type "BEHAT Related content Message Five" in the "Description" WYSIWYG editor number "4"
    And I wait 1 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Page Investor Behat related content Page has been created"
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat related content Page"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Investor Behat related content Page" in the maincontent region
    And I wait 1 seconds
    And I click "Investor Behat related content Page" in the maincontent region
    And I wait 1 seconds
    And I should see the text "related name1"
    And I should see the text "BEHAT Related content Message one"
    And I should see the text "related name2"
    And I should see the text "BEHAT Related content Message Two"
    And I should see the text "related name3"
    And I should see the text "BEHAT Related content Message Three"
    And I should see the text "related name4"
    And I should see the text "BEHAT Related content Message Four"
    And I should see the text "related name5"
    And I should see the text "BEHAT Related content Message Five"

@api @javascript @investor
Scenario: Add Related Content On Landing Page
  Given I am logged in as a user with the "Content Approver" role
    And "landing" content:
      | title                  | body                                            | status | moderation_state | nid |
      | Investor Behat Test LP | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
  When I visit "/Investor-Behat-Test-LP"
  Then I should see the text "Investor Behat Test LP"
    And I should see the text "Investor Behat Body Landing"
  When I visit "/node/123/edit"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "Landingpage related name1" in the "new_link" region
    And I wait 1 seconds
    And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/8272101" in the "new_link" region
    And I fill in "Link text" with "Landingpage related name2" in the "new_link" region
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I wait 1 seconds
    And I press the "edit-submit" button
    And I should see the text "Landing Page Investor Behat Test LP has been updated."
    And I should see the link "Landingpage related name1"
    And I click "Landingpage related name1"
  Then I should see the text "BEHAT Image Test"
  When I am on "/"
    And I fill in "Search Investor.gov" with "Investor Behat Test LP"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait for ajax to finish
  Then I should see the link "Investor Behat Test LP" in the maincontent region
    And I wait 1 seconds
  When I click "Investor Behat Test LP" in the maincontent region
    And I wait 1 seconds
  Then I should see the link "Landingpage related name2"
    And the hyperlink "Landingpage related name2" should match the Drupal url "/files/behat-pdf-file-test"

@api @javascript @investor
Scenario: Related Content Ordering
  Given I am logged in as a user with the "Content Approver" role
    And "landing" content:
      | title                  | body                                            | status | moderation_state | nid |
      | Investor Behat Test LP | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
  When I visit "/node/123/edit"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "Related Content Number 1" in the "new_link" region
    And I type "BEHAT Related content Message One" in the "Description" WYSIWYG editor number "0"
    And I wait 1 seconds
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/8272101" in the "new_link" region
    And I fill in "Link text" with "Related Content Number 2" in the "new_link" region
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I scroll to the bottom
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/media/412313" in the "new_link" region
    And I fill in "Link text" with "Related Content Number 3" in the "new_link" region
    And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
    And I scroll ".tabledrag-toggle-weight-wrapper" into view
    And I press "Show row weights"
    And I select "0" from "field_related_content[0][_weight]"
    And I select "-2" from "field_related_content[1][_weight]"
    And I select "2" from "field_related_content[2][_weight]"
    And I press the "edit-submit" button
    And I wait for ajax to finish
  Then I should see the text "Landing Page Investor Behat Test LP has been updated."
    And "Related Content Number 2" should precede "Related Content Number 1" for the query "//h3[contains(@class, 'card-title')]"
    And "Related Content Number 1" should precede "Related Content Number 3" for the query "//h3[contains(@class, 'card-title')]"
  When I visit "/node/123/edit"
    And I scroll ".tabledrag-toggle-weight-wrapper" into view
    And I select "0" from "field_related_content[0][_weight]"
    And I select "3" from "field_related_content[1][_weight]"
    And I select "-3" from "field_related_content[2][_weight]"
    And I press the "edit-submit" button
  Then I should see the text "Landing Page Investor Behat Test LP has been updated."
    And "Related Content Number 3" should precede "Related Content Number 2" for the query "//h3[contains(@class, 'card-title')]"
    And "Related Content Number 2" should precede "Related Content Number 1" for the query "//h3[contains(@class, 'card-title')]"

@api @javascript @investor
Scenario: Content Creator Edit Existing Basic Page With Related Content
  Given "page" content:
    | title             | body                                | status | moderation_state | nid     | field_alternate_name | field_show_featured_content |
    | Simple Basic Page | Behat body text http://www.SEC.gov/ | 1      | published        | 9876543 | Ron Burgundy         | 0                           |
    And "article" content:
      | title              | body                 | status | moderation_state |
      | Pizza Test Article | Free Free Free Pizza | 1      | published        |
    And "page" content:
      | title            | body           | status | nid | moderation_state |
      | Behat Basic Page | Free ice cream | 1      | 1   | published        |
    And I am logged in as a user with the "Content Creator" role
  When I am on "/node/9876543/edit"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
    And I fill in "Link text" with "related name1" in the "new_link" region
    And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/pizza-test-article" in the "new_link" region
    And I fill in "Link text" with "Free Pizza" in the "new_link" region
    And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
    And I press "Add Link"
    And I wait for ajax to finish
    And I fill in "URL" with "/node/1" in the "new_link" region
    And I fill in "Link text" with "Happy Hour starts at 6pm" in the "new_link" region
    And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
    And I select "Draft" from "edit-moderation-state-0-state"
    And I press the "edit-submit" button
  Then I should see the text "Basic page Simple Basic Page has been updated."
    And I should see the heading "Related Name1"
    And I should see the text "BEHAT Related content Message one"
    And I should see the heading "Free Pizza"
    And I should see the text "BEHAT Related content Message Two"
    And I should see the heading "Happy Hour Starts At 6pm"
    And I should see the text "BEHAT Related content Message Three"
  When I am logged in as a user with the "Content Approver" role
    And I am on "/node/9876543/latest"
  Then I should see the heading "Related Name1"
    And I should see the text "BEHAT Related content Message one"
    And I should see the heading "Free Pizza"
    And I should see the text "BEHAT Related content Message Two"
    And I should see the heading "Happy Hour Starts At 6pm"
    And I should see the text "BEHAT Related content Message Three"
  When I am logged in as a user with the "Content Creator" role
    And I am on "/node/9876543/edit"
    And I fill in "Alternate Name" with "Related content Behat Test Page 2"
    And I press "List additional actions"
    And I press "Remove"
    And I wait for ajax to finish
    And I press "Confirm removal"
    And I wait for ajax to finish
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press the "edit-submit" button
  Then I should see the text "Basic page Simple Basic Page has been updated."
    And I should not see the heading "Related Name1"
    And I should not see the text "BEHAT Related content Message one"
    And I should see the heading "Free Pizza"
    And I should see the text "BEHAT Related content Message Two"
    And I should see the heading "Happy Hour Starts At 6pm"
    And I should see the text "BEHAT Related content Message Three"
  When I am logged in as a user with the "Content Approver" role
    And I am on "/node/9876543/latest"
  Then I should not see the heading "Related Name1"
    And I should not see the text "BEHAT Related content Message one"
    And I should see the heading "Free Pizza"
    And I should see the text "BEHAT Related content Message Two"
    And I should see the heading "Happy Hour Starts At 6pm"
    And I should see the text "BEHAT Related content Message Three"
