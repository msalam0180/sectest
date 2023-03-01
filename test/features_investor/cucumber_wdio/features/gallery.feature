Feature: Create Investor Gallery
  I want to take screenshots of Gallery

  @create_gallery @wdio
  Scenario: Page Screenshot of Gallery Created
    Given I set my screensize to desktop
    When I visit "/behat-gallery"
      And I wait for "2" seconds
    Then I take current window screenshot and add text "gallery" to filename

  @gallery_no_title @wdio
  Scenario: Page Screenshot of Gallery No Title
    Given I set my screensize to desktop
    When I visit "/behat-gallery"
      And I wait for "2" seconds
    Then I take current window screenshot and add text "gallery_no_title" to filename

  @gallery_no_caption @wdio
  Scenario: Page Screenshot of Gallery No Caption
    Given I set my screensize to desktop
    When I visit "/behat-gallery"
      And I wait for "2" seconds
    Then I take current window screenshot and add text "gallery_no_caption" to filename

  @gallery_no_title_caption @wdio
  Scenario: Page Screenshot of Gallery No Title or Caption
    Given I set my screensize to desktop
    When I visit "/behat-gallery"
      And I wait for "2" seconds
    Then I take current window screenshot and add text "gallery_no_title_caption" to filename

  @gallery_media_all @wdio
  Scenario: Page Screenshot of Gallery with Supported Media
    Given I set my screensize to desktop
    When I visit "/behat-media-gallery"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot
