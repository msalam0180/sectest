Feature: Feature Content on Investor
  Featured content can be added to any content type showing four display cards with Title, Image and Summary of Feature content

Background:
  Given I create "media" of type "file":
    | name                | field_media_file | mid     |
    | BEHAT PDF File Test | behat-file.pdf   | 8272101 |
    And I create "media" of type "image":
      | name             | field_media_image  | mid     |
      | BEHAT Image Test | behat-gold-pig.png | 8272102 |
    And I create "media" of type "video":
      | name              | field_video_origin | field_video                                 | mid    | field_caption   | field_transcript | field_media_video_file | field_thumbnail    |
      | BEHAT Bird Image  | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 112312 | Bird caption    | Transcript       |                        | behat-dog.jpeg     |
      | BEHAT Dog Image   | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313 | Dog caption     |                  |                        | behat-bird.gif     |
      | BEHAT Bazoo video | upload             |                                             | 412314 | Buffalo caption | some transc      | behat-sample.mp4       | behat-doberman.jpg |
    And "article" content:
      | title                           | body                                               | status | moderation_state | nid | field_show_featured_content |
      | Investor Behat E&D Test Article | Investor Behat Display Title http://www.finra.org/ | 1      | published        | 5   | 0                           |
    And "gallery" content:
      | title               | body           | field_media                       | nid | field_show_featured_content |
      | BEHAT Gallery       | This is a test | BEHAT Bird Image, BEHAT Dog Image | 10  | 0                           |
      | BEHAT Gallery Video | This is a test | BEHAT Bird Image                  | 11  | 1                           |
    And "page" content:
      | title            | body           | status | nid | field_show_featured_content |
      | Behat Basic Page | free ice cream | 1      | 1   | 0                           |
    And "glossary_term" content:
      | title           | body                  | field_alternate_name | status | moderation_state | nid | field_show_featured_content |
      | Test Glossary 1 | Behat glossary search | Alternate            | 1      | published        | 15  | 0                           |
    And "landing" content:
      | title              | field_show_featured_content | nid |
      | BEHAT Landing Page | 0                           | 20  |
      | BEHAT Landing      | 1                           | 21  |
    And "news" content:
      | title              | body          | field_news_type    | status | moderation_state | nid | field_show_featured_content |
      | Test News Alert    | News Alerts   | Investor Alerts    | 1      | published        | 25  | 0                           |
      | Test News Bulletin | News Bulletin | Investor Bulletins | 1      | published        | 30  | 0                           |
    And "publication" content:
      | title            | body        | status | moderation_state | nid | field_show_featured_content |
      | Test publication | Publication | 1      | published        | 35  | 0                           |

@api @investor
Scenario: No Features Created
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/behat-gallery-video"
  Then I should not see the text "Featured Content"

@api @investor
Scenario: Draft and Deleted Feature Do Not Show
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 |
      | Behat Feature 2 | Behat Feature body 2 | 0      | unpublished      | teaser       | BEHAT Image Test  | 4232 |
  When I visit "/behat-gallery-video"
  Then I should see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
  When I visit "/node/4231/delete"
    And I press "Delete"
    And I visit "/behat-gallery-video"
  Then I should not see the text "Feature Content"

@api @javascript @investor
Scenario: Publish to Draft Feature Do Not Show
  Given I am logged in as a user with the "Administrator" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 |
  When I visit "/behat-gallery-video"
  Then I should see the text "Behat Feature 1"
  When I visit "/node/4231/edit"
    And I select "Unpublished" from "edit-moderation-state-0-state"
    And I fill in "URL" with "https://www.youtube.com/watch?v=xf9BpXOtMcc"
    And I press "Save"
    And I visit "/behat-gallery-video"
  Then I should not see the text "Behat Feature 1"

@api @javascript @investor
Scenario: Updated Feature Shows on Content Type
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 |
  When I visit "/behat-gallery-video"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
  When I visit "/node/4231/edit"
    And I fill in "Title" with "Update Behat Feature"
    And I fill in "URL" with "/"
    And I press "Save"
    And I visit "/behat-gallery-video"
  Then I should see the text "Update Behat Feature"
     And I should see the text "Behat Feature 2"
     And I click on the element with css selector "#block-featured-content-block > div > div > div > div:nth-child(1) > a > div:nth-child(1) > img"
     And I should see the text "Featured Information"

@api @investor
Scenario Outline: Verify Permissions for Feature
  Given I am logged in as a user with the "<role>" role
  When I am on "/node/add/featured"
  Then I should see the text "<result>"

  Examples:
    | role                                            | result                                      |
    | Authenticated user                              | You are not authorized to access this page. |
    | Content Creator                                 | Create Featured                             |
    | Content Approver                                | Create Featured                             |
    | Site Builder                                    | You are not authorized to access this page. |
    | Administrator                                   | Create Featured                             |
    | Content Creator, Content Approver, Site Builder | Create Featured                             |

@api @javascript @investor
Scenario Outline: Create Feature using UI
  Given I am logged in as a user with the "<role>" role
  When I am on "/node/add/featured"
    And I fill in "Title" with "Behat Testing New Feature"
    And I fill in "URL" with "/Behat-Basic-Page"
    And I type "Investor Behat Teaser Text" in the "Teaser" WYSIWYG editor
    And I fill in "Use existing media" with "BEHAT Image Test"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
  Then I should see the text "Featured Behat Testing New Feature has been created."

  Examples:
    | role                                          | result          |
    | Content Approver                              | Create Featured |
    | Administrator                                 | Create Featured |
    | Content Approver, Site Builder, Administrator | Create Featured |

@api @investor
Scenario: Delete Existing Feature
  Given I am logged in as a user with the "Content Creator" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 |
  When I am on "/behat-feature-1"
  Then I should see the text "teaser"
  When I am on "/node/4231/delete"
    And I press "Delete"
    And I am on "/behat-feature-1"
  Then I should see the text "Page not found"

@api @javascript @investor
Scenario: Update Existing Feature
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/behat-gallery-video"
  Then I should not see the text "Update Teaser Text"
    And I should see the text "Teaser"
    And I visit "Behat-landing"
    And I should not see the text "Update Teaser Text"
    And I should see the text "Teaser"
  When I visit "/node/4231/edit"
    And I fill in "URL" with "/Behat-Basic-Page"
    And I type "Update Teaser Text" in the "Teaser" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I am on "/behat-gallery-video"
  Then I should see the text "Update Teaser Text"
    And I visit "/behat-landing"
    And I should see the text "Update Teaser Text"

@api @javascript @investor
Scenario: Multiple Features for Page
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/node/1"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/1/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/node/1"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Gallery
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/behat-gallery"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/10/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/behat-gallery"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Article
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/investor-behat-ed-test-article"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/5/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/investor-behat-ed-test-article"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Glossary
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/introduction-investing/investing-basics/glossary/test-glossary-1"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/15/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/introduction-investing/investing-basics/glossary/test-glossary-1"
    And I wait 2 seconds
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Landing
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/behat-landing-page"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/20/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/behat-landing-page"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Alerts
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/test-news"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/25/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/test-news"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Bulletins
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-bulletins/test-news"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/30/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-bulletins/test-news"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"

@api @javascript @investor
Scenario: Multiple Features for Publications
  Given I am logged in as a user with the "Content Approver" role
    And "featured" content:
      | title           | body                 | status | moderation_state | field_teaser | field_media_image | nid  | created             |
      | Behat Feature 1 | Behat Feature body 1 | 1      | published        | teaser       | BEHAT Image Test  | 4231 | 2021-06-14T13:00:00 |
      | Behat Feature 2 | Behat Feature body 2 | 1      | published        | teaser       | BEHAT Image Test  | 4232 | 2021-05-14T13:00:00 |
      | Behat Feature 3 | Behat Feature body 3 | 1      | published        | teaser       | BEHAT Image Test  | 4233 | 2021-04-14T13:00:00 |
      | Behat Feature 4 | Behat Feature body 4 | 1      | published        | teaser       | BEHAT Image Test  | 4234 | 2021-03-14T13:00:00 |
      | Behat Feature 5 | Behat Feature body 5 | 1      | published        | teaser       | BEHAT Image Test  | 4235 | 2021-02-14T13:00:00 |
  When I visit "/test-publication"
  Then I should not see the text "Behat Feature 1"
    And I should not see the text "Behat Feature 2"
    And I should not see the text "Behat Feature 3"
    And I should not see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
  When I am on "/node/35/edit"
    And I check "Show Featured Content"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
    And I visit "/test-publication"
  Then I should see the text "Behat Feature 1"
    And I should see the text "Behat Feature 2"
    And I should see the text "Behat Feature 3"
    And I should see the text "Behat Feature 4"
    And I should not see the text "Behat Feature 5"
