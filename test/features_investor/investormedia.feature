Feature: Investor Media
  As a content creator
  I would like to be able to create different types of media (image, audio, video, static file) so that they can be used on content

@api @javascript @investor
Scenario: Create a Video
  Given I am logged in as a user with the "content_approver" role
  When I visit "/media/add/video"
    And I fill in "Name" with "My favorite Investor.gov Video"
    And I select "YouTube or Vimeo" from "Video Origin"
    And I fill in "Video" with "https://vimeo.com/266444437"
    And I fill in "Caption" with "One of the Investor.gov videos on Vimeo"
    And I type "Financial advisor exposed" in the "Transcript" WYSIWYG editor
    And I attach the file "behat-wolf.jpg" to "Thumbnail"
    And I wait for ajax to finish
    And I should see the link "behat-wolf.jpg"
    And the hyperlink "behat-wolf.jpg" should match the Drupal url "/system/files/filefield_paths/behat-wolf.jpg"
    And I should see the "img" element with the "src" attribute set to "/system/files/styles/thumbnail/private/filefield_paths/behat-wolf.jpg" in the "media_image_thumbnail" region
    And I fill in "Alternative text" with "dem wolves"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the link "My favorite Investor.gov Video"
  When I click "My favorite Investor.gov Video"
  Then I should see the heading "My favorite Investor.gov Video"
    And I should see the "img" element with the "src" attribute set to "/sites/investorgov/files/" in the "investor_content" region

#TO DO scenario for audio, image, static file
