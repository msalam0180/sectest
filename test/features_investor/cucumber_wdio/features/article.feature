Feature: Create Investor Article
  As a Content Creator, I want to be able to create articles so that visitors to investor.gov can learn about the investor

  @new_article @wdio
  Scenario: Element Screenshot of New Article
    Given I set my screensize to desktop
    When I visit "/investor-behat-test-article"
     Then I take screenshot of element ".main-content"

  @link @wdio
  Scenario: Window Screenshot Of Article With Embed Link
    Given I set my screensize to desktop
    When I visit "/search?utf8=%3F&keys=Investor+Behat+Test+Article"
    Then I take current window screenshot and add text "Embed_Link" to filename

  @image @wdio
  Scenario: Full Screenshot Article With Embed Image
    Given I set my screensize to desktop
    When I visit "/files/gold-pig-1"
      And I hide "#twitter-widget-0,#block-footeremailsignup"
    Then I take full page screenshot

  @video @wdio
  Scenario: Full Screenshot Article With Embed Video
    Given I set my screensize to desktop
    When I visit "/files/best-video"
      And I hide "#twitter-widget-0, #block-footeremailsignup"
    Then I take full page screenshot

  @link_media @wdio
  Scenario: Element Screenshot Of Article With Link
    Given I set my screensize to desktop
    When I visit "/investor-behat-test-article-doc-file"
    Then I take screenshot of element ".main-content"

  @link_RC @wdio
  Scenario: Element Screenshot Related Content Article
    Given I set my screensize to desktop
    When I visit "/investor-behat-related-content-article"
       Then I take screenshot of element "#main-wrapper"
