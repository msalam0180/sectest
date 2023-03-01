Feature: Featured Content
  As a vistor user should be able to see feature content

  @feature_page @wdio
  Scenario: Element Screenshot of Featured for Page
    Given I set my screensize to desktop
    When I visit "/node/1"
   Then I take screenshot of element "#main-wrapper"

  @feature_gallery @wdio
  Scenario: Full Screenshot of Featured for Gallery
    Given I set my screensize to desktop
    When I visit "/behat-gallery"
      And I hide "#twitter-widget-0,#block-footeremailsignup"
    Then I take full page screenshot and add text "feature_gallery" to filename

  @feature_article @wdio
  Scenario: Element Screenshot of Featured for Article
    Given I set my screensize to desktop
    When I visit "/investor-behat-article"
     Then I take screenshot of element "#main-wrapper"

  @feature_glossary @wdio
  Scenario: Element Screenshot of Featured for Glossary
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/glossary/test-glossary-1"
   Then I take screenshot of element "#main-wrapper"

  @feature_landing @wdio
  Scenario: Element Screenshot of Featured for Landing
    Given I set my screensize to desktop
    When I visit "/behat-landing"
     Then I take screenshot of element "#main-wrapper"

 @feature_alerts @wdio
  Scenario: Element Screenshot of Featured for Alerts
    Given I set my screensize to desktop
    When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/test-news"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot and add text "feature_alerts" to filename

 @feature_bulletins @wdio
  Scenario: Full Screenshot of Featured for Bulletins
    Given I set my screensize to desktop
    When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-bulletins/test-news"
      And I remove "#twitter-widget-0"
    Then I take full page screenshot and add text "feature_bulletins" to filename

 @feature_publication @wdio
  Scenario: Full Screenshot of Featured for Publication
    Given I set my screensize to desktop
    When I visit "/test-publication"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot and add text "feature_publication" to filename
