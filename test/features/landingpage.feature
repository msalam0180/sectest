Feature: Create and View Landing Pages
  As a visitor to SEC.gov
  I want to be able to view landing pages
  So that I can learn about the SEC

  @api @javascript
  Scenario: Creating a Landing Page through the UI
    Given I am logged in as a user with the "administrator" role
    When I am on "/node/add/landing_page"
      And I fill in "Title" with "BEHAT Landing Page"
      And I fill in "Display Title" with "BEHAT Page"
      And I fill in "Description/Abstract" with "This is a test for landing page"
      And I fill in "Tags" with "landing"
      And I select "Chief Operating Officer" from "Primary Division/Office"
      And I select "Enforcement" from "Supporting Division / Office"
      And I select "JOBS Act of 2012" from "Act"
      And I select "Regulation C" from "Regulation"
      And I select "Administration" from "Override Left Navigation"
      And I type "This is the left1 landing box" in the "Left 1 - Box" WYSIWYG editor
      And I type "This is the left2 landing box" in the "Left 2 - Box" WYSIWYG editor
      And I type "This is the left3 landing box" in the "Left 3 - Box" WYSIWYG editor
      And I type "This is the left4 landing box" in the "Left 4 - Box" WYSIWYG editor
      And I type "This is the left5 landing box" in the "Left 5 - Box" WYSIWYG editor
      And I type "This is the right2 landing box" in the "Right 2 - Box" WYSIWYG editor
      And I type "This is the right3 landing box" in the "Right 3 - Box" WYSIWYG editor
      And I type "This is the right4 landing box" in the "Right 4 - Box" WYSIWYG editor
      And I type "This is the center2 landing box" in the "Center 2 - Box" WYSIWYG editor
      And I fill in the following:
      | field_date[0][value][date] | 11-01-2020 |
      | field_date[0][value][time] | 13:00:00PM |
      And I publish it
    Then I should see the heading "BEHAT Page"
      And I should see the text "This is the left1 landing box"
      And I should see the text "This is the left2 landing box"
      And I should see the text "This is the left3 landing box"
      And I should see the text "This is the left4 landing box"
      And I should see the text "This is the left5 landing box"
      And I should see the text "This is the right2 landing box"
      And I should see the text "This is the right3 landing box"
      And I should see the text "This is the right4 landing box"
      And I should see the text "This is the center2 landing box"
      And I should see the text "Modified: Nov. 1, 2020"
      And I should not see the text "Left 1 - Box"
      And I should not see the text "Left 2 - Box"
      And I should not see the text "Left 3 - Box"
      And I should not see the text "Left 4 - Box"
      And I should not see the text "Left 5 - Box"
      And I should not see the text "Right 2 - Box"
      And I should not see the text "Right 3 - Box"
      And I should not see the text "Right 4 - Box"
      And I should not see the text "Center 2 - Box"

  @api
  Scenario: Viewing a Landing Page
    Given I am logged in as a user with the "administrator" role
    When I am viewing an "landing_page" content:
      | title               | MyTitle       |
      | field_display_title | Display Title |
      | field_left_1_box    | Left 1        |
      | field_left_2_box    | Left 2        |
      | field_left_3_box    | Left 3        |
      | field_left_4_box    | Left 4        |
      | field_left_5_box    | Left 5        |
      | field_center_2_box  | Center 2      |
      | field_right_2_box   | Right 2       |
      | field_right_3_box   | Right 3       |
      | field_right_4_box   | Right 4       |
    Then I should see the heading "Display Title"
      And I should see the text "Left 1"
      And I should see the text "Left 2"
      And I should see the text "Left 3"
      And I should see the text "Left 4"
      And I should see the text "Left 5"
      And I should see the text "Center 2"
      And I should see the text "Right 3"
      And I should see the text "Right 4"

  @api @javascript
  Scenario: Editing a Landing Page
    Given "landing_page" content:
      | title                    | field_display_title | field_primary_division_office | field_left_1_box |
      | Behat Landing Page Title | Behat Display Title | Credit Ratings                | Left 1           |
      And  I am logged in as a user with the "administrator" role
    When I visit "/admin/content/search"
      And I fill in "Title" with "Behat Landing Page Title"
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "Behat Display Title" row
      And I type "Edited Left 1" in the "Left 1 - Box" WYSIWYG editor
      And I publish it
    Then I should see the text "Edited"

  @api @javascript
  Scenario: Deleting a Landing Page
    Given "landing_page" content:
      | title                           | field_display_title | field_primary_division_office | field_left_1_box |
      | Behat Delete Landing Page Title | Behat Display Title | Credit Ratings                | Left 1           |
      And I am logged in as a user with the "administrator" role
    When I visit "/admin/content/search"
      And I fill in "Title" with "Behat Delete Landing Page Title"
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Edit" in the "Behat Delete Landing Page Title" row
      And I click "Delete" in the "navigation_tab" region
      And I press "Delete"
    When I visit "/page/behat-delete-landing-page-title"
    Then I should see the heading "Oops! Page Not Found."

# commenting this scenario out as regional office landing pages are no longer using dynamic map for location
  # @api @javascript
  # Scenario Outline: Verify Map Rendering On Regional Offices Landing Pages
  #   Given I visit "/page/sec-regional-offices"
  #   Then I should see the heading "SEC Regional Offices"
  #     And I should see the "div" element with the "id" attribute set to "regionalOfficeMap" in the "contentarea"
  #     And I should see the "canvas" element with the "class" attribute set to "mapboxgl-canvas" in the "contentarea"
  #     And I should see the link "<Office>"
  #     And I should see the text "<Address>"
  #     And I should see the text "<StateZip>"
  #     And I should see the text "<Phone>"
  #   When I click "<Office>"
  #   Then I should see the "<element1>" element with the "<attribute1>" attribute set to "<value1>" in the "contentarea" region
  #     And I should see the "<element2>" element with the "<attribute2>" attribute set to "<value2>" in the "contentarea" region
  #     And I should see the heading "<Office>"
  #     And I should see the text "<Address>"
  #     And I should see the text "<StateZip>"
  #     And I should see the text "<Phone>"

  #   Examples:
  #     | Office                        | Address                                | StateZip                 | Phone        | element1 | attribute1 | value1                              | element2 | attribute2 | value2                                                      |
  #     | Atlanta Regional Office       | 950 East Paces Ferry Rd NE, Suite 900  | Atlanta, GA 30326        | 404-842-7600 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Boston Regional Office        | 33 Arch Street, 24th Floor             | Boston, MA 02110         | 617-573-8900 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Chicago Regional Office       | 175 W. Jackson Boulevard, Suite 1450   | Chicago, IL 60604        | 312-353-7390 | div      | class      | leaflet-container leaflet-fade-anim | img      | class      | leaflet-marker-icon leaflet-zoom-animated leaflet-clickable |
  #     | Denver Regional Office        | 1961 Stout Street, Suite 1700          | Denver, CO 80294         | 303-844-1000 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Fort Worth Regional Office    | 801 Cherry Street, Suite 1900, Unit 18 | Fort Worth, TX 76102     | 817-978-3821 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Los Angeles Regional Office   | 444 South Flower Street, Suite 900     | Los Angeles, CA 90071    | 323-965-3998 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Miami Regional Office         | 801 Brickell Ave., Suite 1950          | Miami, FL 33131          | 305-982-6300 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | New York Regional Office      | 200 Vesey Street, Suite 400            | New York, NY 10281       | 212-336-1100 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | Salt Lake Regional Office     | 351 S. West Temple St., Suite 6.100    | Salt Lake City, UT 84101 | 801-524-5796 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |
  #     | San Francisco Regional Office | 44 Montgomery Street, Suite 2800       | San Francisco, CA 94104  | 415-705-2500 | canvas   | class      | mapboxgl-canvas                     | div      | class      | mapboxgl-marker mapboxgl-marker-anchor-center               |

  @api @javascript
  Scenario: Landing Page Selection Of No Menu Option
    Given I am logged in as a user with the "Content Approver" role
    When I visit "node/add/landing_page"
      And I fill in "Title" with "Testing Ticket 13643"
      And I fill in "Display Title" with "No Menu Option has been added"
      And I select "Enforcement" from "Primary Division/Office"
      And I select "Enforcement" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"
      And I click the panelizer "Edit" link
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "No Menu" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should not see the text "Enforcement Manual"
      And I should not see the text "Public Alerts"
      And I should not see the text "Federal Court Actions"
      And I click the panelizer "Edit" link
      And I wait 2 seconds
      And I hover over the element "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > button"
      And I wait 2 seconds
      And I click on the element with css selector "#block-secgov-content > article > div.contextual > ul > li:nth-child(1) > a"
      And I wait 2 seconds
      And I scroll to the bottom
    When I select "Enforcement" from "Override Left Navigation"
      And I publish it
    Then I should see the text "No Menu Option has been added"
      And I should see the text "Enforcement"
      And I should see the text "Enforcement Manual"
      And I should see the text "Public Alerts"
      And I should see the text "Federal Court Actions"

  @api
  Scenario: Verify Duplicate Landing Page Content Is Not Showing In The Content Dashboard
     Given "secperson" content:
      | title      | field_first_name_secperson | field_last_name_secperson | body                                                                               | field_enable_biography_page | status |
      | John Behat | John                       | Behat                     | John started working with behat in 2017 and has been maintaining behat ever since. | 1                           | 1      |
      | Jane Behat | Jane                       | Behat                     | Jane started working with behat in 2018 and has been maintaining behat ever since. | 1                           | 1      |
      And "division_office" terms:
        | name              | field_abbreviated |
        | BEHAT             | bht               |
      And "landing_page" content:
        | title                  | field_display_title    | field_primary_division_office | field_left_1_box |
        | Behat for Landing Page | Behat for Landing Page | BEHAT                         | Left 1           |
    When I am logged in as a user with the "Content Approver" role
      And I am on "admin/content/search"
      And I fill in "Behat for Landing Page" for "Title"
      And I press "Filter"
    Then I should see the text "Displaying 1 - 1 of 1"
      And I click "Edit" in the "Behat for Landing Page" row
      And I select "John Behat" from "Speaker"
      And I additionally select "Jane Behat" from "Speaker"
      And I publish it
    When I am on "admin/content/search"
      And I fill in "Behat for Landing Page" for "Title"
      And I press "Filter"
    Then I should see the text "Displaying 1 - 1 of 1"

  @api
  Scenario: Verify that .legacy__region .region__inner is applied to Right 2 - Box, Right 3 - Box, Right 4 - Box
    Given I am on "/finhub"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/oasb/sbforum2021"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/page/ososectionlanding"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/financial-readiness/making-money-grow"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/reaching-new-heights-conversations-raising-capital-businesses-color"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/advocate/positier/evidence-summit-event-2017"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/page/ofmsectionlanding"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/dera"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/ebo"
    Then I should see the css selector ".legacy__region .region__inner"
    Given I am on "/page/oieasectionlanding"
    Then I should see the css selector ".legacy__region .region__inner"
