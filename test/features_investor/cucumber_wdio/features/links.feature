Feature: External links
  As a site visitor, the user should be able to click on external links and go to external sites

  @about_us @wdio
  Scenario: Full Screen About Us Link
    Given I set my screensize to desktop
    When I visit "/about-us"
    Then I take full page screenshot

  @contact_us @wdio
  Scenario: Full Screen Contact Us Link
    Given I set my screensize to desktop
    When I visit "/contact-us"
    Then I take full page screenshot
