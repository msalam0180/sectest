Feature: SEC Views - Pages, Blocks, and Feeds
  As a Site Visitor, the user should be able to view information as available on SEC.gov

@ui @api @javascript @wdio
Scenario: Data List Page View With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title            | body | field_media_file_upload | field_description_abstract | field_contact_name | field_contact_email | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify Data View | test | Behat Test File         | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Corporation Finance           | 123-KO               | Securities Act of 1933 |
      | Verify Data View |      | Behat Test File         | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@data_list_page" tag

@ui @api @javascript @wdio
Scenario: Market Structure View With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title                   | body | field_media_file_upload | field_article_sub_type_secart | field_description_abstract | field_contact_name | field_contact_email | field_display_title                   | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_tags | field_act              |
      | Verify Market Structure | body | Behat Test File         | Market Structure              | random text                | John Doe           | johndoe@gmail.com   | Data and sub type as Market Structure | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Agency-Wide                   | 123-KO               | data       | Securities Act of 1933 |
      | Verify Market Structure |      | Behat Test File         | Market Structure              | random text                | John Doe           | johndoe@gmail.com   | Data and sub type as Market Structure | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Agency-Wide                   | 123-KO               | data       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@market_structure_page" tag

@ui @api @javascript @wdio
Scenario: Reports and Publications With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_article_sub_type_secart | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | test | Behat Test File         | Annual Reports                | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Reports and Publications      | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Annual Reports                | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Reports and Publications      | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@reports_publications_page" tag

@ui @api @javascript @wdio
Scenario: Forms With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@forms_page" tag

@ui @api @javascript @wdio
Scenario: Fast-Answers With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@fast_answers_page" tag

@ui @api @javascript @wdio
Scenario: Investor Alerts Page With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | test | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@investor_alerts_page" tag

@ui @api @javascript @wdio
Scenario: Corpfin Announcements Page With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@corpfin_announcement_page" tag

@ui @api @javascript @wdio
Scenario: Amicus Brief List and Node Page With and Without File Attachment
  Given I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | moderation_state | title             | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
      | Amicus Brief                  | Behat File              | published        | Behat for Article | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      | 2019-07-25T17:00:00 |
      | Amicus Brief                  |                         | published        | Behat for Article | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details      |                     |
  Then I take a screenshot on "sec" using "views.feature" file with "@amicusbriefs_page" tag
  Then I take a screenshot on "sec" using "views.feature" file with "@amicusbriefs_nodepage" tag

@ui @api @javascript @wdio
Scenario: Appellate Brief List and Node Page With and Without File Attachment
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | moderation_state | title             | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
      | Appellate Brief               | Behat File              | published        | Behat for Article | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      | 2019-07-25T17:00:00 |
      | Appellate Brief               |                         | published        | Behat for Article | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details      |                     |
  Then I take a screenshot on "sec" using "views.feature" file with "@appellatebriefs_page" tag
  Then I take a screenshot on "sec" using "views.feature" file with "@appellatebriefs_nodepage" tag
