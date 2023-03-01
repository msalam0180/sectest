Feature: Screenshots Of Alerts And Bulletins

  @alerts @wdio
  Scenario: Element Screenshot Of Alert
    Given I set my screensize to desktop
      And I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/investor"
    Then I take screenshot of element "#main-wrapper"

  @search_alerts @wdio
  Scenario: Window Screenshot Of Alert Search Results
    Given I set my screensize to desktop
      And I visit "/search?keys=Investor%20Behat%20Test%20Alert"
    Then I take current window screenshot and add text "alert_search" to filename

  @bulletins @wdio
  Scenario: Element Screenshot Of Bulletin Page
    Given I set my screensize to desktop
      And I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    Then I take screenshot of element "#main-wrapper"

  @alerts_breadcrumb @wdio
  Scenario: Element Screenshot Of Default Alert Breadcrumb
    Given I set my screensize to desktop
    When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/news-alert-1"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot
