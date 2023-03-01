Feature: ALJ Orders List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: ALJ Orders Pages Screenshot
  Given "customized_comment_form" content:
      | title         | field_display_title | status |
      | Comment behat | Display Title for 1 | 1      |
    And I create "media" of type "link":
      | name           | field_media_entity_link | status |
      | Behat External | http://google.com       | 1      |
      | Behat Internal | https://sec.lndo.site/  | 1      |
    And "release" content:
      | title | field_release_type | field_comments_notice | field_release_number | moderation_state | field_publish_date  | status | field_respondents | field_see_also                 | field_submit_comments |
      | Test  | ALJ Orders         | Note                  | 2-12312, 1-32, 4-523 | published        | 2021-02-02 12:00:00 | 1      | Frank             | Behat External, Behat Internal | Comment behat         |
  Then I take a screenshot on "sec" using "aljorders.feature" file with "@aljorderslist" tag
    And I take a screenshot on "sec" using "aljorders.feature" file with "@aljordersnode " tag
