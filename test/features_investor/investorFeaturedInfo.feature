# Able to create new items for featured information
# Able to delete an item for featured information
# Able to edit previous items for featured information
# Able to put text with links for featured information

Feature: Featured Information
  As a visitor to investor.gov, I should be able to view and edit Featured Information block on Homepage

@api @javascript @investor
Scenario: Create Feature Information
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/publication"
    And I fill in "edit-title-0-value" with "HelloWorld1"
    And I select the radio button "Publication"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  When I am logged in as a user with the "Site Builder" role
    And I am on "/block/81"
    And I press "field-items-link-add-more"
    And I wait for ajax to finish
    And I fill in "URL" with "/HelloWorld1" in the "addlink" region
    And I fill in "Link text" with "Hello World" in the "addlink" region
    And I type "Investor Behat Test Article" in the "Description" WYSIWYG editor
    And I press the "Save" button
  Then I should see the text "Feature Block Featured Information has been updated."
    And I am on "/"
    And I should see the text "Featured Information"
    And I click "Hello World"
    And I should see the text "HelloWorld1"

@api @javascript @investor
Scenario: Update Feature Information
  Given I am logged in as a user with the "Site Builder" role
  When I am on "/block/81"
    And I press "field-items-0-edit--2"
    And I wait for ajax to finish
    And I fill in "URL" with "High Yield Investment Programs (1091)" in the "addlink" region
    And I fill in "Link text" with "Investor Local edited" in the "addlink" region
    And I type "Investor Behat Test Article edited" in the "Description" WYSIWYG editor
    And I press the "Save" button
  Then I should see the text "Feature Block Featured Information has been updated."
    And I am on "/"
    And I should see the text "Featured Information"
    And I click "Investor Local edited"
    And I should see the text "High-Yield Investment Programs"

@api @javascript @investor
Scenario: Enter text with link Feature Information
  Given I am logged in as a user with the "Site Builder" role
  When I am on "/block/81"
    And I press "field-items-link-add-more"
    And I wait for ajax to finish
    And I fill in "URL" with "/protect-your-investments/fraud/types-fraud/high-yield-investment-programs" in the "addlink" region
    And I fill in "Link text" with "Link added using URL" in the "addlink" region
    And I type "added URL in the Description" in the "Description" WYSIWYG editor
    And I press the "Save" button
  Then I should see the text "Feature Block Featured Information has been updated."
    And I am on "/"
    And I should see the text "Featured Information"
    And I click "Link added using URL"
    And I should see the text "High-Yield Investment Programs"

@api @investor
Scenario: Glossary Page
  Given I am on "/introduction-investing/investing-basics/glossary"
  Then I should see the text "# | A | B | C | D | E | F | G | H | I | L | M | N | O | P | Q | R | S | T | U | V | W | Y | Z | ALL"

  @api @javascript @investor
  Scenario: Verify Texts are Showing Bold When Using Strong Tag for Publication
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/publication"
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
