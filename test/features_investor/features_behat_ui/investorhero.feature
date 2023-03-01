Feature: Investor Hero Page Screenshots
  Adding a Hero block to landing page with different alignments and themes

  @ui @javascript @api @wdio
  Scenario: Dark Left Center Right Hero Screenshot No Title
    Given I am logged in as a user with the "administrator" role
      And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
      And "landing" content:
      | title              | field_show_featured_content |
      | BEHAT Landing Page | 0                           |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I press "Add block"
      And I wait 1 seconds
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Left" from "Align Text"
      And I press "Add block"
      And I wait 1 seconds
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Right" from "Align Text"
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I click on the element with css selector "#edit-submit"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@hero_dark" tag

  @ui @javascript @api @wdio
  Scenario: Light Left Center Right Hero Screenshot No Title
    Given I am logged in as a user with the "administrator" role
      And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
      And "landing" content:
      | title              | field_show_featured_content |
      | BEHAT Landing Page | 0                           |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Light" from "Text Theme"
      And I press "Add block"
      And I wait 1 seconds
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Left" from "Align Text"
      And I select "Light" from "Text Theme"
      And I press "Add block"
      And I wait 1 seconds
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I uncheck "Display title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Right" from "Align Text"
      And I select "Light" from "Text Theme"
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I click on the element with css selector "#edit-submit"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@hero_light" tag

  @ui @javascript @api @wdio
  Scenario: Dark Left Center Right Hero Screenshot With Title
    Given I am logged in as a user with the "administrator" role
      And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
      And "landing" content:
      | title              | field_show_featured_content |
      | BEHAT Landing Page | 0                           |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@hero_title_dark" tag

  @ui @javascript @api @wdio
  Scenario: Light Left Center Right Hero Screenshot With Title
    Given I am logged in as a user with the "administrator" role
      And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
      And "landing" content:
      | title              | field_show_featured_content |
      | BEHAT Landing Page | 0                           |
    When I am on "/Behat-Landing-Page"
      And I click "Layout"
      And I click "Add block "
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Hero Title"
      And I fill in "Hero Heading" with "Behat Testing Hero Heading"
      And I fill in "Sub-Text" with "subtext testing"
      And I fill in "Use existing media" with "Hero pig"
      And I select "Light" from "Text Theme"
      And I press "Add block"
      And I wait for ajax to finish
      And I select "Published" from "Change to"
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I take a screenshot on "investor" using "landingpage.feature" file with "@hero_title_light" tag
