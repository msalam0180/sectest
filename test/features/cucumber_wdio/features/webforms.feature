Feature: SEC Webforms
  As a Site Visitor, the user should be able to complete published webforms available on SEC.gov

  @im_noaction_webform @wdio
  Scenario: IM No-Action Webform
    Given I set my screensize to desktop
    When I visit "/forms/im-no-action"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @cf_noaction_IEW_webform @wdio
  Scenario: CF IEW No-Action Webform
    Given I set my screensize to desktop
    When I visit "/forms/corp_fin_noaction"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @noncomp_webform @wdio
  Scenario: Non-Comp Hiring Authorities Webform
    Given I set my screensize to desktop
    When I visit "/forms/schedaselectiveplacement"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#block-globalfooterstayconnectedfooter"
      And I hide "#page > footer"
      And I hide "#page > footer > div.page-footer-top"
      And I hide "#page > footer > div.page-footer-cols"
      And I hide "body > a.back-to-top"
      And I hide "#addthis-icons > div > div"
    Then I take full page screenshot
