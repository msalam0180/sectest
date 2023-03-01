Feature: homepage
  As a Site Visitor and Drupal User, the user should be able to navigate easily throughout SEC.gov homepage

  @enable_banner @wdio
  Scenario: Government Official Banner Disable
    Given I set my screensize to desktop
    When I visit "/"
      And I click on ".usa-accordion__button "
      And I wait for "2" seconds
    Then I take screenshot of element "#top > div.dialog-off-canvas-main-canvas > div > section > div"

  @disable_banner @wdio
  Scenario: Government Official Banner Disable
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element ".usa-banner__inner"

  @header_uswdssec @wdio
  Scenario: Screenshot of the Header with uswdssec
    Given I set my screensize to desktop
    When I visit "/"
      And I wait for "2" seconds
    Then I take screenshot of element ".usa-navbar"