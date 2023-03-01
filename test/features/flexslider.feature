@flexslider
Feature: Create and View Flexslider
  As a content creator/approver user
  I want to be able to create and add a flexslider to landing pages
  So that I can see it show up on the Landing page

  @api
  Scenario: Create Flexslider hero
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "(Behat) Slider Test"
      And I fill in "Display Title" with "(Behat) Slider Test"
      And I fill in "Body" with "This is the body"
      And I fill in "Tags" with "NEO Slider"
      And I publish it
    Then I should see the text "(Behat) Slider Test"

  @api @javascript
  Scenario: Division/Office Admin Can Edit Hero Flexslider
    Given I am logged in as a user with the "division_office_admin" role
      And "sec_hero" content:
        | title              | field_display_title       | body               | field_tags | moderation_state | status |
        | Behat Slider Test  | Behat Slider Test Title 1 | This is the body 1 | OGC Slider | published        | 1      |
    When I visit "admin/content/search"
      And I click "Edit" in the "Behat Slider Test" row
      And I type "Updated " in the "Body" WYSIWYG editor
      And I publish it
    Then I should see the text "Updated This is the body 1"

  @api @javascript
  Scenario: Add IM Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | IM Slider  | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | IM Slider  | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | IM Slider  | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | IM Slider  | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | IM Slider  | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | IM Slider  | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "IM Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add OCA Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | OCA Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | OCA Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | OCA Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | OCA Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | OCA Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | OCA Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "OCA Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add Enforcement Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | ENF Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | ENF Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | ENF Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | ENF Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | ENF Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | ENF Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box           | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | My mommy and daddy know me | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "ENF Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api
  Scenario: Check FlexSider Carousel List
    Given I am logged in as a user with the "administrator" role
    When I visit "/admin/structure/views/view/flexslider"
    Then I should see the link "OCA Slider"
      And I should see the link "OCIE Slider"
      And I should see the link "ARO Slider"
      And I should see the link "BRO Slider"
      And I should see the link "CHRO Slider"
      And I should see the link "DRO Slider"
      And I should see the link "FWRO Slider"
      And I should see the link "LARO Slider"
      And I should see the link "MIRO Slider"
      And I should see the link "NYRO Slider"
      And I should see the link "PHRO Slider"
      And I should see the link "IM Slider"
      And I should see the link "SLRO Slider"
      And I should see the link "SFRO Slider"
      And I should see the link "ALJ Slider"
      And I should see the link "EDGARSys Slider"
      And I should see the link "EBO Slider"
      And I should see the link "OHR Slider"
      And I should see the link "OIT Slider"
      And I should see the link "OA Slider"
      And I should see the link "OIG Slider"
      And I should see the link "OIA Slider"
      And I should see the link "ENF Slider"
      And I should see the link "OIEA Slider"
      And I should see the link "OCOO Slider"
      And I should see the link "OCR Slider"
      And I should see the link "OLIA Slider"
      And I should see the link "OCRO Slider"
      And I should see the link "OMWI Slider"
      And I should see the link "OMS Slider"
      And I should see the link "OEEO Slider"
      And I should see the link "OPA Slider"
      And I should see the link "OEC Slider"
      And I should see the link "Structure Data Slider"
      And I should see the link "OS Slider"
      And I should see the link "OFM Slider"
      And I should see the link "OSO Slider"
      And I should see the link "OGC Slider"
      And I should see the link "NEO Slider"
      And I should see the link "OASB Slider"
      And I should see the link "CF Slider"
      And I should see the link "DERA Slider"
      And I should see the link "TM Slider"
      And I should see the link "finhub Slider"

  @api @javascript
  Scenario: Add OGC Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | OGC Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | OGC Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | OGC Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | OGC Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | OGC Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | OGC Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "OGC Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add OHR Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | OHR Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | OHR Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | OHR Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | OHR Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | OHR Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | OHR Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "OHR Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add NYRO Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags  | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | NYRO Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | NYRO Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | NYRO Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | NYRO Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | NYRO Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | NYRO Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "NYRO Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add EDGARSys Slider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags      | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | EDGARSys Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | EDGARSys Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | EDGARSys Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | EDGARSys Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | EDGARSys Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | EDGARSys Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "EDGARSys Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add OFM Slider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | OFM Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | OFM Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | OFM Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | OFM Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | OFM Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | OFM Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "OFM Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |

  @api @javascript
  Scenario: Add OASB Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags  | moderation_state | status | created             |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | OASB Slider | published        | 1      | 2021-06-17T17:00:00 |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | OASB Slider | published        | 1      | 2021-05-17T17:00:00 |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | OASB Slider | published        | 1      | 2021-04-17T17:00:00 |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | OASB Slider | published        | 1      | 2021-03-17T17:00:00 |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | OASB Slider | published        | 1      | 2021-02-17T17:00:00 |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | OASB Slider | published        | 1      | 2021-01-17T17:00:00 |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "OASB Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      And I should not see the slides:
        | body               |
        | This is the body 5 |
        | This is the body 6 |
    When I click "Next ›"
    Then I should see the slides:
      | body               |
      | This is the body 5 |
      | This is the body 6 |
      And I should not see the slides:
        | body               |
        | This is the body 1 |
        | This is the body 2 |
        | This is the body 3 |
        | This is the body 4 |

  @api @javascript
  Scenario: Add Flexslider On NEO Page
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Testing Ticket 5870 for NEO Flexslider"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I type "Lion Image" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-lion.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Lion Image"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "NEO"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Lion Image" in the "contentarea" region
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Testing Ticket 5870 for NEO Flexslider"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I type "Wolf Image" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-wolf.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Wolf Image"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "NEO"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Wolf Image" in the "contentarea" region
    When I visit "/node/add/landing_page"
      And I fill in "Title" with "Testing Ticket 5870 for NEO Flexslider"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I scroll to the bottom
      And I publish it
    Then I should see the text "Testing Image Overlap"
      And I place the "NEO Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
    When I visit "/ohr/neo"
    Then I should see the slides:
      | body       |
      | Wolf Image |
      | Lion Image |

  @api @javascript
  Scenario: Add Flexslider On Structureddata Page
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Testing Ticket 5870 for Structureddata"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I type "Lion Image" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-image-lions.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Lion Image"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "structureddata"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Lion Image" in the "contentarea" region
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Testing Ticket 5870 for Structureddata"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I type "Wolf Image" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-image-wolves.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Wolf Image"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "structureddata"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Wolf Image" in the "contentarea" region
    When I visit "/node/add/landing_page"
      And I fill in "Title" with "Testing Ticket 5870"
      And I fill in "Display Title" with "Testing Image Overlap"
      And I scroll to the bottom
      And I publish it
    Then I should see the text "Testing Image Overlap"
    When I place the "Structure Data Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I visit "/structureddata"
    Then I should see the slides:
      | body       |
      | Wolf Image |
      | Lion Image |

  @api @javascript
  Scenario: Verify Division/Office Admin Can Manage Hero Flexslider
    Given I am logged in as a user with the "division_office_admin" role
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Verify division office admin can manage flexslider slide 1"
      And I fill in "Display Title" with "slide1"
      And I type "Lion King" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-image-lion.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Adult Lion"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "EBO Slider"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Adult Lion" in the "contentarea" region
    When I visit "/node/add/sec_hero"
      And I fill in "Title" with "Verify division office admin can manage flexslider slide 2"
      And I fill in "Display Title" with "slide2"
      And I type "Lone Wolf" in the "Body" WYSIWYG editor
      And I press "Image" in the "Body" WYSIWYG Toolbar
      And I attach the file "behat-image-wolf.jpg" to "Image"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Adult Wolf"
      And I click "Save" on the modal "Insert Image"
      And I wait 3 seconds
      And I fill in "Tags" with "EBO Slider"
      And I publish it
    Then I should see the "img" element with the "alt" attribute set to "Adult Wolf" in the "contentarea" region
    When I visit "/node/add/landing_page"
      And I fill in "Title" with "Verify division office admin can manage flexslider landing page"
      And I fill in "Display Title" with "flex landing page"
      And I scroll to the bottom
      And I publish it
    Then I should see the text "flex landing page"
    When I place the "EBO Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
    When I visit "/edgar/filer-information"
    Then I should see the slides:
      | body      |
      | Lone Wolf |
      | Lion King |
    When I visit "/filergroup/announcements"
    Then I should see the slides:
      | body      |
      | Lone Wolf |
      | Lion King |
    When I visit "admin/content/search"
      And I click "Edit" in the "Verify division office admin can manage flexslider slide 1" row
      And I click "edit-delete"
      And I press the "Delete" button
      And I visit "/edgar/filer-information"
    Then I should see the slides:
      | body      |
      | Lone Wolf |
      And I should not see the slides:
        | body      |
        | Lion King |
    When I visit "/filergroup/announcements"
    Then I should see the slides:
      | body      |
      | Lone Wolf |
      And I should not see the slides:
        | body      |
        | Lion King |

  @api @javascript
  Scenario: Add Finhub Flexslider view to landing page
    Given I am logged in as a user with the "administrator" role
      And "sec_hero" content:
        | title                 | field_display_title         | body               | field_tags    | moderation_state | status |
        | (Behat) Slider Test 1 | (Behat) Slider Test Title 1 | This is the body 1 | Finhub Slider | published        | 1      |
        | (Behat) Slider Test 2 | (Behat) Slider Test Title 2 | This is the body 2 | Finhub Slider | published        | 1      |
        | (Behat) Slider Test 3 | (Behat) Slider Test Title 3 | This is the body 3 | Finhub Slider | published        | 1      |
        | (Behat) Slider Test 4 | (Behat) Slider Test Title 4 | This is the body 4 | Finhub Slider | published        | 1      |
        | (Behat) Slider Test 5 | (Behat) Slider Test Title 5 | This is the body 5 | Finhub Slider | published        | 1      |
        | (Behat) Slider Test 6 | (Behat) Slider Test Title 6 | This is the body 6 | Finhub Slider | published        | 1      |
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
    When I visit "/page/behat-landing-page"
      And I place the "finhub Flexslider Carousel" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I wait 2 seconds
      And I reload the page
    Then I should see the slides:
      | body               |
      | This is the body 1 |
      | This is the body 2 |
      | This is the body 3 |
      | This is the body 4 |
      | This is the body 5 |
      | This is the body 6 |
