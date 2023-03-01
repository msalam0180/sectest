Feature: Screenshots for Gallery
  As a visitor to investor.gov, I should be able to create, update and delete a gallery

  Background:
    Given I create "media" of type "video":
      | name             | field_video_origin | field_video                                 | mid    | field_caption | field_transcript |
      | BEHAT Bird Image | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312 | Bird caption  | Transcript       |
      | BEHAT Cat Video  | youtubevimeo       | https://www.youtube.com/watch?v=QIobikJiTuU | 312129 | Cat caption   | Transcript       |

  @api @javascript @ui @wdio
  Scenario: Create Gallery with Supported Media
    Given I create "media" of type "image":
      | name         | field_media_image      | mid   | field_caption  |
      | Black Rabbit | behat-black_rabbit.jpg | 11113 | Rabbit Caption |
      And I create "media" of type "audio":
      | name             | field_media_audio_file | mid   | field_caption | field_transcript   | field_thumbnail |
      | BEHAT Bird Audio | zgbh0016.mp3           | 11115 | sampleaudio   | Testforaddingaudio | behat-bird.gif  |
      And "gallery" content:
      | title               | body           | field_media                                     | moderation_state |
      | BEHAT Media Gallery | This is a test | BEHAT Cat Video, Black Rabbit, BEHAT Bird Audio | published        |
      And I am logged in as a user with the "content_approver" role
      And I run cron
      And I am on "/behat-media-gallery"
    Then I take a screenshot on "investor" using "gallery.feature" file with "@gallery_media_all" tag

  @api @javascript @ui @wdio
  Scenario: Create Gallery Screenshot
    Given "gallery" content:
      | title         | body           | field_media      | moderation_state |
      | BEHAT Gallery | This is a test | BEHAT Bird Image | published        |
    Then I take a screenshot on "investor" using "gallery.feature" file with "@create_gallery" tag
      And I am logged in as a user with the "content_approver" role
    # Gallery with No Title Screenshot
    When I visit "/admin/content"
      And I click "Edit" in the "BEHAT Gallery" row
      And I click on the element with css selector "#edit-field-show-media-titles-value"
      And I press "Save"
    Then I take a screenshot on "investor" using "gallery.feature" file with "@gallery_no_title" tag
      # Gallery with No Title and No Caption Screenshot
      And I click "Edit" in the "BEHAT Gallery" row
      And I click on the element with css selector "#edit-field-show-media-captions-value"
      And I press "Save"
    Then I take a screenshot on "investor" using "gallery.feature" file with "@gallery_no_title_caption" tag
      # Gallery with No Caption Screenshot
      And I click "Edit" in the "BEHAT Gallery" row
      And I click on the element with css selector "#edit-field-show-media-titles-value"
      And I press "Save"
    Then I take a screenshot on "investor" using "gallery.feature" file with "@gallery_no_caption" tag


