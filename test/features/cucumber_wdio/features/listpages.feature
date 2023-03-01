Feature: SEC List Pages
  As a Site Visitor, the user should be able to navigate to the list pages available on SEC.gov

  @pr_search @wdio
  Scenario: PR Search
    Given I set my screensize to desktop
    When I visit "/news/pressreleases"
       And I hide "#global-navigation"
       And I hide "#global-header"
       And I hide "#global-search-form > fieldset > div > label"
       And I hide "#block-globalfooterstayconnectedfooter"
       And I hide "#page > footer"
       And I hide "#page > footer > div.page-footer-top"
       And I hide "#page > footer > div.page-footer-cols"
       And I hide "body > a.back-to-top"
    Then I take full page screenshot
    When I visit "/news/pressreleases?aId=&combine=th+new+press&year=All&month=All"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot
    When I visit "/news/pressreleases?aId=&combine=2018-1&year=All&month=All"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
    Then I take full page screenshot
    When I visit "/news/pressreleases?aId=&combine=&year=2019&month=All"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
    Then I take full page screenshot
    When I visit "/news/pressreleases?aId=&combine=&year=2018&month=6"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
    Then I take full page screenshot
    When I visit "/news/pressreleases?aId=&combine=Third&year=2018&month=6"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
    Then I take full page screenshot
