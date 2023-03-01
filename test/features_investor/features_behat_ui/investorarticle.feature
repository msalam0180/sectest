Feature: Create Investor Article
  As a Content Creator, I want to be able to create articles so that visitors to investor.gov can learn about the investor

@ui @api @javascript @wdio
Scenario: Investor Create Article
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I take a screenshot on "investor" using "article.feature" file with "@new_article" tag

@ui @api @javascript @wdio
Scenario: Investor Create Image
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/media/add/image"
    And I fill in "Name" with "Gold pig"
    And attach the file "behat-gold-pig.png" to "Image"
    And I wait 5 seconds
    And I fill in "Alternative text" with "goldy"
    And I wait for ajax to finish
    And I press the "Save" button
  Then I take a screenshot on "investor" using "article.feature" file with "@image" tag

@ui @api @javascript @wdio
Scenario: Investor Create Article Embed Links
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary "
    And I type "Investor Behat Display Title http://www.finra.org/" in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I take a screenshot on "investor" using "article.feature" file with "@link" tag

@ui @api @javascript @wdio
Scenario: Investor Create Article Embed Video Full Screen
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/media/add/video"
    And I fill in "Name" with "Best Video"
    And I select "Upload" from "Video Origin"
    And attach the file "behat-sample.mp4" to "Video file"
    And I wait 5 seconds
    And I wait for ajax to finish
    And I press the "Save" button
  Then I take a screenshot on "investor" using "article.feature" file with "@video" tag

@ui @api @javascript @wdio
Scenario: Investor Create Article Link Media
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "file":
     | name             | field_media_file   |   mid    |
     | BEHAT File Test  | behat-file.doc     |  8272099 |
    And I run cron
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article DOC File"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I type "Click Here for Link to Media File >> " in the "Body" WYSIWYG editor
    And I scroll "#edit-body-wrapper" into view
    And I press "Link (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait 1 seconds
    And I fill in "URL" with "/media/8272099"
    And I wait 2 seconds
    And I click on the element with css selector "button.button"
    And I wait 2 seconds
    And I scroll to the bottom
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "Article Investor Behat Test Article DOC File has been created."
    And I should see the link "/media/8272099"
    And the hyperlink "/media/8272099" should match the Drupal url "/media/8272099"
    And I take a screenshot on "investor" using "article.feature" file with "@link_media" tag
