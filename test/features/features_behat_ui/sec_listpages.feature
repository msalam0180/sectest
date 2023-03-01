Feature: List Pages
  As a Site Visitor, the user should be able to view list pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Press Release List Page Search
  Given "news" content:
    | field_news_type_news | field_primary_division_office | moderation_state | title         | status | body                     | field_display_title      | field_publish_date  | field_release_number |
    | Press Release        | Agency-wide                   | published        | First New PR  | 1      | This is the first body.  | First New Press Release  | 2018-09-11 12:00:00 | 2018-123             |
    | Press Release        | Agency-wide                   | published        | Second New PR | 1      | This is the second body. | Second New Press Release | 2018-10-03 12:00:00 | 2018-170             |
    | Press Release        | Agency-wide                   | published        | Third New PR  | 1      | This is the third body.  | Third New Press Release  | 2018-06-05 12:00:00 | 2018-88              |
    | Press Release        | Agency-wide                   | published        | Fourth New PR | 1      | This is the fourth body. | Fourth New Press Release | 2018-06-25 12:00:00 | 2018-66              |
    | Press Release        | Agency-wide                   | published        | Fifth New PR  | 1      | This is the fifth body.  | Fifth New Press Release  | 2018-02-14 12:00:00 | 2018-43              |
    | Press Release        | Agency-wide                   | published        | Sixth New PR  | 1      | This is the sixth body.  | Sixth New Press Release  | 2019-03-15 12:00:00 | 2019-18              |
    | Press Release        | Agency-wide                   | published        | Seventh New PR| 1      | This is the seventh body.| Seventh New Press Release| 2019-04-17 12:00:00 | 2019-42              |
    | Press Release        | Agency-wide                   | published        | Eighth New PR | 1      | This is the eighth body. | Eighth New Press Release | 2019-06-30 12:00:00 | 2019-62              |
    | Press Release        | Agency-wide                   | published        | Ninth New PR  | 1      | This is the ninth body.  | Ninth New Press Release  | 2019-07-23 12:00:00 | 2019-68              |
  Then I take a screenshot on "sec" using "listpages.feature" file with "@pr_search" tag
