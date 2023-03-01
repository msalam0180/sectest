Feature: Create Investor Related Content
  As a Content Creator, I want to be able to create articles so that visitors to investor.gov can learn about the investor

  Background:
    Given I create "media" of type "file":
      | name                | field_media_file | mid     |
      | BEHAT PDF File Test | behat-file.pdf   | 8272101 |
      And I create "media" of type "image":
      | name             | field_media_image  | mid     |
      | BEHAT Image Test | behat-gold-pig.png | 8272102 |

  @ui @api @javascript @wdio
  Scenario: Related Content Block On Investor
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "Investor Behat related content Article"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Article Summary"
      And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
      And I fill in "Alternate Name" with "Related content Behat Test"
      And I press "Add Link"
      And I wait 2 seconds
      And I fill in "URL" with "/files/behat-image-test"
      And I fill in "Link text" with "related Image"
      And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
      And I press "Add Link"
      And I wait 2 seconds
      And I fill in "URL" with "/media/8272101" in the "new_link" region
      And I fill in "Link text" with "related File" in the "new_link" region
      And I wait 1 seconds
      And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
      And I press "Add Link"
      And I wait 2 seconds
      And I fill in "URL" with "/files/behat-video-test" in the "new_link" region
      And I fill in "Link text" with "related video" in the "new_link" region
      And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
      And I click on the element with css selector "#edit-field-show-featured-content-value"
      And I wait 1 seconds
      And I select "Published" from "edit-moderation-state-0-state"
      And I wait 1 seconds
      And I press the "edit-submit" button
    Then I should see the text "Article Investor Behat related content Article has been created"
      And I take a screenshot on "investor" using "article.feature" file with "@link_RC" tag

  @ui @api @javascript @wdio
  Scenario: Screenshot For Related Content On Landing Page
    Given I am logged in as a user with the "Content Approver" role
      And "landing" content:
      | title                             | body                                            | status | moderation_state | nid |
      | Investor Behat Related Content LP | Investor Behat Body Landing  http://www.abc.org | 1      | published        | 123 |
    When I visit "/investor-behat-related-content-lp"
    Then I should see the text "Investor Behat Related Content LP"
      And I should see the text "Investor Behat Body Landing"
      And I visit "/node/123/edit"
      And I press "Add Link"
      And I wait 1 seconds
      And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
      And I fill in "Link text" with "Landingpage related name1" in the "new_link" region
      And I wait 1 seconds
      And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
      And I press "Add Link"
      And I wait 5 seconds
      And I fill in "URL" with "/media/8272101" in the "new_link" region
      And I fill in "Link text" with "Landingpage related name2" in the "new_link" region
      And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
      And I wait 1 seconds
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@landingpage_rc" tag
