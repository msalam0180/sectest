Feature: Gallery Slideshow
  As a content creator
  I would like to be able to create galleries around different
  events/topics/etc and select existing videos to be displayed
   in that gallery so that end users can quickly see all related media

Background:

  Given I create "media" of type "video":
      | name               | field_video_origin | field_video                                 | mid    | field_caption  | field_transcript |
      | BEHAT Bird Image   | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312 | Bird caption   | Transcript       |
      | BEHAT Rabbit Image | youtubevimeo       | https://www.youtube.com/watch?v=fsSOMSTsM0o | 221313 | Rabbit caption |                  |
      | BEHAT Cat Image    | youtubevimeo       | https://www.youtube.com/watch?v=QIobikJiTuU | 312123 |                |                  |
      | BEHAT Dog Image    | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313 | Dog caption    |                  |
    And I create "media" of type "image":
      | name              | field_media_image      | mid    | field_caption        |
      | Gold Pig Tail     | behat-gold-pig.png     | 111112 | Pig Caption          |
      | Black Rabbit Tail | behat-black_rabbit.jpg | 111113 | Black Rabbit Caption |
    And I create "media" of type "audio":
      | field_media_audio_file | mid    | field_caption | field_transcript   | field_thumbnail    |
      | behat-zgbh0016.mp3     | 111115 | sampleaudio   | Testforaddingaudio | behat-bird.gif     |
      | behat-kuda0001.mp3     | 111116 | Ascentaudio   | Audio file         | behat-cat.png      |
      | behat-Ascent.wav       | 111117 | WAVaudio      | wavAudio file      | behat-gold-pig.png |

@api @javascript @investor
Scenario: Create a Gallery
  Given I am logged in as a user with the "content_approver" role
  When I visit "/node/add/gallery"
    And I fill in "Title" with "Behat Test Title"
    And I press the "Add existing media" button
    And I wait 3 seconds
    And I press the "Select entities" button
    And I wait for AJAX to finish
    And I switch to the iframe "entity_browser_iframe_gallery_browser"
    And I wait 1 seconds
    And I fill in "Search" with "behat"
    And I press the "Apply" button
    And I wait for AJAX to finish
    And I check the box "entity_browser_select[media:112312]"
    And I check the box "entity_browser_select[media:221313]"
    And I check the box "entity_browser_select[media:312123]"
    And I check the box "entity_browser_select[media:412313]"
    And I press "edit-submit"
    And I wait 2 seconds
    And I switch to the main window
    And I press the "Add existing media" button
    And I wait for AJAX to finish
    And I press the "Select entities" button
    And I wait for AJAX to finish
    And I switch to the iframe "entity_browser_iframe_gallery_browser"
    And I wait 1 seconds
    And I fill in "Search" with "dog"
    And I press the "Apply" button
    And I wait for AJAX to finish
  Then I should see the text "BEHAT Dog Image"
  When I press "edit-submit"
    And I wait 2 seconds
    And I switch to the main window
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
  Then I should see the link "Behat Test Title"
  When I visit "/behat-test-title"
  Then "BEHAT Bird Image" should precede "BEHAT Rabbit Image" for the query "//div[contains(@class, 'media-box-title')]"
  When I am on "/admin/content"
    And I click "Edit" in the "Behat Test Title" row
    And I wait 2 seconds
    And I drag image "BEHAT Rabbit Image" onto "BEHAT Bird Image"
    And I press "Save"
    And I wait 2 seconds
    And I run cron
    And I am logged in as a user with the "Authenticated user" role
    And I visit "/behat-test-title"
    And "BEHAT Rabbit Image" should precede "BEHAT Bird Image" for the query "//div[contains(@class, 'media-box-title')]"
    And I click on the element with css selector "#grid > div:nth-child(2) > div > button"
    And I press "Previous (Left arrow key)"
  Then I should see the text "bird caption"
  When I press "Next (Right arrow key)"
  Then I should see the text "rabbit caption"

@api @javascript @investor
Scenario Outline: Show Gallery Titles and Captions
  Given I am logged in as a user with the "content_approver" role
  When I visit "/node/add/gallery"
    And I fill in "Title" with "Behat Test Title"
    And I scroll to the bottom
    And I press the "Add existing media" button
    And I wait 3 seconds
    And I press the "Select entities" button
    And I wait for AJAX to finish
    And I switch to the iframe "entity_browser_iframe_gallery_browser"
    And I wait 1 seconds
    And I fill in "Search" with "behat"
    And I press the "Apply" button
    And I wait for AJAX to finish
    And I check the box "entity_browser_select[media:312123]"
    And I check the box "entity_browser_select[media:412313]"
    And I press "edit-submit"
    And I wait 2 seconds
    And I switch to the main window
    And I <Action1> the box "Show Media Captions"
    And I <Action2> the box "Show Media Titles"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I am logged in as a user with the "Authenticated user" role
    And I visit "/behat-test-title"
    And I wait 2 seconds
    And I scroll to the bottom
  Then I should <vid_title_flag> the text "BEHAT Dog Image"
    And I should <vid_caption_flag> the text "Dog caption"
  When I click on the element with css selector "#grid > div:nth-child(3) > div > button"
  Then I should <vid_caption_flag> the text "Dog caption" in the "in_video_caption" region

    Examples:
      | Action1 | Action2 | vid_title_flag | vid_caption_flag |
      | uncheck | check   | see            | not see          |
      | check   | uncheck | not see        | see              |
      | uncheck | uncheck | not see        | not see          |
      | check   | check   | see            | see              |

@api @javascript @investor
Scenario: Video With Transcript Show Link To Related Video
  Given "gallery" content:
    | title         | body           | field_media      |
    | BEHAT Gallery | This is a test | BEHAT Bird Image |
    And I am logged in as a user with the "content_approver" role
  When I visit "/admin/content"
    And I click "Edit" in the "BEHAT Gallery" row
    And I click on the element with css selector "#edit-field-media-entities-0-actions-ief-entity-edit"
    And I wait for AJAX to finish
    And I press "Remove"
    And I wait for AJAX to finish
    And I press "Update media"
    And I wait 5 seconds
    And I press "Save"
    And I visit "/behat-gallery"
    And I click on the element with css selector ".media-box-image"
  Then I should see the link "Link to Transcript"

@api @javascript @investor
Scenario: Search and Delete Video from Gallery
  Given "gallery" content:
    | title         | body           | field_media                       |
    | BEHAT Gallery | This is a test | BEHAT Bird Image, BEHAT Dog Image |
    And I am logged in as a user with the "content_approver" role
  When I visit "/behat-gallery"
    And I wait 2 seconds
    And I should see "BEHAT Bird Image"
    And I should see "BEHAT Dog Image"
    And I fill in "Search Gallery" with "Bird"
    And I wait 2 seconds
  Then I should see "BEHAT Bird Image"
    And I should not see "BEHAT Dog Image"
  When I visit "/admin/content"
    And I click "Edit" in the "BEHAT Gallery" row
    And I press "Remove"
    And I wait 3 seconds
    And I press "Remove"
    And I wait 3 seconds
    And I press "Save"
    And I visit "/behat-gallery"
  Then I should not see "BEHAT Bird Image"
    And I should see "BEHAT Dog Image"

@api @javascript @investor
Scenario: Create Image Gallery and Reorder Images in the Gallery
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/gallery"
    And I fill in "Title" with "Behat Test Title"
    And I press the "Add existing media" button
    And I wait 3 seconds
    And I press the "Select entities" button
    And I wait for AJAX to finish
    And I switch to the iframe "entity_browser_iframe_gallery_browser"
    And I wait 1 seconds
    And I fill in "Search" with "tail"
    And I press the "Apply" button
    And I wait for AJAX to finish
    And I check the box "entity_browser_select[media:111112]"
    And I check the box "entity_browser_select[media:111113]"
    And I press "edit-submit"
    And I wait 2 seconds
    And I switch to the main window
    And I press the "Add existing media" button
    And I wait 3 seconds
    And I press the "Select entities" button
    And I wait for AJAX to finish
    And I switch to the iframe "entity_browser_iframe_gallery_browser"
    And I wait 1 seconds
    And I fill in "Search" with "Pig"
    And I press the "Apply" button
    And I wait for AJAX to finish
  Then I should see the text "Gold Pig Tail"
  When I press "edit-submit"
    And I wait 2 seconds
    And I switch to the main window
    And I press "Save"
  Then I should see the link "Behat Test Title"
  When I visit "/behat-test-title"
    And I wait 1 seconds
  Then "Gold Pig Tail" should precede "Black Rabbit Tail" for the query "//div[contains(@class,'media-box-title')]"
  When I am on "/admin/content"
    And I click "Edit" in the "Behat Test Title" row
    And I wait 2 seconds
    And I drag image "Gold Pig Tail" onto "Black Rabbit Tail"
    And I wait 1 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I wait 2 seconds
    And I visit "/behat-test-title"
  Then "Black Rabbit Tail" should precede "Gold Pig Tail" for the query "//div[contains(@class, 'media-box-title')]"

@api @javascript @investor
Scenario: Delete Images From Gallery
  Given "gallery" content:
    | title               | body           | field_media                      |
    | BEHAT Image Gallery | This is a test | Gold Pig Tail, Black Rabbit Tail |
    And I am logged in as a user with the "content_approver" role
  When I visit "/behat-image-gallery"
    And I wait 2 seconds
    And I should see "Gold Pig Tail"
    And I should see "Black Rabbit Tail"
    And I fill in "Search Gallery" with "Black"
    And I wait 2 seconds
  Then I should see "Black Rabbit Tail"
    And I should not see "Gold Pig Tail"
  When I visit "/admin/content"
    And I click "Edit" in the "BEHAT Image Gallery" row
    And I press "Remove"
    And I wait 3 seconds
    And I press "Remove"
    And I wait 3 seconds
    And I press "Save"
    And I visit "/behat-image-gallery"
    And I wait 2 seconds
  Then I should see "Black Rabbit Tail"
    And I should not see "Gold Pig Tail"

@api @javascript @investor
Scenario: Create Audio From Gallery
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/admin/content/media"
    And I click "Edit" in the "zgbh0016.mp3" row
    And I fill in "Name" with "Tweety Bird"
    And I fill in "Alternative text" with "Bird"
    And I wait 2 seconds
    And I press "Save"
    And I am on "/admin/content/media"
    And I click "Edit" in the "kuda0001.mp3" row
    And I fill in "Name" with "Cuty Cat"
    And I fill in "Alternative text" with "Cat"
    And I wait 2 seconds
    And I press "Save"
    And I am on "/admin/content/media"
    And I click "Edit" in the "behat-Ascent.wav" row
    And I fill in "Name" with "Pig"
    And I fill in "Alternative text" with "Gold"
    And I wait 2 seconds
    And I press "Save"
    And "gallery" content:
      | title         | body           | field_media                | moderation_state |
      | BEHAT Gallery | This is a test | Tweety Bird, Cuty Cat, Pig | published        |
    And I visit "/behat-gallery"
    And I wait for AJAX to finish
  Then I should see the text "Tweety Bird"
    And I should see the text "Cuty Cat"
    And I should see the text "Pig"
  When I wait 2 seconds
    And I scroll "#grid" into view
    And I should see the "img" element with the "alt" attribute set to "Tweety Bird" in the "landingpage_video" region
    And I click on the element with css selector "div.audio:nth-child(5) > div:nth-child(1) > button:nth-child(2)"
    And I wait 1 seconds
    And I click on the element with css selector "#audioplayer > div.field.field--name-field-media-audio-file.field--type-file.field--label-hidden.field__item"
    And I move backward one page
    And I wait 1 seconds
    And I click on the element with css selector ".mfp-close"
    And I wait 1 seconds
  Then I should see the "img" element with the "alt" attribute set to "Cuty Cat" in the "landingpage_video" region
  When I click on the element with css selector "div.audio:nth-child(5) > div:nth-child(1) > button:nth-child(2)"
    And I wait 1 seconds
    And I click on the element with css selector "#audioplayer > div.field.field--name-field-media-audio-file.field--type-file.field--label-hidden.field__item"
    And I click on the element with css selector ".mfp-close"
    And I wait 1 seconds
  Then I should see the "img" element with the "alt" attribute set to "Pig" in the "landingpage_video" region
    And I click on the element with css selector "div.audio:nth-child(7) > div:nth-child(1) > button:nth-child(2)"
    And I wait 1 seconds
    And I click on the element with css selector "#audioplayer > div.field.field--name-field-media-audio-file.field--type-file.field--label-hidden.field__item"
    And I click on the element with css selector ".mfp-close"

@api @javascript @investor
Scenario: Verify Texts are Showing Bold When Using Strong Tag for Gallery
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/gallery"
    And I fill in "Title" with "Behat Test Title"
    And I fill in "Title" with "Testing ticket 13871"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I press "Bold" in the "Body" WYSIWYG Toolbar
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I scroll to the bottom
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Testing ticket 13871"
    And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div > p > strong" element

@api @javascript @investor
Scenario Outline: Authorized Users Can Add Main Nav Menu For Gallery
  Given "gallery" content:
    | title                | body           | field_media                                                         | nid    |
    | BEHAT Animal Gallery | This is a test | Gold Pig Tail, Black Rabbit Tail, BEHAT Bird Image, BEHAT Cat Image | 895298 |
    And I am logged in as a user with the "<role>" role
  When I visit "/admin/content"
    And I click "Edit" in the "BEHAT Animal Gallery" row
    And I click on the element with css selector "#edit-menu"
    And the checkbox "Provide a menu link" should be unchecked
    And I check the box "Provide a menu link"
    And I fill in "Menu link title" with "BEHAT Test File Gallery"
    And I select "---- Spotlight" from "Parent link"
    And I select "<status>" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Gallery BEHAT Animal Gallery has been updated"
  When I am on "/user"
    And I hover over the element "#investor-main-menu > .menu-index-4"
  Then I should see "BEHAT Test File Gallery"
    And I click "BEHAT Test File Gallery"
    And I wait 2 seconds
  Then I should see the text "BEHAT Animal Gallery"
  When I am logged in as a user with the "<role>" role
    And I am on "/node/895298/edit"
    And I click on the element with css selector "#edit-menu"
    And I uncheck the box "Provide a menu link"
    And I select "<status>" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I am on "/user"
    And I hover over the element "#investor-main-menu > .menu-index-4"
  Then I should not see "BEHAT Test File Gallery"

  Examples:
    | role                           | status    |
    | Content Creator, Site Builder  | Draft     |
    | Administrator                  | Published |
    | Content Approver, Site Builder | Published |

@api @javascript @investor
Scenario Outline: Authorized Users Can Add Left Nav Menu For Gallery
  Given "gallery" content:
    | title                | body           | field_media                                                         | nid    |
    | BEHAT Animal Gallery | This is a test | Gold Pig Tail, Black Rabbit Tail, BEHAT Bird Image, BEHAT Cat Image | 895298 |
  When I am logged in as a user with the "<role>" role
    And I am on "/node/895298/edit"
    And I click on the element with css selector "#edit-menu"
    And the checkbox "Provide a menu link" should be unchecked
    And I check the box "Provide a menu link"
    And I fill in "Menu link title" with "BEHAT Test File Gallery"
    And I select "------ Director's Take" from "Parent link"
    And I select "<status>" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Gallery BEHAT Animal Gallery has been updated"
  When I am on "/user"
    And I hover over the element "#investor-main-menu > .menu-index-4"
    And I click "Director's Take"
    And I wait 2 seconds
  Then I should see the link "BEHAT Test File Gallery"
  When I click "BEHAT Test File Gallery"
  Then I should see the text "BEHAT Animal Gallery"
  When I am logged in as a user with the "<role>" role
    And I am on "/node/895298/edit"
    And I click on the element with css selector "#edit-menu"
    And I uncheck the box "Provide a menu link"
    And I select "<status>" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I am on "/user"
    And I hover over the element "#investor-main-menu > .menu-index-4"
    And I click "Director's Take"
    And I wait 2 seconds
  Then I should not see "BEHAT Test File Gallery"

  Examples:
    | role                           | status    |
    | Content Creator, Site Builder  | Draft     |
    | Administrator                  | Published |
    | Content Approver, Site Builder | Published |

@api @javascript @investor
Scenario Outline: View Main Nav Menu For Gallery
  Given "gallery" content:
    | title                | body           | field_media                                                         | nid    | moderation_state | status |
    | BEHAT Animal Gallery | This is a test | Gold Pig Tail, Black Rabbit Tail, BEHAT Bird Image, BEHAT Cat Image | 895298 | draft            | 0      |
    And I am logged in as a user with the "Content Approver, Site Builder" role
  When I visit "/admin/content"
    And I should see the text "Unpublished" in the "BEHAT Animal Gallery" row
    And I click "Edit" in the "BEHAT Animal Gallery" row
    And I click on the element with css selector "#edit-menu"
    And the checkbox "Provide a menu link" should be unchecked
    And I check the box "Provide a menu link"
    And I fill in "Menu link title" with "BEHAT Test File Gallery"
    And I select "---- Spotlight" from "Parent link"
    And I select "<save_as>" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Gallery BEHAT Animal Gallery has been updated"
  When I am not logged in
    And I am on the homepage
    And I hover over the element "#investor-main-menu > .menu-index-4"
  Then I <validate> see "BEHAT Test File Gallery"

  Examples:
    | save_as   | validate   |
    | Draft     | should not |
    | Published | should     |
