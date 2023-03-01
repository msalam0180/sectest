Feature: Capture Views -page, feeds, and blocks
  As a site visitor, I want to be able to view sec information
  So that visitors to sec.gov can learn

  @data_list_page @wdio
    Scenario: Data List Page View
    Given I set my screensize to desktop
    When I visit "/data"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @market_structure_page @wdio
    Scenario: Market Structure List Page View
    Given I set my screensize to desktop
    When I visit "/marketstructure/downloads.html"
    Then I take screenshot of element "#main-wrapper"

  @reports_publications_page @wdio
    Scenario: Reports and Publicationw List Page View
    Given I set my screensize to desktop
    When I visit "/reports"
    Then I take screenshot of element "#main-wrapper"

  @forms_page @wdio
    Scenario: Forms List Page View
    Given I set my screensize to desktop
    When I visit "/forms"
    Then I take screenshot of element "#main-wrapper"

  @fast_answers_page @wdio
    Scenario: Fast-Answers List Page View
    Given I set my screensize to desktop
    When I visit "/fast-answers"
    Then I take screenshot of element "#main-wrapper"

  @investor_alerts_page @wdio
    Scenario: Investor and Alerts Page View
    Given I set my screensize to desktop
    When I visit "/investor/alerts"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
    Then I take full page screenshot

  @corpfin_announcement_page @wdio
    Scenario: Corpfin Announcements Page View
    Given I set my screensize to desktop
    When I visit "/corpfin/announcements"
    Then I take screenshot of element "#main-wrapper"

  @amicusbriefs_page @wdio
    Scenario: Amicus Brief Page View
    Given I set my screensize to desktop
    When I visit "/litigation/amicusbriefs"
    Then I take screenshot of element "#main-wrapper"

  @amicusbriefs_nodepage @wdio
    Scenario: Amicus Brief Page View
    Given I set my screensize to desktop
    When I visit "/enforce/amicus-brief/behat-article"
    Then I take screenshot of element "#main-wrapper"

  @appellatebriefs_page @wdio
    Scenario: Appellate Brief Page View
    Given I set my screensize to desktop
    When I visit "/litigation/appellatebriefs"
    Then I take screenshot of element "#main-wrapper"

  @appellatebriefs_nodepage @wdio
    Scenario: Appellate Brief Node Page View
    Given I set my screensize to desktop
    When I visit "/enforce/appellate-brief/behat-article"
    Then I take screenshot of element "#main-wrapper"
