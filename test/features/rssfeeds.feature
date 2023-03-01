Feature: RSS Feeds
As a user of the site
I want to be able to subscribe to rss in Drupal
So that I can be aware of the latest content on SEC.gov

@api @javascript
Scenario: View Academic Publications RSS
  Given "secarticle" content:
    | title             | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office |
    | Behat RSS ACPub 1 | Behat RSS Test 1    | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Economic and Risk Analysis    |
    | Behat RSS ACPub 2 | Behat RSS Test 2    | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Economic and Risk Analysis    |
    | Behat RSS ACPub 3 | Behat RSS Test 3    | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Academic Publications         | Economic and Risk Analysis    |
  When I am on "/rss/dera/academic-publications"
  Then I should see valid XML
    And I should see the text "Behat RSS Test 1"
    And I should see the text "The Car is Black"
    And I should not see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should see the text "<pubDate>Tue, 18 Jun 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "Behat RSS Test 2"
    And I should not see the text "The Car is Blue"
    And I should see the text "Behat RSS Test 3"
    And I should see the text "The Car is Beige"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate>"

@api @javascript
Scenario: View Data RSS
  Given "secarticle" content:
    | title            | field_display_title | body           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart |
    | Behat RSS Data 1 | Behat RSS Test 1    | This is body 1 | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Acquisitions                  | Data-BrokerDealers            |
    | Behat RSS Data 2 | Behat RSS Test 2    | This is body 2 | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Data                          | Enforcement                   | Data-Enforcement              |
    | Behat RSS Data 3 | Behat RSS Test 3    | This is body 3 | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Data                          | Corporation Finance           | Data-MarketStructure          |
  When I am on "/rss/data"
  Then I should see valid XML
    And I should see the text "Behat RSS Test 1"
    And I should see the text "This is body 1"
    And I should not see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should see the text "<pubDate>Tue, 18 Jun 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "Behat RSS Test 2"
    And I should not see the text "This is body 2"
    And I should see the text "Behat RSS Test 3"
    And I should see the text "This is body 3"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate"

@api @javascript
Scenario: View EDGAR RSS
  Given "secarticle" content:
    | title              | field_display_title    | moderation_state | status | field_article_type_secarticle | field_primary_division_office | field_tags | body                     | field_publish_date  |
    | RSS EDGAR Filer  0 | RSS EDGAR Filer Test 0 | published        | 1      | Announcement                  | Information Technology        | filergroup | This is the first body   | 2018-01-01 12:00:00 |
    | RSS EDGAR Filer  1 | RSS EDGAR Filer Test 1 | published        | 1      | Announcement                  | Information Technology        | filergroup | This is the second body  | 2018-02-01 12:00:00 |
    | RSS EDGAR Filer  2 | RSS EDGAR Filer Test 2 | published        | 1      | Announcement                  | Information Technology        | filergroup | This is the third body   | 2018-03-01 12:00:00 |
    | RSS EDGAR Filer  3 | RSS EDGAR Filer Test 3 | published        | 1      | Announcement                  | Information Technology        | filergroup | This is the fourth body  | 2018-04-01 12:00:00 |
    | RSS EDGAR Filer  4 | RSS EDGAR Filer Test 4 | draft            | 0      | Announcement                  | Information Technology        | filergroup | This is the fifth body   | 2018-05-01 12:00:00 |
    | RSS EDGAR Filer  5 | RSS EDGAR Filer Test 5 | published        | 1      | Announcement                  | Information Technology        | filergroup | This is the sixth body   | 2018-06-01 12:00:00 |
    | RSS EDGAR Filer  6 | RSS EDGAR Filer Test 6 | published        | 1      | Other                         | Information Technology        | filergroup | This is the seventh body | 2018-07-01 12:00:00 |
  When I am on "/article/announcement/filergroup.rss"
  Then I should see valid XML
    #Then I should see "RSS EDGAR Filer 0" in the "body > pre" element
    And I should see the text "RSS EDGAR Filer Test 0"
    And I should see the text "<pubDate>Mon, 01 Jan 2018 12:00:00 -0500</pubDate>"
    And I should see the text "RSS EDGAR Filer Test 1"
    And I should see the text "RSS EDGAR Filer Test 2"
    And I should see the text "RSS EDGAR Filer Test 3"
    And I should not see the text "RSS EDGAR Filer Test 4"
    And I should see the text "RSS EDGAR Filer Test 5"
    And I should see the text "/oit/announcement/rss-edgar-filer-5"
  But I should not see the text "RSS EDGAR Filer Test 6"

@api @javascript
Scenario: View Fast Answers RSS
  Given "secarticle" content:
    | title          | field_display_title | body           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat RSS FA 1 | Behat RSS Test 1    | This is body 1 | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat RSS FA 2 | Behat RSS Test 2    | This is body 2 | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Fast Answers                  | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat RSS FA 3 | Behat RSS Test 3    | This is body 3 | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Fast Answers                  | Corporation Finance           | Data-MarketStructure          | Quote Life Data Series         |
  When I am on "/rss/fast-answers"
  Then I should see valid XML
    And I should see the text "Behat RSS Test 1"
    And I should see the text "<pubDate>Tue, 18 Jun 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Behat RSS Test 2"
    And I should see the text "Behat RSS Test 3"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate>"

@api @javascript
Scenario: View FOIA-FRD RSS
  Given "secarticle" content:
    | title             | field_display_title                            | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_tags    |
    | Behat RSS ACPub 1 | <em>Behat</em> <strong>RSS</strong> Test 1 & 2 | The Car is Black               | 2019-01-17T17:00:00 | 2019-01-17T17:01:00 | 1      | Academic Publications         | Economic and Risk Analysis    | foiafreqdocs  |
    | Behat RSS ACPub 2 | Behat RSS Test 2                               | The Car is Blue                | 2019-02-13T15:00:00 | 2019-02-15T16:00:00 | 0      | Academic Publications         | Economic and Risk Analysis    | foiafreqdocs  |
    | Behat RSS ACPub 3 | <s>Behat</s> <u>RSS</u> <br>Test 3$%4</br>     | The Car is Beige               | 2019-03-15T11:00:00 |                     | 1      | Academic Publications         | Economic and Risk Analysis    | foia-freq-doc |
    And "news" content:
    | field_news_type_news | field_primary_division_office | title         | status | body                     | field_display_title                                          | field_publish_date  | field_date          | field_tags    |
    | Press Release        | Agency-wide                   | First New PR  | 1      | This is the first body.  | <strong>First</strong> <s>New</s> <em>Press Release</em>     | 2019-04-17T17:00:00 | 2019-04-18T17:01:00 | foiafreqdocs  |
    | Press Release        | Agency-wide                   | Second New PR | 0      | This is the second body. | Second New Press Release                                     | 2019-05-13T15:00:00 | 2019-05-15T16:00:00 | foiafreqdocs  |
    | Press Release        | Agency-wide                   | Third New PR  | 1      | This is the third body.  | <sup>Third</sup> <strong>New</strong> <br>Press Release</br> | 2019-06-15T11:00:00 |                     | foia-freq-doc |
    And "file" content:
    | title           | field_display_title | field_primary_division_office | field_publish_date  | status | field_tags   |
    | BEHAT Test File | Test static file    | Credit Ratings                | 2019-07-17T17:00:00 | 1      | foiafreqdocs |
    And "link" content:
    | title           | field_description_abstract | field_url                          | status | field_publish_date  | field_tags   |
    | Behat Page Link | Site Link Description      | Click Here - http://www.google.com | 1      | 2019-08-17T17:00:00 | foiafreqdocs |
  When I am on "/rss/foia-freq-docs"
  Then I should see valid XML
    And I should see the text "Click Here"
    And I should see the text "Site Link Description"
    And I should see the text "<pubDate>Sat, 17 Aug 2019 17:00:00 -0400</pubDate>"
    And I should see the text "Test static file"
    And I should see the text "<pubDate>Wed, 17 Jul 2019 17:00:00 -0400</pubDate>"
    And I should see the text "Third New Press Release"
    And I should see the text "This is the third body"
    And I should see the text "<pubDate>Sat, 15 Jun 2019 11:00:00 -0400</pubDate>"
    And I should see the text "First New Press Release"
    And I should see the text "This is the first body"
    And I should see the text "<pubDate>Thu, 18 Apr 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "<pubDate>Wed, 17 Apr 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Second New Press Release"
    And I should not see the text "This is the second body"
    And I should see the text "Behat RSS Test 3$%4"
    And I should see the text "<pubDate>Fri, 15 Mar 2019 11:00:00 -0400</pubDate>"
    And I should see the text "Behat RSS Test 1 &amp; 2"
    And I should see the text "<pubDate>Thu, 17 Jan 2019 17:01:00 -0500</pubDate>"
    And I should not see the text "<pubDate>Thu, 17 Apr 2019 17:00:00 -0500</pubDate>"
    And I should not see the text "Behat RSS Test 2"

@api @javascript
Scenario: View Forms RSS
  Given "secarticle" content:
    | title            | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience      | field_act                       |
    | Behat RSS Form 1 | Behat RSS Test 1    | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers | Dodd-Frank Act of 2010          |
    | Behat RSS Form 2 | Behat RSS Test 2    | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies   | Investment Advisers Act of 1940 |
    | Behat RSS Form 3 | Behat RSS Test 3    | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Forms                         | Agency-Wide                   | 123-KO               | Auditors            | Securities Act of 1933          |
  When I am on "/rss/forms"
  Then I should see valid XML
    And I should see the text "Behat RSS Test 1"
    And I should see the text "<pubDate>Tue, 18 Jun 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Behat RSS Test 2"
    And I should see "Behat RSS Test 3"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate>"

@api @javascript
Scenario: View Market Structure Data RSS
  Given "secarticle" content:
    | title           | field_display_title | body           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_article_sub_type_secart | field_list_page_det_secarticle |
    | Behat RSS MSD 1 | Behat RSS Test 1    | This is body 1 | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Acquisitions                  | Data-MarketStructure          | Market Activity Data Series    |
    | Behat RSS MSD 2 | Behat RSS Test 2    | This is body 2 | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Data                          | Enforcement                   | Data-MarketStructure          | Quote Life Data Series         |
    | Behat RSS MSD 3 | Behat RSS Test 3    | This is body 3 | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Data                          | Corporation Finance           | Data-MarketStructure          | Quote Life Data Series         |
  When I am on "/rss/marketstructure/data"
  Then I should see valid XML
    And I should see the text "Behat RSS Test 1"
    And I should see the text "This is body 1"
    And I should see the text "<pubDate>Tue, 18 Jun 2019 17:01:00 -0400</pubDate>"
    And I should not see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Behat RSS Test 2"
    And I should not see the text "This is body 2"
    And I should see the text "Behat RSS Test 3"
    And I should see the text "This is body 3"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate>"

@api @javascript
Scenario: View Press Releases RSS
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title           | status | field_description_abstract            | field_display_title                 | field_publish_date  | field_speaker_name_and_title     | moderation_state | field_release_number | body                              |
    | Press Release        | Agency-wide                   | RSS PR Filer  0 | 1      | Press Release by Commissioner Michael | <u><em>RSS PR Filer Test 0</em></u> | 2018-12-11 12:00:00 | Commissioner Michael S. Piwowar  | published        | RN_2018_12_11        | This is body 0                    |
    | Press Release        | Agency-wide                   | RSS PR Filer  1 | 1      |                                       | <h2>RSS PR Filer Test 1</h2>        | 2018-12-10 12:00:00 | Chairman Jay Clayton             | published        | RN_2018_12_10        | Commissioner Jay Clayton to speak |
    | Press Release        | Agency-wide                   | RSS PR Filer  2 | 1      | Press Release by Deputy Chairman Kara | RSS PR Filer <br>Test 2</br>        | 2017-06-13 16:00:00 | Commissioner Kara M. Stein       | draft            | RN_2017_06           | This is body 2                    |
    | Press Release        | Agency-wide                   | RSS PR Filer  3 | 1      | Press Release by Mary Jo White        | RSS PR Filer Test 3%@#              | 2019-09-11 18:08:00 | Chair Mary Jo White              | published        | RN_2019_09           | This is body 3                    |
    | Press Release        | Agency-wide                   | RSS PR Filer  4 | 1      |                                       | RSS PR Filer Test 4                 | 2017-02-11 20:09:00 | Commissioner Daniel M. Gallagher | published        | RN_2017_02_11        | Mr. Gallagher to speak            |
  When I am on "/news/pressreleases.rss"
  Then I should see valid XML
    And I should see the text "RSS PR Filer Test 3%@#"
    And I should see "Press Release by Mary Jo White"
    And I should see the text "Wed, 11 Sep 2019 18:08:00 -0400"
    And I should see the text "RSS PR Filer Test 0"
    And I should see "Press Release by Commissioner Michael"
    And I should see the text "Tue, 11 Dec 2018 12:00:00 -0500"
    And I should see the text "RSS PR Filer Test 4"
    And I should see the text "Mr. Gallagher to speak"
    And I should see the text "Sat, 11 Feb 2017 20:09:00 -0500"
    And I should see the text "RSS PR Filer Test 1"
    And I should see the text "Commissioner Jay Clayton to speak"
    And I should see the text "Mon, 10 Dec 2018 12:00:00 -0500"
  But I should not see the text "RSS PR Filer Test 2"
    And I should not see the text "Press Release by Deputy Chairman Kara"

@api @javascript
Scenario: View Statements RSS
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title           | status | field_description_abstract               | field_display_title | field_publish_date  | field_speaker_name_and_title     | moderation_state |
    | Statement            | Agency-wide                   | RSS PS Filer  0 | 1      | Statement by Commissioner Michael        | RSS PS Filer Test 0 | 2018-12-11 12:00:00 | Commissioner Michael S. Piwowar  | published        |
    | Statement            | Agency-wide                   | RSS PS Filer  1 | 1      | Statement by Chairman Jay                | RSS PS Filer Test 1 | 2018-12-10 12:00:00 | Chairman Jay Clayton             | published        |
    | Statement            | Agency-wide                   | RSS PS Filer  2 | 1      | Statement by Deputy Chairman Kara        | RSS PS Filer Test 2 | 2017-06-13 16:00:00 | Commissioner Kara M. Stein       | draft            |
    | Statement            | Agency-wide                   | RSS PS Filer  3 | 1      | Statement by Mary Jo White               | RSS PS Filer Test 3 | 2019-09-11 18:08:00 | Chair Mary Jo White              | published        |
    | Statement            | Agency-wide                   | RSS PS Filer  4 | 1      | Statement by Daniel M. Gallagher         | RSS PS Filer Test 4 | 2017-02-11 20:09:00 | Commissioner Daniel M. Gallagher | published        |
  When I am on "/news/statements.rss"
  Then I should see valid XML
    And I should see the text "RSS PS Filer Test 3"
    And I should see "Statement by Mary Jo White"
    And I should see the text "Wed, 11 Sep 2019 18:08:00 -0400"
    And I should see the text "RSS PS Filer Test 0"
    And I should see "Statement by Commissioner Michael"
    And I should see the text "Tue, 11 Dec 2018 12:00:00 -0500"
    And I should see the text "RSS PS Filer Test 4"
    And I should see "Statement by Daniel M. Gallagher"
    And I should see the text "Sat, 11 Feb 2017 20:09:00 -0500"
    And I should see the text "RSS PS Filer Test 1"
    And I should see the text "Statement by Chairman Jay"
    And I should see the text "Mon, 10 Dec 2018 12:00:00 -0500"
  But I should not see the text "RSS PS Filer Test 2"
    And I should not see the text "Statement by Deputy Chairman Kara"

@api @javascript
Scenario: View Speeches RSS
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title               | status | field_description_abstract     | field_display_title                      | field_publish_date  | field_speaker_name_and_title     | moderation_state |
    | Speech               | Agency-wide                   | RSS Speech Filer  0 | 1      | Speech by Commissioner Michael | RSS Speech Filer Test 0                  | 2018-12-11 12:00:00 | Commissioner Michael S. Piwowar  | published        |
    | Speech               | Agency-wide                   | RSS Speech Filer  1 | 1      | Speech by Chairman Jay         | <strong>RSS Speech Filer Test 1</strong> | 2018-12-10 12:00:00 | Chairman Jay Clayton             | published        |
    | Speech               | Agency-wide                   | RSS Speech Filer  2 | 1      | Speech by Deputy Chairman Kara | <u><em>RSS Speech Filer Test 2</em></u>  | 2017-06-13 16:00:00 | Commissioner Kara M. Stein       | draft            |
    | Speech               | Agency-wide                   | RSS Speech Filer  3 | 1      | Speech by Mary Jo White        | <h2>RSS Speech Filer Test 3</h2>         | 2019-09-11 18:08:00 | Chair Mary Jo White              | published        |
    | Speech               | Agency-wide                   | RSS Speech Filer  4 | 1      | Speech by Daniel M. Gallagher  | RSS Speech Filer Test 4 & 5              | 2017-02-11 20:09:00 | Commissioner Daniel M. Gallagher | published        |
  When I am on "/news/speeches.rss"
  Then I should see valid XML
    And I should see the text "RSS Speech Filer Test 3"
    And I should see "Speech by Mary Jo White"
    And I should see the text "Wed, 11 Sep 2019 18:08:00 -0400"
    And I should see the text "RSS Speech Filer Test 0"
    And I should see "Speech by Commissioner Michael"
    And I should see the text "Tue, 11 Dec 2018 12:00:00 -0500"
    And I should see the text "RSS Speech Filer Test 4 &amp; 5"
    And I should see "Speech by Daniel M. Gallagher"
    And I should see the text "Sat, 11 Feb 2017 20:09:00 -0500"
    And I should see the text "RSS Speech Filer Test 1"
    And I should see the text "Speech by Chairman Jay"
    And I should see the text "Mon, 10 Dec 2018 12:00:00 -0500"
  But I should not see the text "RSS Speech Filer Test 2"
    And I should not see the text "Speech by Deputy Chairman Kara"

@api @javascript
Scenario: View Testimony RSS
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title                  | status | field_description_abstract        | field_display_title        | field_publish_date  | field_speaker_name_and_title    | moderation_state |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  0 | 1      | Testimony by Commissioner Michael | RSS Testimony Filer Test 0 | 2018-12-11 12:00:00 | Commissioner Michael S. Piwowar | published        |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  1 | 1      | Testimony by Chairman Jay         | RSS Testimony Filer Test 1 | 2018-12-10 12:00:00 | Chairman Jay Clayton            | published        |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  2 | 1      | Testimony by Deputy Chairman Kara | RSS Testimony Filer Test 2 | 2017-06-13 16:00:00 | Commissioner Kara M. Stein      | draft            |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  3 | 1      | Testimony by Mary Jo White        | RSS Testimony Filer Test 3 | 2019-09-11 18:08:00 | Chair Mary Jo White             | published        |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  4 | 1      | Testimony by Michael Piwowar      | RSS Testimony Filer Test 4 | 2017-02-11 20:09:00 | Commissioner Michael S. Piwowar | published        |
  When I am on "/news/testimony.rss"
  Then I should see valid XML
    And I should see the text "RSS Testimony Filer Test 3"
    And I should see "Testimony by Mary Jo White"
    And I should see the text "Wed, 11 Sep 2019 18:08:00 -0400"
    And I should see the text "RSS Testimony Filer Test 0"
    And I should see "Testimony by Commissioner Michael"
    And I should see the text "Tue, 11 Dec 2018 12:00:00 -0500"
    And I should see the text "RSS Testimony Filer Test 4"
    And I should see "Testimony by Michael Piwowar"
    And I should see the text "Sat, 11 Feb 2017 20:09:00 -0500"
    And I should see the text "RSS Testimony Filer Test 1"
    And I should see the text "Testimony by Chairman Jay"
    And I should see the text "Mon, 10 Dec 2018 12:00:00 -0500"
  But I should not see the text "RSS Testimony Filer Test 2"
    And I should not see the text "Testimony by Deputy Chairman Kara"

@api @javascript
Scenario: View Speeches and Statements RSS
  Given "news" content:
    | field_news_type_news | field_primary_division_office | title                         | status | field_description_abstract               | field_display_title               | field_publish_date  | field_speaker_name_and_title    | moderation_state |
    | Speech               | Agency-wide                   | RSS Speech Filer  0           | 1      | Speech by Commissioner Michael           | RSS Speech Filer Test 0           | 2018-12-11 12:00:00 | Commissioner Michael S. Piwowar | published        |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  1        | 1      | Testimony by Chairman Jay                | RSS Testimony Filer Test 1        | 2018-12-10 12:00:00 | Chairman Jay Clayton            | published        |
    | Statement            | Agency-wide                   | RSS Statement Filer  2        | 1      | Statement by Deputy Chairman Kara        | RSS Statement Filer Test 2        | 2017-06-13 16:00:00 | Commissioner Kara M. Stein      | draft            |
    | Testimony            | Agency-wide                   | RSS Testimony Filer  3        | 1      | Testimony by Mary Jo White               | RSS Testimony Filer Test 3        | 2019-09-11 18:08:00 | Chair Mary Jo White             | published        |
    | Speech               | Agency-wide                   | RSS Speech Filer  4           | 1      | Speech by Michael Piwowar                | RSS Speech Filer Test 4           | 2017-02-11 20:09:00 | Commissioner Michael S. Piwowar | published        |
  When I am on "news/speeches-statements.rss"
  Then I should see valid XML
    And I should see the text "RSS Testimony Filer Test 3"
    And I should see "Testimony by Mary Jo White"
    And I should see the text "Wed, 11 Sep 2019 18:08:00 -0400"
    And I should see the text "RSS Speech Filer Test 0"
    And I should see "Speech by Commissioner Michael"
    And I should see the text "Tue, 11 Dec 2018 12:00:00 -0500"
    And I should see the text "RSS Speech Filer Test 4"
    And I should see "Speech by Michael Piwowar"
    And I should see the text "Sat, 11 Feb 2017 20:09:00 -0500"
    And I should see the text "RSS Testimony Filer Test 1"
    And I should see the text "Testimony by Chairman Jay"
    And I should see the text "Mon, 10 Dec 2018 12:00:00 -0500"
  But I should not see the text "RSS Statement Filer Test 2"
    And I should not see the text "Statement by Deputy Chairman Kara"

@api @javascript
Scenario: Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                                  | field_tags             | field_display_title                                                                    | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 1 | Boston Regional Office | Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 2 | Boston Regional Office | Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/article/bro.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Boston Regional Office tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                         | field_tags    | field_display_title                                                           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 1 | foia-freq-doc | Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 2 | foia-freq-doc | Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 1  | foiafreqdocs  | Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 1  | Some random text               | 2019-06-18T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 2  | foiafreqdocs  | Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 2  | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/article/foia-freq-doc.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with foia-freq-doc tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"
    And I should see the text "Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with foiafreqdocs tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with fort worth office tag appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                             | field_tags        | field_display_title                                                               | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with fort worth office tag appears in the RSS Feed 1 | fort worth office | Verify Academic Publications with fort worth office tag appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with fort worth office tag appears in the RSS Feed 2 | fort worth office | Verify Academic Publications with fort worth office tag appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/article/fwro.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with fort worth office tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with fort worth office tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Los Angeles office tag appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                              | field_tags         | field_display_title                                                                | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 1 | Los Angeles office | Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 2 | Los Angeles office | Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/article/laro.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Los Angeles office tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                                         | field_tags                    | field_display_title                                                                           | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 1 | San Francisco Regional Office | Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 2 | San Francisco Regional Office | Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/article/sfro.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                                                      | field_display_title                                                                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed 1 | Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed 2 | Verify Academic Publications with San Francisco Regional Office tag appears in the RSS Feed 2              | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/corpfin/article/announcement.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Corporation Finance as Primary Division/Office appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                                                                          | field_display_title                                                                                                            | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office           | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 1 | Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 2 | Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/ocie/article/announcement.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Compliance Inspections and Examinations as Primary Division/Office appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed
  Given "secarticle" content:
    | title                                                                                                                      | field_tags | field_display_title                                                                                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 1 | filergroup | Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Financial Management          | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 2 | filergroup | Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Financial Management          | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/ofm/article/announcement/filergroup.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with filegroup tag and Financial Management Primary Division/Office appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed
  Given "secarticle" content:
    | title                                                                                                          | field_display_title                                                                                            | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 1 | Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Inspector General             | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 2 | Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Inspector General             | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/oig/article/reportspubs.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"
  When I am on "/rss/about/oig/oignews.xml"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Inspector General Primary Division/Office appears in the OIG NEWS RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed
  Given "secarticle" content:
    | title                                                                                                                             | field_display_title                                                                                                               | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed 1 | Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Economic and Risk Analysis    | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed 2 | Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Economic and Risk Analysis    | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/rss/dera/academic-publications-querylist"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Economic and Risk Analysis Primary Division/Office appears in the DERA Academic Pubs RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed
  Given "secarticle" content:
    | title                                                                                                                                          | field_display_title                                                                                                                            | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office           | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 1 | Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 2 | Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/rss/ocie/ocie-announcements"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Compliance Inspections and Examinations Primary Division/Office appears in the OCIE Announcements RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed
  Given "secarticle" content:
    | title                                                                                                      | field_tags               | field_display_title                                                                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 1 | OIG Investigative Report | Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 2 | OIG Investigative Report | Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/rss/oiginvestigativereportsquerymodule"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with OIG Investigative Report tag appears in the OIG Investigative RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed
  Given "secarticle" content:
    | title                                                                                                    | field_tags             | field_display_title                                                                                      | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 1 | oiginvestigativereport | Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 2 | oiginvestigativereport | Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/rss/oiginvestigativereportsquerymodule"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with oiginvestigativereport tag appears in the OIG Investigative RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications appears in the RSS Feed
  Given "secarticle" content:
    | title                                                  | field_display_title                                    | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience      | field_act                       |
    | Verify Academic Publications appears in the RSS Feed 1 | Verify Academic Publications appears in the RSS Feed 1 | The Car is Black               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Agency-Wide                   | A-BNB                | Investment Advisers | Dodd-Frank Act of 2010          |
    | Verify Academic Publications appears in the RSS Feed 2 | Verify Academic Publications appears in the RSS Feed 2 | The Car is Blue                | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Agency-Wide                   | VZ987                | Clearing Agencies   | Investment Advisers Act of 1940 |
    | Verify Academic Publications appears in the RSS Feed 3 | Verify Academic Publications appears in the RSS Feed 3 | The Car is Beige               | 2019-08-15T11:00:00 |                     | 1      | Academic Publications         | Agency-Wide                   | 123-KO               | Auditors            | Securities Act of 1933          |
  When I am on "/article/academic-publications.rss"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications appears in the RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications appears in the RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"
    And I should see the text "Verify Academic Publications appears in the RSS Feed 3"
    And I should see the text "<pubDate>Thu, 15 Aug 2019 11:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed
  Given "secarticle" content:
    | title                                                                                                           | field_display_title                                                                                             | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 1 | Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 1 | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Academic Publications         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
    | Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 2 | Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 2 | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 0      | Academic Publications         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am on "/rss/corpfin/corpfin-announcements"
  Then I should see valid XML
    And I should see the text "Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 1"
    And I should see the text "<pubDate>Mon, 17 Jun 2019 17:00:00 -0400</pubDate>"
    And I should not see the text "Verify Academic Publications with Corporation Finance Primary Division/Office appears in the CORPFIN RSS Feed 2"
    And I should not see the text "<pubDate>Mon, 13 Jul 2019 15:00:00 -0400</pubDate>"

@api @javascript
Scenario: Verify GUID Is Unique In RSS Feed For Article
  Given "secarticle" content:
    | uuid | title      | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office           | field_release_number | field_audience | field_act              | field_tags                    | field_article_sub_type_secart |
    | 111  | Behat Test | Behat Test 111      | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Contact Information           | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 112  | Behat Test | Behat Test 112      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Contact Information           | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 115  | Behat Test | Behat Test 115      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | International Affairs                   | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 116  | Behat Test | Behat Test 116      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | International Affairs                   | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 117  | Behat Test | Behat Test 117      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 118  | Behat Test | Behat Test 118      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 119  | Behat Test | Behat Test 119      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 120  | Behat Test | Behat Test 120      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 121  | Behat Test | Behat Test 121      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Data                          | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 122  | Behat Test | Behat Test 122      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Data                          | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 123  | Behat Test | Behat Test 123      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 | DERA Newsletter               |                               |
    | 124  | Behat Test | Behat Test 124      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 | DERA Newsletter               |                               |
    | 125  | Behat Test | Behat Test 125      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | filergroup                    |                               |
    | 126  | Behat Test | Behat Test 126      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | filergroup                    |                               |
    | 127  | Behat Test | Behat Test 127      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 128  | Behat Test | Behat Test 128      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 129  | Behat Test | Behat Test 129      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | foiafreqdocs                  |                               |
    | 130  | Behat Test | Behat Test 130      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | foiafreqdocs                  |                               |
    | 131  | Behat Test | Behat Test 131      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | foiafreqdocs                  |                               |
    | 132  | Behat Test | Behat Test 132      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Fast Answers                  | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 | foiafreqdocs                  |                               |
    | 133  | Behat Test | Behat Test 133      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Forms                         | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 134  | Behat Test | Behat Test 134      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Forms                         | Information Technology                  | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 139  | Behat Test | Behat Test 139      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Acquisitions                            | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 140  | Behat Test | Behat Test 140      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Investor Alerts and Bulletins | Acquisitions                            | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 141  | Behat Test | Behat Test 141      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Data                          | Acquisitions                            | 123-KO               | Auditors       | Securities Act of 1933 |                               | Data-MarketStructure          |
    | 142  | Behat Test | Behat Test 142      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |                               | Data-MarketStructure          |
    | 160  | Behat Test | Behat Test 160      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Reports and Publications      | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 164  | Behat Test | Behat Test 164      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Staff Papers                  | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 165  | Behat Test | Behat Test 165      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Announcement                  | Structured Disclosure                   | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 167  | Behat Test | Behat Test 167      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Structured Disclosure                   | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 168  | Behat Test | Behat Test 168      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Economic and Risk Analysis              | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 169  | Behat Test | Behat Test 169      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 170  | Behat Test | Behat Test 170      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 171  | Behat Test | Behat Test 171      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Inspector General                       | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 172  | Behat Test | Behat Test 172      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Corporation Finance                     | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 173  | Behat Test | Behat Test 173      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 174  | Behat Test | Behat Test 174      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Inspector General                       | 123-KO               | Auditors       | Securities Act of 1933 |                               |                               |
    | 175  | Behat Test | Behat Test 175      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Inspector General                       | 123-KO               | Auditors       | Securities Act of 1933 | fort worth office             |                               |
    | 176  | Behat Test | Behat Test 176      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | filergroup                    |                               |
    | 177  | Behat Test | Behat Test 177      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | OIG Investigative Report      |                               |
    | 178  | Behat Test | Behat Test 178      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | foia-freq-doc                 |                               |
    | 179  | Behat Test | Behat Test 179      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | Boston Regional Office        |                               |
    | 180  | Behat Test | Behat Test 180      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | Los Angeles office            |                               |
    | 181  | Behat Test | Behat Test 181      | Some random text               | 2019-07-13T15:00:00 | 2019-07-15T16:00:00 | 1      | Academic Publications         | Financial Management                    | 123-KO               | Auditors       | Securities Act of 1933 | San Francisco Regional Office |                               |
  When I am on "/article/sfro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 181</title>"
    And I should see "<guid isPermaLink=\"false\">181</guid>"
  When I am on "/article/laro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 180</title>"
    And I should see "<guid isPermaLink=\"false\">180</guid>"
  When I am on "/article/bro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 179</title>"
    And I should see "<guid isPermaLink=\"false\">179</guid>"
  When I am on "/article/foia-freq-doc.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 178</title>"
    And I should see "<guid isPermaLink=\"false\">178</guid>"
  When I am on "/rss/oiginvestigativereportsquerymodule"
  Then I should see valid XML
    And I should see "<title>Behat Test 177</title>"
    And I should see "<guid isPermaLink=\"false\">177</guid>"
  When I am on "/ofm/article/announcement/filergroup.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 176</title>"
    And I should see "<guid isPermaLink=\"false\">176</guid>"
  When I am on "/article/fwro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 175</title>"
    And I should see "<guid isPermaLink=\"false\">175</guid>"
  When I am on "/rss/about/oig/oignews.xml"
  Then I should see valid XML
    And I should see "<title>Behat Test 174</title>"
    And I should see "<guid isPermaLink=\"false\">174</guid>"
  When I am on "/ocie/article/announcement.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 173</title>"
    And I should see "<guid isPermaLink=\"false\">173</guid>"
  When I am on "/corpfin/article/announcement.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 172</title>"
    And I should see "<guid isPermaLink=\"false\">172</guid>"
  When I am on "/oig/article/reportspubs.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 171</title>"
    And I should see "<guid isPermaLink=\"false\">171</guid>"
  When I am on "/rss/corpfin/corpfin-announcements"
  Then I should see valid XML
    And I should see "<title>Behat Test 170</title>"
    And I should see "<guid isPermaLink=\"false\">170</guid>"
  When I am on "/rss/ocie/ocie-announcements"
  Then I should see valid XML
    And I should see "<title>Behat Test 169</title>"
    And I should see "<guid isPermaLink=\"false\">169</guid>"
  When I am on "/rss/dera/academic-publications-querylist"
  Then I should see valid XML
    And I should see "<title>Behat Test 168</title>"
    And I should see "<guid isPermaLink=\"false\">168</guid>"
  When I am on "/article/academic-publications.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 167</title>"
    And I should see "<guid isPermaLink=\"false\">167</guid>"
  When I am on "/structureddata/article/announcement.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 165</title>"
    And I should see "<guid isPermaLink=\"false\">165</guid>"
  When I am on "/rss/dera/staff-papers"
  Then I should see valid XML
    And I should see "<title>Behat Test 164</title>"
    And I should see "<guid isPermaLink=\"false\">164</guid>"
  When I am on "/rss/reports"
  Then I should see valid XML
    And I should see "<title>Behat Test 160</title>"
    And I should see "<guid isPermaLink=\"false\">160</guid>"
  When I am on "/rss/ocie/announcements"
  Then I should see valid XML
    And I should see "<title>Behat Test 142</title>"
    And I should see "<guid isPermaLink=\"false\">142</guid>"
  When I am on "/rss/marketstructure/data"
  Then I should see valid XML
    And I should see "<title>Behat Test 141</title>"
    And I should see "<guid isPermaLink=\"false\">141</guid>"
  When I am on "/rss/investor/alerts"
  Then I should see valid XML
    And I should see "<title>Behat Test 140</title>"
    And I should see "<guid isPermaLink=\"false\">140</guid>"
  When I am on "/rss/announcements"
    # Then I should see valid XML
    And I should see "<title>Behat Test 119</title>"
    And I should see "<guid isPermaLink=\"false\">119</guid>"
    And I should see "<title>Behat Test 124</title>"
    And I should see "<guid isPermaLink=\"false\">124</guid>"
    And I should see "<title>Behat Test 115</title>"
    And I should see "<guid isPermaLink=\"false\">115</guid>"
  When I am on "/rss/allsecarticles"
    # Then I should see valid XML
    And I should see "<title>Behat Test 115</title>"
    And I should see "<guid isPermaLink=\"false\">115</guid>"
    And I should see "<title>Behat Test 123</title>"
    And I should see "<guid isPermaLink=\"false\">123</guid>"
    And I should see "<title>Behat Test 131</title>"
    And I should see "<guid isPermaLink=\"false\">131</guid>"
    And I should see "<title>Behat Test 119</title>"
    And I should see "<guid isPermaLink=\"false\">119</guid>"
    And I should see "<title>Behat Test 127</title>"
    And I should see "<guid isPermaLink=\"false\">127</guid>"
    And I should see "<title>Behat Test 139</title>"
    And I should see "<guid isPermaLink=\"false\">139</guid>"
  When I am on "/rss/forms"
  Then I should see valid XML
    And I should see "<title>Behat Test 133</title>"
    And I should see "<guid isPermaLink=\"false\">133</guid>"
    And I should see "<title>Behat Test 134</title>"
    And I should see "<guid isPermaLink=\"false\">134</guid>"
  When I am on "/seclink/foiafreqdocs.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 129</title>"
    And I should see "<guid isPermaLink=\"false\">129</guid>"
    And I should see "<title>Behat Test 130</title>"
    And I should see "<guid isPermaLink=\"false\">130</guid>"
    And I should see "<title>Behat Test 132</title>"
    And I should see "<guid isPermaLink=\"false\">132</guid>"
  When I am on "/seclink/foia-freq-doc.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 129</title>"
    And I should see "<guid isPermaLink=\"false\">129</guid>"
    And I should see "<title>Behat Test 130</title>"
    And I should see "<guid isPermaLink=\"false\">130</guid>"
    And I should see "<title>Behat Test 131</title>"
    And I should see "<guid isPermaLink=\"false\">131</guid>"
    And I should see "<title>Behat Test 132</title>"
    And I should see "<guid isPermaLink=\"false\">132</guid>"
  When I am on "/rss/foia-freq-docs"
  Then I should see valid XML
    And I should see "<title>Behat Test 129</title>"
    And I should see "<guid isPermaLink=\"false\">129</guid>"
    And I should see "<title>Behat Test 130</title>"
    And I should see "<guid isPermaLink=\"false\">130</guid>"
  When I am on "/rss/fast-answers"
  Then I should see valid XML
    And I should see "<title>Behat Test 127</title>"
    And I should see "<guid isPermaLink=\"false\">127</guid>"
    And I should see "<title>Behat Test 128</title>"
    And I should see "<guid isPermaLink=\"false\">128</guid>"
  When I am on "/rss/oit/filer-support-group-announcements"
  Then I should see valid XML
    And I should see "<title>Behat Test 125</title>"
    And I should see "<guid isPermaLink=\"false\">125</guid>"
    And I should see "<title>Behat Test 126</title>"
    And I should see "<guid isPermaLink=\"false\">126</guid>"
  When I am on "/article/announcement/filergroup.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 125</title>"
    And I should see "<guid isPermaLink=\"false\">125</guid>"
    And I should see "<title>Behat Test 126</title>"
    And I should see "<guid isPermaLink=\"false\">126</guid>"
  When I am on "/rss/dera/newsletter"
  Then I should see valid XML
    And I should see "<title>Behat Test 123</title>"
    And I should see "<guid isPermaLink=\"false\">123</guid>"
    And I should see "<title>Behat Test 124</title>"
    And I should see "<guid isPermaLink=\"false\">124</guid>"
  When I am on "/rss/data"
  Then I should see valid XML
    And I should see "<title>Behat Test 121</title>"
    And I should see "<guid isPermaLink=\"false\">121</guid>"
    And I should see "<title>Behat Test 122</title>"
    And I should see "<guid isPermaLink=\"false\">122</guid>"
  When I am on "/rss/corpfin/announcements"
  Then I should see valid XML
    And I should see "<title>Behat Test 119</title>"
    And I should see "<guid isPermaLink=\"false\">119</guid>"
    And I should see "<title>Behat Test 120</title>"
    And I should see "<guid isPermaLink=\"false\">120</guid>"
  When I am on "/rss/dera/academic-publications"
  Then I should see valid XML
    And I should see "<title>Behat Test 118</title>"
    And I should see "<guid isPermaLink=\"false\">118</guid>"
  When I am on "/rss/oia/announcements"
    # Then I should see valid XML
    And I should see "<title>Behat Test 116</title>"
    And I should see "<guid isPermaLink=\"false\">116</guid>"
    And I should see "<title>Behat Test 115</title>"
    And I should see "<guid isPermaLink=\"false\">115</guid>"
  When I am on "/rss/dera/dera_joblist"
    # Then I should see valid XML
    And I should see "<title>Behat Test 111</title>"
    And I should see "<guid isPermaLink=\"false\">111</guid>"
    And I should see "<pubDate>Mon, 17 Jun 2019 17:00:00</pubDate>"
    And I should see "<title>Behat Test 112</title>"
    And I should see "<guid isPermaLink=\"false\">112</guid>"
    And I should see "<pubDate>Sat, 13 Jul 2019 15:00:00</pubDate>"

@api @javascript
Scenario: Verify GUID Is Unique In RSS Feed For News
  Given "news" content:
    | uuid | field_news_type_news | field_primary_division_office | title      | status | body                     | field_display_title | field_publish_date  | field_date          | field_tags                  | field_division_office |
    | 113  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the first body.  | Behat Test 113      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | OCRNews                     |                       |
    | 114  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 114      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | OCRNews                     |                       |
    | 135  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the first body.  | Behat Test 135      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | homepage                    |                       |
    | 136  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 136      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | homepage                    |                       |
    | 143  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 143      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | homepage                    |                       |
    | 144  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 144      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | EMSAC                       |                       |
    | 145  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 145      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | ACSEC                       |                       |
    | 146  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 146      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | fort worth office           |                       |
    | 147  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 147      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | fort worth office           |                       |
    | 148  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 148      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Boston Regional Office      |                       |
    | 149  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 149      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Credit Ratings        |
    | 150  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 150      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Enforcement           |
    | 151  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 151      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Credit Ratings        |
    | 152  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 152      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | foreign corrupt practices   |                       |
    | 153  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 153      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Disclosure Effectiveness    |                       |
    | 154  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 154      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | cybersecurity               |                       |
    | 155  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 155      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | microcap fraud              |                       |
    | 156  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 156      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Crowdfunding                |                       |
    | 157  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 157      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Boston Regional Office      |                       |
    | 158  | Press Release        | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 158      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Investor Advisory Committee |                       |
    | 159  | Statement            | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 159      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |
    | 161  | Speech               | Credit Ratings                | Behat Test | 1      | This is the second body. | Behat Test 161      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |
    | 162  | Speech               | Economic and Risk Analysis    | Behat Test | 1      | This is the second body. | Behat Test 162      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |
    | 163  | Speech               | Chief Accountant              | Behat Test | 1      | This is the second body. | Behat Test 163      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |
    | 166  | Testimony            | Chief Accountant              | Behat Test | 1      | This is the second body. | Behat Test 166      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |
  When I am on "/rss/ocr/press-release"
  # Then I should see valid XML
    And I should see "<title>Behat Test 113</title>"
    And I should see "<guid isPermaLink=\"false\">113</guid>"
    And I should see "<title>Behat Test 114</title>"
    And I should see "<guid isPermaLink=\"false\">114</guid>"
  When I am on "/press-release/homepage.rss"
  # Then I should see valid XML
    And I should see "<title>Behat Test 135</title>"
    And I should see "<guid isPermaLink=\"false\">135</guid>"
    And I should see "<title>Behat Test 136</title>"
    And I should see "<guid isPermaLink=\"false\">136</guid>"
  When I am on "/press-release/emsac.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 144</title>"
    And I should see "<guid isPermaLink=\"false\">144</guid>"
  When I am on "/news/testimony.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 166</title>"
    And I should see "<guid isPermaLink=\"false\">166</guid>"
  When I am on "/oca/speech.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 163</title>"
    And I should see "<guid isPermaLink=\"false\">163</guid>"
  When I am on "/dera/speeches.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 162</title>"
    And I should see "<guid isPermaLink=\"false\">162</guid>"
  When I am on "/news/speeches.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 161</title>"
    And I should see "<guid isPermaLink=\"false\">161</guid>"
  When I am on "/news/statements.rss"
  Then I should see valid XML
  And I should see "<title>Behat Test 159</title>"
  And I should see "<guid isPermaLink=\"false\">159</guid>"
  When I am on "/press-release/iac.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 158</title>"
    And I should see "<guid isPermaLink=\"false\">158</guid>"
  When I am on "/rss/bro-whats-new"
  Then I should see valid XML
    And I should see "<title>Behat Test 157</title>"
    And I should see "<guid isPermaLink=\"false\">157</guid>"
  When I am on "/press-release/crowdfunding.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 156</title>"
    And I should see "<guid isPermaLink=\"false\">156</guid>"
  When I am on "/press-release/microcap-fraud.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 155</title>"
    And I should see "<guid isPermaLink=\"false\">155</guid>"
  When I am on "/press-release/cybersecurity.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 154</title>"
    And I should see "<guid isPermaLink=\"false\">154</guid>"
  When I am on "/press-release/disclosure-effectiveness.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 153</title>"
    And I should see "<guid isPermaLink=\"false\">153</guid>"
  When I am on "/press-release/fcpa.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 152</title>"
    And I should see "<guid isPermaLink=\"false\">152</guid>"
  When I am on "/rss/ocr/office-of-credit-ratings-press-releases"
  Then I should see valid XML
    And I should see "<title>Behat Test 151</title>"
    And I should see "<guid isPermaLink=\"false\">151</guid>"
  When I am on "/enforce/press-release.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 150</title>"
    And I should see "<guid isPermaLink=\"false\">150</guid>"
  When I am on "/ocr/press-release.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 149</title>"
    And I should see "<guid isPermaLink=\"false\">149</guid>"
  When I am on "/press-release/bro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 148</title>"
    And I should see "<guid isPermaLink=\"false\">148</guid>"
  When I am on "/press-release/fwro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 147</title>"
    And I should see "<guid isPermaLink=\"false\">147</guid>"
  When I am on "/rss/fwro-whats-new"
  Then I should see valid XML
    And I should see "<title>Behat Test 146</title>"
    And I should see "<guid isPermaLink=\"false\">146</guid>"
  When I am on "/press-release/acsec.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 145</title>"
    And I should see "<guid isPermaLink=\"false\">145</guid>"

@api @javascript
Scenario: Verify GUID Is Unique In RSS Feed For Landing Page
  Given "landing_page" content:
    | uuid | title      | field_display_title | field_primary_division_office | field_left_1_box | status |
    | 137  | Behat Test | Behat Test 137      | Credit Ratings                | Left 1           | 1      |
    | 138  | Behat Test | Behat Test 138      | Credit Ratings                | Left 1           | 1      |
  When I am on "/rss/allsectionlandingpages"
  # Then I should see valid XML
    And I should see "<title>Behat Test 137</title>"
    And I should see "<guid isPermaLink=\"false\">137</guid>"
    And I should see "<title>Behat Test 138</title>"
    And I should see "<guid isPermaLink=\"false\">138</guid>"

@api @javascript
Scenario: Validating Trading Suspensions RSS Feed
  Given "release" content:
    | uuid | title               | body         | field_release_type  | field_release_number | field_respondents | moderation_state | field_publish_date |
    | 197  | Trading Suspension1 | detail body1 | Trading Suspensions | 34-12345             | Allen             | published        | -5 days            |
    | 198  | Trading Suspension2 | detail body2 | Trading Suspensions | 34-23456             | Beverly           | published        | -10 days           |
  When I am on "/rss/litigation/suspensions.xml"
  Then I should see valid XML
    And I should see "<title>Allen</title>"
    And I should see "<guid isPermaLink=\"false\">197</guid>"
    And I should see "<dc:creator>Trading Suspension1</dc:creator>"
    And I should see "<title>Beverly</title>"
    And I should see "<dc:creator>Trading Suspension2</dc:creator>"
    And I should see "<guid isPermaLink=\"false\">198</guid>"

@api @javascript
Scenario: Validating Administrative Proceedings RSS Feed
  Given "release" content:
    | uuid | title               | body         | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date |
    | 199  | Admin Proceedings 1 | detail body1 | Administrative Proceedings | 34-12345             | Allen             | published        | -5 days            |
    | 201  | Admin Proceedings 2 | detail body2 | Administrative Proceedings | 34-23456             | Beverly           | published        | -10 days           |
  When I am on "/rss/litigation/admin.xml"
  Then I should see valid XML
    And I should see "<title>Allen</title>"
    And I should see "<guid isPermaLink=\"false\">199</guid>"
    And I should see "<dc:creator>Admin Proceedings 1</dc:creator>"
    And I should see "<title>Beverly</title>"
    And I should see "<dc:creator>Admin Proceedings 2</dc:creator>"
    And I should see "<guid isPermaLink=\"false\">201</guid>"

@api @javascript
Scenario: Verify Description Shows File Path In RSS Feed For News
  Given I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | Behat File | behat-file_corpfin.pdf | 1      |
    | BehatFile1 | behat-file_fanswer.pdf | 1      |
    And "news" content:
    | uuid | field_news_type_news | field_primary_division_office | title        | status | body                     | field_display_title | field_publish_date  | field_date          | field_tags                  | field_division_office | field_media_file_upload | field_release_number | field_description_abstract |
    | 134  | Statement            | Agency-wide                   | RSS PS Filer | 1      |                          | Behat Test 134      | 2018-12-11 12:00:00 | 2019-04-17T17:00:00 |                             |                       | BehatFile1              | 2018-12              | this is abstrac            |
    | 150  | Press Release        | Credit Ratings                | Behat Test1  | 1      |                          | Behat Test 150      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Enforcement           | Behat File              | 2018-12              | this is abstrac            |
    | 149  | Press Release        | Credit Ratings                | Behat Test2  | 1      | This is the second body. | Behat Test 149      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Credit Ratings        | Behat File              | 2018-12              |                            |
    | 145  | Press Release        | Credit Ratings                | Behat Test3  | 1      | This is the second body. | Behat Test 145      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | ACSEC                       |                       | Behat File              | 2018-12              | this is abstrac            |
    | 148  | Press Release        | Credit Ratings                | Behat Test4  | 1      | This is the second body. | Behat Test 148      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Boston Regional Office      |                       | BehatFile1              | 2018-12              | this is abstrac            |
    | 156  | Press Release        | Credit Ratings                | Behat Test5  | 1      | This is the second body. | Behat Test 156      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Crowdfunding                |                       | Behat File              | 2018-12              |                            |
    | 154  | Press Release        | Credit Ratings                | Behat Test6  | 1      | This is the second body. | Behat Test 154      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | cybersecurity               |                       | Behat File              | 2018-12              | this is abstrac            |
    | 153  | Press Release        | Credit Ratings                | Behat Test7  | 1      | This is the second body. | Behat Test 153      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Disclosure Effectiveness    |                       | Behat File              | 2018-12              | this is abstrac            |
    | 144  | Press Release        | Credit Ratings                | Behat Test8  | 1      | This is the second body. | Behat Test 144      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | EMSAC                       |                       | Behat File              | 2018-12              | this is abstrac            |
    | 152  | Press Release        | Credit Ratings                | Behat Test9  | 1      | This is the second body. | Behat Test 152      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | foreign corrupt practices   |                       | Behat File              | 2018-12              | this is abstrac            |
    | 147  | Press Release        | Credit Ratings                | Behat Test10 | 1      | This is the second body. | Behat Test 147      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | fort worth office           |                       | Behat File              | 2018-12              | this is abstrac            |
    | 158  | Press Release        | Credit Ratings                | Behat Test11 | 1      | This is the second body. | Behat Test 158      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Investor Advisory Committee |                       | Behat File              | 2018-12              | this is abstrac            |
    | 155  | Press Release        | Credit Ratings                | Behat Test12 | 1      | This is the second body. | Behat Test 155      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | microcap fraud              |                       | Behat File              | 2018-12              | this is abstrac            |
    | 157  | Press Release        | Credit Ratings                | Behat Test13 | 1      | This is the second body. | Behat Test 157      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | Boston Regional Office      |                       | Behat File              | 2018-12              | this is abstrac            |
    | 146  | Press Release        | Credit Ratings                | Behat Test14 | 1      | This is the second body. | Behat Test 146      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | fort worth office           |                       | Behat File              | 2018-12              | this is abstrac            |
    | 151  | Press Release        | Credit Ratings                | Behat Test15 | 1      | This is the second body. | Behat Test 151      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             | Credit Ratings        | Behat File              | 2018-12              | this is abstrac            |
    | 135  | Press Release        | Credit Ratings                | Behat Test   | 1      |                          | Behat Test 135      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 | homepage                    |                       | Behat File              | 2018-12              | this is abstrac            |
    | 161  | Speech               | Credit Ratings                | Behat Test   | 1      |                          | Behat Test 161      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       | Behat File              | 2018-12              | this is abstrac            |
    | 162  | Speech               | Economic and Risk Analysis    | Behat Test   | 1      | This is the second body. | Behat Test 162      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       |                         | 2018-12              | this is abstrac            |
    | 163  | Speech               | Chief Accountant              | Behat Test   | 1      |                          | Behat Test 163      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       | Behat File              | 2018-12              |                            |
    | 166  | Testimony            | Chief Accountant              | Behat Test   | 1      | This is the second body. | Behat Test 166      | 2019-04-17T17:00:00 | 2019-04-17T17:00:00 |                             |                       | Behat File              | 2018-12              |                            |

  When I am on "/"
    And I am on "/enforce/press-release.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 150</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">150</guid>"
  When I am on "/ocr/press-release.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 149</title>"
    And I should see "<description>This is the second body. </description>"
    And I should see "<guid isPermaLink=\"false\">149</guid>"
  When I am on "/press-release/acsec.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 145</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">145</guid>"
  When I am on "/press-release/bro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 148</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_fanswer.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">148</guid>"
  When I am on "/press-release/crowdfunding.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 156</title>"
    And I should see "<description>This is the second body. </description>"
    And I should see "<guid isPermaLink=\"false\">156</guid>"
  When I am on "/press-release/cybersecurity.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 154</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">154</guid>"
  When I am on "/press-release/disclosure-effectiveness.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 153</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">153</guid>"
  When I am on "/press-release/emsac.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 144</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">144</guid>"
  When I am on "/press-release/fcpa.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 152</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">152</guid>"
  When I am on "/press-release/fwro.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 147</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">147</guid>"
  When I am on "/press-release/iac.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 158</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">158</guid>"
  When I am on "/press-release/microcap-fraud.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 155</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">155</guid>"
  When I am on "/rss/bro-whats-new"
  Then I should see valid XML
    And I should see "<title>Behat Test 157</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">157</guid>"
  When I am on "/rss/fwro-whats-new"
  Then I should see valid XML
    And I should see "<title>Behat Test 146</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">146</guid>"
  When I am on "/rss/ocr/office-of-credit-ratings-press-releases"
  Then I should see valid XML
    And I should see "<title>Behat Test 151</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">151</guid>"
  When I am on "/press-release/homepage.rss"
  Then I should see "<title>Behat Test 135</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read more&lt;/a&gt; </description>"
    And I should see "<guid isPermaLink=\"false\">135</guid>"
  When I am on "/news/statements.rss"
  Then I should see "<title>Behat Test 134 (PDF)</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_fanswer.pdf\"&gt;Read more&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">134</guid>"
  When I am on "/news/speeches.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 161 (PDF)</title>"
    And I should see "<description>this is abstrac &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read More&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">161</guid>"
  When I am on "/dera/speeches.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 162</title>"
    And I should see "<description>this is abstrac</description>"
    And I should see "<guid isPermaLink=\"false\">162</guid>"
  When I am on "/oca/speech.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 163 (PDF)</title>"
    And I should see "<description> &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read More&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">163</guid>"
  When I am on "/news/testimony.rss"
  Then I should see valid XML
    And I should see "<title>Behat Test 166</title>"
    And I should see "<description> &lt;a href=\"http://sec.lndo.site/files/behat-file_corpfin.pdf\"&gt;Read More&lt;/a&gt;</description>"
    And I should see "<guid isPermaLink=\"false\">166</guid>"

@api @javascript
Scenario: Validating Accounting and Auditing Enforcement Releases RSS Feed
  Given "release" content:
    | nid | uuid | title               | body         | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date  |
    | 123 | 199  | Admin Proceedings 1 | detail body1 | Administrative Proceedings | AAER-12345           | Allen             | published        | 2019-04-17T17:00:00 |
    | 456 | 201  | Admin Proceedings 2 | detail body2 | Administrative Proceedings | AAER-23456           | Beverly           | published        | 2020-05-17T17:00:00 |
  When I am on "/rss/divisions/enforce/friactions.xml"
  # Then I should see valid XML
  Then I should see "<title>Allen</title>"
    And I should see "<link>http://sec.lndo.site/123</link>"
    And I should see "<description>Allen</description>"
    And I should see "<pubDate>May 2020</pubDate>"
    And I should see "<guid isPermaLink=\"false\">199</guid>"
    And I should see "<title>Beverly</title>"
    And I should see "<link>http://sec.lndo.site/456</link>"
    And I should see "<description>Beverly</description>"
    And I should see "<pubDate>April 2019</pubDate>"
    And I should see "<guid isPermaLink=\"false\">201</guid>"
