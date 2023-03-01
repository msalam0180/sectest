Feature: Featured Information
  As a visitor to investor.gov, I should be able to view and edit Featured Information block on Homepage

@api @javascript @ui @wdio
Scenario: Create Feature Information
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/publication"
    And I fill in "edit-title-0-value" with "HelloWorld1"
    And I select the radio button "Publication"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I take a screenshot on "investor" using "featuredinfo.feature" file with "@featured_info" tag
