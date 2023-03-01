Feature: Replicate Content Nodes And Blocks
  As a Content Creator to Investor.gov
  I want to be able to duplicate a content
  So that I can leverage existing contents to create similar content

  Additionally, as a Sitebuilder to Investor.gov
  I want to be able to duplicate blocks
  So that I can leverage existing blocks to create similar block

  Background:
    Given users:
      | uid  | name        | mail           | roles           | status |
      | 9995 | bh_creator1 | test5@test.com | Content Creator | 1      |
      | 9996 | bh_creator2 | test6@test.com | Content Creator | 1      |
      | 9997 | bh_sb       | test7@test.com | Site Builder    | 1      |
      And "tags" terms:
        | name     | tid  |
        | tag team | 8020 |
      And "glossary_term_categories" terms:
        | name      | tid  |
        | lip gloss | 8021 |
      And "news_category" terms:
        | name    |
        | weather |
      And I create "media" of type "image":
        | name             | field_media_image  | mid     | field_caption | KEY |
        | BEHAT Image Test | behat-gold-pig.png | 8272102 | Pig Caption   | 500 |
      And "news" content:
        | title               | body                                            | nid    | status | moderation_state |
        | Investor Behat News | Investor Behat news Title http://www.finra.org/ | 999886 | 1      | published        |
      And "featured" content:
        | title           | body                 | status | moderation_state | field_teaser   | field_media_image | nid  |
        | Behat Feature 1 | Behat Feature body 1 | 1      | published        | a short teaser | BEHAT Image Test  | 4231 |

@api @javascript @investor
Scenario: Replicate Landing Page Content
  Given "landing" content:
    | title                       | body                        | status | moderation_state | nid     | uid  | field_alternate_name | field_hide_page_title | field_related_content_label | field_show_featured_content |
    | Investor Behat Test Landing | Investor Behat Body Landing | 1      | published        | 9876543 | 9995 | Ron Burgundy         | 1                     | News anchorman              | 0                           |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Landing Page 2"
    And I press "Replicate"
    #  Checking to make sure landing page form info got cloned over
  Then I should see the heading "Edit Landing Page Behat Landing Page 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Landing Page 2"
    And the checkbox "Hide Page Title" is checked
    And the "Body" field should contain "Investor Behat Body Landing"
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I uncheck the box "Hide Page Title"
    And I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the heading "Behat Landing Page 2"
    And I should see the text "Investor Behat Body Landing"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Article Content
  Given "article" content:
    | title                       | body                        | status | moderation_state | nid     | uid  | field_alternate_name | field_related_content_label | field_show_featured_content | field_tags |
    | Investor Behat Test Article | Investor Behat Body Article | 1      | published        | 9876543 | 9995 | Ron Burgundy         | News anchorman              | 0                           | tag team   |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Article 2"
    And I press "Replicate"
    #  Checking to make sure article form info got cloned over
  Then I should see the heading "Edit Article Behat Article 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Article 2"
    And the "Body" field should contain "Investor Behat Body Article"
    And the "edit-field-tags-target-id" field should contain "tag team (8020)"
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat Article 2"
    And I should see the heading "Tags"
    And I should see the link "tag team"
    And I should see the text "Investor Behat Body Article"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Basic Page Content
  Given "page" content:
    | title                   | body                                | status | moderation_state | nid     | uid  | field_alternate_name | field_related_content_label | field_show_featured_content |
    | Edit Test Page Investor | Behat Body Text http://www.SEC.gov/ | 1      | published        | 9876543 | 9995 | Ron Burgundy         | News anchorman              | 0                           |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Basic Page 2"
    And I press "Replicate"
    #  Checking to make sure basic page form info got cloned over
  Then I should see the heading "Edit Basic page Behat Basic Page 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Basic Page 2"
    And the "Body" field should contain "Behat Body Text http://www.SEC.gov/"
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat Basic Page 2"
    And I should see the text "Behat Body Text http://www.SEC.gov/"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Featured Content
  Given "featured" content:
    | title           | body                 | status | moderation_state | field_teaser   | nid     | uid  | field_media_image | field_url                          |
    | Behat Feature 2 | Behat Feature body 2 | 1      | published        | a short teaser | 9876543 | 9995 | BEHAT Image Test  | Click Here - http://www.google.com |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Featured Test 3"
    And I press "Replicate"
    #  Checking to make sure featured form info got cloned over
  Then I should see the heading "Edit Featured Behat Featured Test 3"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Featured Test 3"
    And the "edit-field-url-0-uri" field should contain "http://www.google.com"
    And the "Link text" field should contain "Click Here"
    And the "Teaser" field should contain "a short teaser"
    And the "edit-field-media-image-0-target-id" field should contain "BEHAT Image Test (8272102)"
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
    And I press the "Save" button
  Then I should see the text "Behat Featured Test 3"
    And I should see the link "Click Here"
    And I should see the text "a short teaser"
    Then I should see the "img" element with the "src" attribute set to "/behat-gold-pig" in the "investor_content" region
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Glossary Term Content
  Given "glossary_term" content:
    | title             | body                         | nid     | status | moderation_state | field_additional_information | uid  | field_alternate_name | field_related_content_label | field_show_featured_content | field_glossary_category |
    | Investor Glossary | Investor Behat Glossary Body | 9876543 | 1      | published        | Stay glossy                  | 9995 | Ron Burgundy         | News anchorman              | 0                           | lip gloss               |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Glossary Term 2"
    And I press "Replicate"
    #  Checking to make sure glossary term form info got cloned over
  Then I should see the heading "Edit Glossary Term Behat Glossary Term 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Glossary Term 2"
    And the "Body" field should contain "Investor Behat Glossary Body"
    And the "edit-field-glossary-category-0-target-id" field should contain "lip gloss (8021)"
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat Glossary Term 2"
    And I should see the text "Investor Behat Glossary Body"
    And I should see the text "Stay glossy"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Gallery Content
  Given I create "media" of type "video":
      | name             | field_video_origin | field_video                                 | mid    | field_caption | field_transcript |
      | BEHAT Bird Image | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312 | Bird caption  | Transcript       |
      | BEHAT Cat Image  | youtubevimeo       | https://www.youtube.com/watch?v=QIobikJiTuU | 312123 |               |                  |
      | BEHAT Dog Image  | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313 | Dog caption   |                  |
    And I create "media" of type "image":
      | name              | field_media_image      | mid    | field_caption  |
      | Black Rabbit Tail | behat-black_rabbit.jpg | 111113 | Rabbit Caption |
    And I create "media" of type "audio":
      | field_media_audio_file | mid    | field_caption | field_transcript   | field_thumbnail |
      | behat-zgbh0016.mp3     | 111115 | sampleaudio   | Testforaddingaudio | behat-bird.gif  |
      | behat-kuda0001.mp3     | 111116 | Ascentaudio   | Audio file         | behat-cat.png   |
    And "gallery" content:
      | title                | body           | field_media                                                                                                   | field_show_media_captions | field_show_media_titles | status | moderation_state | nid     | uid  | field_alternate_name | field_related_content_label | field_show_featured_content |
      | BEHAT Animal Gallery | This is a test | BEHAT Dog Image, behat-kuda0001.mp3, behat-zgbh0016.mp3, BEHAT Bird Image, BEHAT Cat Image, Black Rabbit Tail | 0                         | 0                       | 1      | published        | 9876543 | 9995 | Ron Burgundy         | News anchorman              | 0                           |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Gallery 2"
    And I press "Replicate"
    #  Checking to make sure gallery form info got cloned over
  Then I should see the heading "Edit Gallery Behat Gallery 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Gallery 2"
    And the "Body" field should contain "This is a test"
    And I should see the text "BEHAT Dog Image"
    And I should see the text "behat-kuda0001.mp3"
    And I should see the text "behat-zgbh0016.mp3"
    And I should see the text "BEHAT Bird Image"
    And I should see the text "BEHAT Cat Image"
    And I should see the text "Black Rabbit Tail"
    And the checkbox "Show Media Captions" is unchecked
    And the checkbox "Show Media Titles" is unchecked
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Media Captions"
    And I check the box "Show Media Titles"
    And I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat Gallery 2"
    And I should see the text "This is a test"
    And I should see the text "BEHAT Dog Image"
    And I should see the text "behat-kuda0001.mp3"
    And I should see the text "behat-zgbh0016.mp3"
    And I should see the text "BEHAT Bird Image"
    And I should see the text "BEHAT Cat Image"
    And I should see the text "Black Rabbit Tail"
    And I should see the text "Dog caption"
    And I should see the text "Ascentaudio"
    And I should see the text "sampleaudio"
    And I should see the text "Bird caption"
    And I should see the text "Rabbit Caption"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario Outline: Replicate News Content
  Given "news" content:
    | title             | body           | field_news_type | status | moderation_state | field_date          | field_news_category | nid     | uid  | field_alternate_name | field_related_content_label | field_show_featured_content |
    | Behat News <type> | Test news body | <news_type>     | 1      | published        | 2021-02-14T13:00:00 | weather             | 9876543 | 9995 | Ron Burgundy         | News anchorman              | 0                           |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat News <type> 2"
    And I press "Replicate"
    #  Checking to make sure news form info got cloned over
  Then I should see the heading "Edit News Behat News <type> 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat News <type> 2"
    And the "edit-field-date-0-value-date" field should contain "2021-02-14"
    And the "Body" field should contain "test news body"
    And the "#edit-field-news-type option[selected='selected']" element should contain "<news_type>"
    And the "#edit-field-news-category option[selected='selected']" element should contain "weather"
    And the "Alternate Name" field should contain "Ron Burgundy"
    And the "Related Content Label" field should contain "News anchorman"
    And the checkbox "Show Featured Content" is unchecked
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat News <type> 2"
    And I should see the text "test news body"
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

  Examples:
    | type     | news_type          |
    | Alert    | Investor Alerts    |
    | Bulletin | Investor Bulletins |

@api @javascript @investor
Scenario: Replicate Publication Content
  Given "publication" content:
    | title                      | body                            | status | moderation_state | field_publication_type | field_publication_image | nid     | uid  | field_alternate_name | field_related_content_label | field_show_featured_content |
    | Investor Behat publication | Investor Behat publication body | 1      | published        | Info Sheet             | BEHAT Image Test        | 9876543 | 9995 | Ron Burgundy         | News anchorman              | 0                           |
  When I am logged in as "bh_creator2"
    And I am on "/node/9876543/edit"
    And I click "Replicate" in the "navigation_tab" region
    And I should see the heading "Are you sure you want to replicate node entity id 9876543?"
    And I fill in "edit-new-label-en" with "Behat Publication Test 2"
    And I press "Replicate"
    #  Checking to make sure publication form info got cloned over
  Then I should see the heading "Edit Publication Behat Publication Test 2"
    And I should see the text "node (9876543) has been replicated to id"
    And I should see the text "Draft" in the "edit_meta" region
    And I should see the text "bh_creator2" in the "edit_author" region
    And the "Title" field should contain "Behat Publication Test 2"
    And the "Body" field should contain "Investor Behat publication body"
    Then radio button with id "edit-field-publication-type-61" should be checked
    And the "edit-field-publication-image-0-target-id" field should contain "BEHAT Image Test (8272102)"
    And the "#edit-moderation-state-0-state option[selected='selected']" element should contain "Draft"
  When I check the box "Show Featured Content"
    And I press the "Save" button
  Then I should see the text "Behat Publication Test 2"
    And I should see the text "Investor Behat publication body"
    Then I should see the "img" element with the "src" attribute set to "/behat-gold-pig" in the "investor_content" region
    And I should see the text "Featured Content"
    And I should see the link "Behat Feature 1"
    And I should see the text "a short teaser"
    #  Checking to make sure revision info does not get cloned over
  When I click "Revisions"
  Then I should see the text "by bh_creator2"
    But I should not see the text "by Anonymous"
    And I should not see the text "by bh_creator1"

@api @javascript @investor
Scenario: Replicate Basic Block
  Given I create "block_content" of type "basic":
    | type  | info            | body    | uuid                 | id   |
    | basic | Here be dragons | RAWWWR! | test--here-be-dragon | 7070 |
  When I am logged in as "bh_sb"
    And I am on "/block/7070"
    And I click "Replicate"
    And I should see the heading "Are you sure you want to replicate block_content entity id 7070?"
    And I fill in "edit-new-label-en" with "New Kids On The Basic Block"
    And I press "Replicate"
    #  Checking to make sure block info got cloned over
  Then I should see the heading "Edit custom block New Kids On The Basic Block"
    And I should see the text "block_content (7070) has been replicated to id"
    And the "Block description" field should contain "New Kids On The Basic Block"
    And the "Body" field should contain "RAWWWR!"
    And I should see the text "No revision"
  When I press the "Save" button
  Then I should see the text "New Kids On The Basic Block"
    And I should see the text "Basic block" in the "New Kids On The Basic Block" row

@api @javascript @investor
Scenario: Replicate Hero Block
  Given I create "block_content" of type "hero":
    | type | info                | field_hero_heading | uuid               | id    | field_sub_text     | field_link         | field_bg_image | field_align_text | field_text_theme | field_space_below |
    | hero | Let me be your hero | RAWWWR!            | test--here-be-hero | 70071 | This is a sub text | http://www.sec.gov | 500            | left             | dark             | 0                 |
  When I am logged in as "bh_sb"
    And I am on "/block/70071"
    And I click "Replicate"
    And I should see the heading "Are you sure you want to replicate block_content entity id 70071?"
    And I fill in "edit-new-label-en" with "New Kids On The Hero Block"
    And I press "Replicate"
    #  Checking to make sure block info got cloned over
  Then I should see the heading "Edit custom block New Kids On The Hero Block"
    And I should see the text "block_content (70071) has been replicated to id"
    And the "Block description" field should contain "New Kids On The Hero Block"
    And the "Hero Heading" field should contain "RAWWWR!"
    And the "Sub-Text" field should contain "This is a sub text"
    And the "edit-field-link-0-uri" field should contain "http://www.sec.gov"
    And the "edit-field-bg-image-0-target-id" field should contain "BEHAT Image Test (8272102)"
    And the "#edit-field-align-text option[selected='selected']" element should contain "Left"
    And the "#edit-field-text-theme option[selected='selected']" element should contain "Dark"
    And the checkbox "Add spacing below the Hero Image" is unchecked
  When I press the "Save" button
  Then I should see the text "New Kids On The Hero Block"
    And I should see the text "Hero" in the "New Kids On The Hero Block" row
