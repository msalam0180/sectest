Feature: Styles on Administrative Proceedings
  As a site visitor, I want to be able to view Administrative Proceedings List and Node page
  So that visitors to sec.gov can learn about admin proceedings

  @adminproceedinglist @wdio
  Scenario: Administrative Proceedings List Page
    Given I set my screensize to desktop
    When I visit "/litigation/admin"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @adminproceedingnode @wdio
  Scenario: Administrative Proceedings Node Page
    Given I set my screensize to desktop
    When I visit "/litigation/admin/administrative-proceeding1"
    Then I take screenshot of element "#content-wrapper"

  @adminproceedingtaxonomy @wdio
  Scenario: Administrative Proceedings Taxonomy Page
    Given I set my screensize to desktop
    When I visit "/litigation/apdocuments/ui-98-po"
    Then I take screenshot of element "#content-wrapper"