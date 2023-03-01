Feature: Screenshots for Feature
  Take screenshot of features adding to content types

  Background:
    Given I create "media" of type "image":
      | name             | field_media_image  | mid     |
      | BEHAT Image Test | behat-gold-pig.png | 8272109 |
      And I create "media" of type "video":
      | name             | field_video_origin | field_video                                 | mid    | field_caption | field_transcript |
      | BEHAT Bird Image | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312 | Bird caption  | Transcript       |
      | BEHAT Dog Image  | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313 | Dog caption   |                  |
      And "article" content:
      | title                  | body                                               | status | moderation_state | nid | field_show_featured_content |
      | Investor Behat Article | Investor Behat Display Title http://www.finra.org/ | 1      | published        | 5   | 1                           |
      And "gallery" content:
      | title         | body           | field_media                       | nid | field_show_featured_content | moderation_state |
      | BEHAT Gallery | This is a test | BEHAT Bird Image, BEHAT Dog Image | 10  | 1                           | published        |
      And "page" content:
      | title            | body           | status | nid | field_show_featured_content | moderation_state |
      | Behat Basic Page | free ice cream | 1      | 1   | 1                           | published        |
      And "glossary_term" content:
      | title           | body                  | field_alternate_name | status | moderation_state | nid | field_show_featured_content |
      | Test Glossary 1 | Behat glossary search | Alternate            | 1      | published        | 15  | 1                           |
      And "landing" content:
      | title         | field_show_featured_content | nid | moderation_state |
      | BEHAT Landing | 1                           | 21  | published        |
      And "news" content:
      | title              | body          | field_news_type    | status | moderation_state | nid | field_show_featured_content |
      | Test News Alert    | News Alerts   | Investor Alerts    | 1      | published        | 25  | 1                           |
      | Test News Bulletin | News Bulletin | Investor Bulletins | 1      | published        | 30  | 1                           |
      And "publication" content:
      | title            | body        | status | moderation_state | nid | field_show_featured_content |
      | Test publication | Publication | 1      | published        | 35  | 1                           |
      And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 |

  @api @javascript @ui @wdio
  Scenario: Screenshot of Features adding to Content Types
    Given I am logged in as a user with the "Content Approver" role
    Then I take a screenshot on "investor" using "feature.feature" file with "@feature_page" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_gallery" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_article" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_glossary" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_landing" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_alerts" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_bulletins" tag
      And I take a screenshot on "investor" using "feature.feature" file with "@feature_publication" tag
