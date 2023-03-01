Feature: SEC Delinquent filing Page
  As a Site Visitor, the user should be able to view delinquent releases

  @delinquent_list @wdio
  Scenario: Delinquent View Page For Releases
    Given I visit "/divisions/enforce/delinquent/delinqindex"
    When I set my screensize to desktop
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot
