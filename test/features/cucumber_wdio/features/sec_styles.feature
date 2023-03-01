Feature: Styles on SEC Pages
  As a Content Creator, I want to be able to create basic page and add accordion
  So that visitors to sec.gov can learn about the sec styles

  @accordion1 @wdio
  Scenario: Accordion on SEC page
    Given I set my screensize to desktop
    When I visit "/page/behat-landing-page1"
      And I wait for "1" seconds
    Then I take screenshot of element "#content-wrapper"
    # Expanded Accordion
      And I click on "#ui-id-5"
      And I wait for "1" seconds
    Then I take screenshot of element "#content"

  @accordion2 @wdio
  Scenario: Accordion on SEC page left nav bar
    Given I set my screensize to desktop
    When I visit "/page/behat-landing-page1"
      And I wait for "1" seconds
    Then I take screenshot of element "#sidebar-first"
    # Expanded Accordion Menu
      And I click on "#ui-id-1"
      And I wait for "1" seconds
    Then I take screenshot of element "#sidebar-first > aside"

  @tab1 @wdio
  Scenario: Tab on SEC page
    Given I set my screensize to desktop
    When I visit "/page/behat-landing-page2"
      And I wait for "1" seconds
      And I click on "#ui-id-1"
      And I wait for "1" seconds
    Then I take screenshot of element "#full-width"
      And I click on "#ui-id-2"
      And I wait for "1" seconds
    Then I take screenshot of element "#content"
      And I click on "#ui-id-3"
      And I wait for "1" seconds
    Then I take screenshot of element "#block-secgov-content"
      And I click on "#ui-id-4"
      And I wait for "1" seconds
    Then I take screenshot of element "#content > div"

  @breadcrumbs @wdio
  Scenario: Landing Page Breadcrumbs with uswdssec Theme
    Given I set my screensize to desktop
      And I visit "/page/behat-we-regulate-securities-markets-landing-page"
      And I wait for "1" seconds
    Then I take screenshot of element ".c-breadcrumb"

  @uswds_page_title @wdio
  Scenario: Landing Page Title with uswdssec Theme
    Given I set my screensize to desktop
      And I visit "/page/behat-we-regulate-securities-markets-landing-page"
      And I wait for "1" seconds
    Then I take screenshot of element ".l-page-title"
