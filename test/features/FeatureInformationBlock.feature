
Feature: Verification of Label and Featured Information block
  As a visitor to SEC.gov
  I should not see the block title for the Agency Financial Report PDF and When I am on the OASB landing page i should see the Featured Information block.

@api @javascript
Scenario: Verify the Featured Information Block is visible on the OASB landing page
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/secarticle"
    And I fill in "Article Type" with "651"
    And I fill in "Title" with "Behat Test Article"
    And I fill in "Display Title" with "Behat Test OASB Article Display Title"
    And I fill in "Tags" with "OASB What's New"
    And I select "Corporation Finance" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "Behat Test OASB Article Display Title"
    And I am on "/node/add/landing_page"
    And I fill in "Title" with "BEHAT Landing Page"
    And I fill in "Display Title" with "BEHAT Test OASB Landing Page"
    And I fill in "Description/Abstract" with "This is a test for landing page"
    And I fill in "Tags" with "OASB What's New"
    And I select "Chief Operating Officer" from "Primary Division/Office"
    And I select "Enforcement" from "Supporting Division / Office"
    And I select "JOBS Act of 2012" from "Act"
    And I select "Regulation C" from "Regulation"
    And I select "Administration" from "Override Left Navigation"
    And I publish it
  When I am not logged in
    And I am on "/oasb"
  Then I should see the heading "News"
    And I should see the link "BEHAT Test OASB Landing Page" before I see the link "Behat Test OASB Article Display Title" in the "Whats New" view
  When I click "View more"
  Then I should see the heading "OASB News"
    And I should see the link "BEHAT Test OASB Landing Page"
    And I should see the link "Behat Test OASB Article Display Title"
