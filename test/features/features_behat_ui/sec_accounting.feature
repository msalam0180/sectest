Feature: Accounting and Auditing List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Accounting and Auditing Pages Screenshot
  Given I create "media" of type "link":
      | name           | field_media_entity_link | status |
      | Behat External | http://google.com       | 1      |
      | Behat Internal | https://sec.lndo.site/  | 1      |
    And "release" content:
      | title | field_release_type | field_release_number    | moderation_state | field_publish_date  | status | field_respondents | field_see_also                 |
      | Test  | Stop Orders        | AAER-12312, 3-234, 1-33 | published        | 2021-02-02 12:00:00 | 1      | Frank             | Behat External, Behat Internal |
  Then I take a screenshot on "sec" using "accounting.feature" file with "@accountinglist" tag
