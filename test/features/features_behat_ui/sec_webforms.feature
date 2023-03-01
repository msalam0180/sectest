Feature: Webforms
  As a Site Visitor, the user should be able to complete and submit published webforms available on SEC.gov

@ui @api @javascript @wdio
Scenario: SEC IM Webform Screenshot
  Given I am on "/forms/im-no-action"
  Then I take a screenshot on "sec" using "webforms.feature" file with "@im_noaction_webform" tag

@ui @api @javascript @wdio
Scenario: SEC CF IEW Webform Screenshot
  Given I am on "/forms/corp_fin_noaction"
  Then I take a screenshot on "sec" using "webforms.feature" file with "@cf_noaction_IEW_webform" tag

@ui @api @javascript @wdio
Scenario: SEC Non-Competitive Hiring Authorities Webform Screenshot
  Given I am on "/forms/schedaselectiveplacement"
  Then I take a screenshot on "sec" using "webforms.feature" file with "@noncomp_webform" tag
