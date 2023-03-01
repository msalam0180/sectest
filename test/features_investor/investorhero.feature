Feature: Create Hero Block
As an Content Creator, I want to have the ability to create a Hero Block

@api @investor
Scenario Outline: Verify Permissions for Hero Block
  Given I am logged in as a user with the "<role>" role
  When I am on "/block/add/hero"
  Then I should see the text "<result>"

  Examples:
    | role                                            | result                                      |
    | Authenticated user                              | You are not authorized to access this page. |
    | Content Creator                                 | You are not authorized to access this page. |
    | Content Approver                                | You are not authorized to access this page. |
    | Site Builder                                    | Add Hero custom block                       |
    | Administrator                                   | Add Hero custom block                       |
    | Content Creator, Content Approver, Site Builder | Add Hero custom block                       |

@api @javascript @investor
Scenario: Create and Delete a Hero Block
  Given I am logged in as a user with the "Site Builder" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12345 |
  When I am on "/block/add/hero"
    And I fill in "Block description" with "Behat Test Hero custom Block"
    And I fill in "Hero Heading" with "Behat Hero Heading"
    And I fill in "Link" with "http://www.sec.gov"
    And I fill in "Use existing media" with "Hero pig (12345)"
    And I wait for ajax to finish
    And I press "Save"
  Then I should see the text "Hero Behat Test Hero custom Block has been created."
    And I am on "/admin/structure/block/block-content"
    And I click "Edit" in the "Behat Test Hero custom Block" row
    And I click on the element with css selector "#edit-delete"
    And I press "Delete"

@api @javascript @investor
Scenario Outline: Adding Hero Block to Landing Page
  Given I am logged in as a user with the "<role>" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 122225 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I am on "/Behat-Landing-Page"
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Testing Hero Title"
    And I fill in "Hero Heading" with "Behat Testing Hero Heading"
    And I fill in "Use existing media" with "Hero pig"
    And I press "Add block"
    And I wait for ajax to finish
    And I select "Published" from "Change to"
    And I scroll to the top
    And I press "Save layout"
    And I am logged in as a user with the "Authenticated user" role
    And I am on "/Behat-Landing-Page"
  Then I should see the text "Behat Testing Hero Title"

   Examples:
    | role                           |
    | Content Approver               |
    | Administrator                  |
    | Content Approver,Administrator |

@api @javascript @investor
Scenario: Adding New Section and Hero to Landing Page
  Given I am logged in as a user with the "Content Creator" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I am on "/Behat-Landing-Page"
    And I wait 2 seconds
    And I click "Layout"
    And I click "Add section"
    And I wait for ajax to finish
    And I click "One column"
    And I wait for ajax to finish
    And I click "Add section"
    And I wait for ajax to finish
    And I click "Two column"
    And I wait for ajax to finish
    And I press "Add section"
    And I wait for ajax to finish
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Testing Hero Title"
    And I fill in "Hero Heading" with "Behat Testing Hero Heading"
    And I fill in "Use existing media" with "Hero pig"
    And I press "Add block"
    And I wait for ajax to finish
  Then I should see the text "Behat Testing Hero Title"

@api @investor
Scenario: Unauthorized Users Can View Only Published Landing Page
  Given "landing" content:
    | title                          | body                           | moderation_state |
    | BEHAT Published Landing Page   | This is the BEHAT landing page | published        |
    | BEHAT Unpublished Landing Page | This is the BEHAT landing page | draft            |
    And I am logged in as a user with the "authenticated user" role
  When I am on "/behat-published-landing-page"
  Then I should see the heading "BEHAT Published Landing Page"
  When I am on "/behat-unpublished-landing-page"
  Then I should see the text "Access denied"
    And I should see the text "You are not authorized to access this page."

@api @javascript @investor
Scenario: Hero Section Display's No Title
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid   | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 12222 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I set browser window size to "1450" x "1050"
    And I am on "/Behat-Landing-Page"
    And I wait 2 seconds
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click on the element with css selector "#drupal-off-canvas > div > ul > li:nth-child(3) > a"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Testing Hero Title"
    And I uncheck "Display title"
    And I fill in "Hero Heading" with "Behat Testing Hero Heading"
    And I fill in "Use existing media" with "Hero pig"
    And I press "Add block"
    And I wait for ajax to finish
  Then I should not see the text "Behat Testing Hero Title"

@api @javascript @investor
Scenario: Discard Changes to Landing Page In Layouts
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 122225 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I am on "/Behat-Landing-Page"
    And I wait 2 seconds
    And I click "Layout"
    And I scroll to the top
    And I click on the element with css selector "#edit-discard-changes"
    And I wait 1 seconds
    And I click on the element with css selector "#edit-submit"
  Then I should see the text "The changes to the layout have been discarded."

@api @javascript @investor
Scenario: Revert Changes for Landing Page In Layouts
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "image":
      | name     | field_media_image  | field_media_image_alt | mid    | moderation_state |
      | Hero pig | behat-gold-pig.png | some alt txt          | 122225 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I am on "/Behat-Landing-Page"
    And I wait 2 seconds
    And I click "Layout"
    And I scroll to the top
    And I click on the element with css selector "#edit-revert"
    And I wait 1 seconds
    And I click on the element with css selector "#edit-submit"
  Then I should see the text "The layout has been reverted back to defaults."

@api @javascript @investor
Scenario: Add Hyperlink to a Hero Block
  Given I create "media" of type "image":
    | name     | field_media_image  | field_media_image_alt | mid    | moderation_state |
    | Hero pig | behat-gold-pig.png | some alt txt          | 122225 | publication      |
    And "landing" content:
      | title              |
      | BEHAT Landing Page |
  When I am logged in as a user with the "Content Approver" role
    And I am on "/Behat-Landing-Page"
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click "Hero"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Testing Hero Title"
    And I fill in "Hero Heading" with "Behat Testing Hero Heading"
    And I fill in "Link" with "/introduction-investing"
    And I fill in "Use existing media" with "Hero pig"
    And I press "Add block"
    And I wait for ajax to finish
    And I select "Published" from "Change to"
    And I scroll to the top
    And I press "Save layout"
    And I am logged in as a user with the "Authenticated user" role
    And I am on "/Behat-Landing-Page"
    And I click "Behat Testing Hero Heading"
  Then I should see the text "Introduction to Investing"
