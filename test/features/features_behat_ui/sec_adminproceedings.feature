Feature: Administrative Proceedings List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Admin Proceedings Pages Screenshot
  Given  "rulemaking_index" terms:
      | name     |
      | ui-98-po |
    And "customized_comment_form" content:
      | title         | field_display_title | status |
      | Comment behat | Display Title for 1 | 1      |
    And I create "media" of type "link":
      | name           | field_media_entity_link | status |
      | Behat External | http://google.com       | 1      |
      | Behat Internal | https://sec.lndo.site/  | 1      |
    And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body      | field_display_title      | field_publish_date  | field_release_number |
      | Press Release        | Credit Ratings                | published        | First New PR  | 1      | body text | First New Press Release  | 2018-09-11 12:00:00 | 2018-12              |
    And "release" content:
      | title                      | field_release_type         | field_release_number | field_respondents | body                    | moderation_state | field_publish_date  | status | field_comments_notice | field_see_also                 | field_submit_comments | field_comments_due_date | field_comments_received             | field_release_file_number |
      | Administrative Proceeding1 | Administrative Proceedings | 34-12345, 34-12346   | Allen             | this is Allen detail    | published        | 2021-02-02 12:00:00 | 1      | Note1                 | Behat External, Behat Internal | Comment behat         |                         |                                     | ui-98-po                  |
      | Administrative Proceeding2 | Administrative Proceedings | 34-34567             | Caroline          | this is Caroline detail | published        | 2021-05-03 12:00:00 | 1      |                       |                                |                       | 2022-03-23              | Go To SEC.gov - https://www.sec.gov | ui-98-po                  |
  Then I take a screenshot on "sec" using "adminproceedings.feature" file with "@adminproceedinglist" tag
    And I take a screenshot on "sec" using "adminproceedings.feature" file with "@adminproceedingnode" tag
    And I take a screenshot on "sec" using "adminproceedings.feature" file with "@adminproceedingtaxonomy" tag
