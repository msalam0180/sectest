Feature: SEC Sitemap
  As Site Administrator, I want to be able to generate sitemap.xml for the newly created and updated content

  Background:
    Given "division_office" terms:
      | name              |
      | behat             |
      | office of justice |

@api @javascript @sitemaps
Scenario: Create Content And Media On Sitemap
  Given "webcast" content:
      | title                      | field_display_title         | field_start_date | field_end_date | field_webcast_running_time | field_webcast_src | moderation_state |
      | Behat Simple Webcast Test  | behat simple webcast test   | +24 hours        | +25 hours      | 2:00			                  | MPR         	    | published        |
    And "secperson" content:
      | title                 | field_first_name_secperson  | field_last_name_secperson | body                                                                                | field_enable_biography_page | status |
      | John Behat            | John                        | Behat                     | John started working with behat in 2018 and has been maintaining behat ever since.  | 1                           | 1      |
    And "event" content:
      # | field_sec_event_date | title                    | field_event_type  | body                 | field_location:country_code | :address_line1             | :administrative_area | :locality   | :postal_code | field_sec_event_end_date | field_display_title      | field_person | status | moderation_state |
      # | +1 week              | Behat Simple Event Test  | meeting           | Some text goes here. | US                          | 33 Arch Street, 24th Floor | MA                   | Boston      | 02110        | +2 weeks                 | behat simple event test  | John Behat   | 1      | published        |
      | field_sec_event_date | title                    | field_event_type  | body                 | field_sec_event_end_date | field_display_title      | field_person | status | moderation_state |
      | +1 week              | Behat Simple Event Test  | meeting           | Some text goes here. | +2 weeks                 | behat simple event test  | John Behat   | 1      | published        |
    And "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title         | status | body                 | field_primary_division_office |
      | Data                          | Data-MarketStructure          | published        | Behat Simple Article Test | behat simple article test   | 1      | This is the body     | Corporation Finance           |
    And "landing_page" content:
      | title                          | field_display_title            | field_primary_division_office | field_left_1_box | status |
      | Behat Simple Landing Page Test | behat simple landing page test | office of justice             | Left 1           | 1      |
    And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title                     | status | body                    | field_display_title       |
      | Press Release        | behat                         | published        | Behat Simple PR News Test | 1      | This is the first body. | behat simple pr news test |
    And "file" content:
      | title                         | field_display_title           | field_primary_division_office | status |
      | BEHAT Simple Static File Test | behat simple static file test | office of justice             | 1      |
    And "video" content:
      | title                   | field_display_title     | field_video                                | body         | field_transcript     | status | moderation_state |
      | BEHAT Simple Video Test | behat simple video test | http://www.youtube.com/watch?v=xf9BpXOtMcc | man from SEC | man walking in video | 1      | published        |
    And I create "media" of type "static_file":
      | name                    | field_display_title | field_media_file | field_description_abstract | status |
      | Behat live static file  | published media     | behat-wbform.pdf | This is description abs    | 1      |
      | Behat draft static file | unpublished media   | behat-file.xml   | This is description abs    | 0      |
    And I create "media" of type "video_media":
      | name            | field_display_title | field_remote_video_url                      | field_media_transcript | status | mid      |
      | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | cat transcript         | 1      | 98765575 |
      | BEHAT Dog Video | Dog on Vimeo        | https://vimeo.com/343314163                 | dog transcript         | 0      | 98765576 |
    And I create "media" of type "image_media":
      | name              | field_media_caption | status | mid      |
      | Gold Pig Tail     | Pig Caption         | 1      | 98765577 |
      | Black Rabbit Tail | Rabbit Caption      | 0      | 98765578 |
    And I am logged in as a user with the "administrator" role
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Testing Sitemap for Event Content
  Then I should see the link "http://sec.lndo.site/news/upcoming-events/behat-simple-event-test"
  When I click "http://sec.lndo.site/news/upcoming-events/behat-simple-event-test"
  Then I should see the heading "Behat Simple Event Test"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for SEC Article Content
  Then I should see the link "http://sec.lndo.site/corpfin/data/market-structure/behat-simple-article-test"
  When I click "http://sec.lndo.site/corpfin/data/market-structure/behat-simple-article-test"
  Then I should see the text "behat simple article test"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for PR News Content
  Then I should see the link "http://sec.lndo.site/news/press-release/behat-simple-pr-news-test"
  When I click "http://sec.lndo.site/news/press-release/behat-simple-pr-news-test"
  Then I should see the text "behat simple pr news test"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for Landing Page Content
  Then I should see the link "http://sec.lndo.site/page/behat-simple-landing-page-test"
  When I click "http://sec.lndo.site/page/behat-simple-landing-page-test"
  Then I should see the text "behat simple landing page test"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for Person Content
  Then I should see the link "http://sec.lndo.site/biography/john-behat"
  When I click "http://sec.lndo.site/biography/john-behat"
  Then I should see the text "John started working with behat in 2018"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for Static File Media
  Then I should see the link "http://sec.lndo.site/files/behat-wbform.pdf"
  When I click "http://sec.lndo.site/files/behat-wbform.pdf"
  Then the url should match "/files/behat-wbform.pdf"
  When I visit "/sec-sitemap.xml"
  # Testing Sitemap for Video Media
  Then I should see the link "http://sec.lndo.site/news/sec-videos/behat-cat-video"
  When I click "http://sec.lndo.site/news/sec-videos/behat-cat-video"
  Then I should see the heading "Cat on YouTube"
    And I should see the "iframe" element with the "src" attribute set to "https://www.youtube.com/embed/QIobikJiTuU?autoplay=0&start=0&rel=0" in the "contentarea" region
  When I visit "/sec-sitemap.xml"
  # Negative testing of sitemap for webcast, video, static file content which shouldn't show up
  Then I should not see the link "http://sec.lndo.site/webcast/behat-simple-webcast-test"
    And I should not see the link "http://sec.lndo.site/news/sec-videos/behat-simple-video-test"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-static-file-test"
    And I should see the link "http://sec.lndo.site/file/behat-live-static-file"
  # Negative testing of sitemap for image media, unpublished video and static file media which shouldn't show up
    And I should not see the link "http://sec.lndo.site/news/sec-videos/behat-dog-video"
    And I should not see the link "http://sec.lndo.site/media/98765577"
    And I should not see the link "http://sec.lndo.site/media/98765578"
    And I should not see the link "http://sec.lndo.site/file/behat-draft-static-file"
    And I should not see the link "http://sec.lndo.site/files/behat-file.xml"

@api @javascript @sitemaps
Scenario: Edit Article And Check Sitemap
  Given "secarticle" content:
    | field_article_type_secarticle | moderation_state | title                     | field_display_title       | status | body             | field_primary_division_office |
    | Forms                         | published        | Behat Simple Article Test | behat simple article test | 1      | This is the body | behat                         |
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I click "http://sec.lndo.site/forms/behat-simple-article-test"
  Then I should see the text "behat simple article test"
  When I am on "/forms/behat-simple-article-test/edit"
    And I fill in "Display Title" with "behat complex article test"
    And I type "new stuff " in the "Body" WYSIWYG editor
    And I publish it
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I click "http://sec.lndo.site/forms/behat-simple-article-test"
  Then I should see the text "behat complex article test"
    And I should see the text "new stuff"

@api @javascript @sitemaps
Scenario: Delete Content And Check Sitemap
  Given "news" content:
     | field_news_type_news          | field_primary_division_office | moderation_state | title                      | status | body                     | field_display_title        |
     | Press Release                 | office of justice                   | published        | Behat Simple PR News Test  | 1      | This is the first body.  | behat simple pr news test  |
    And I am logged in as a user with the "administrator" role
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
    And I should see the link "http://sec.lndo.site/news/press-release/behat-simple-pr-news-test"
  When I click "http://sec.lndo.site/news/press-release/behat-simple-pr-news-test"
  Then I should see the text "behat simple pr news test"
  When I am on "/news/press-release/behat-simple-pr-news-test/delete"
    And I press "edit-submit"
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should not see the link "http://sec.lndo.site/news/press-release/behat-simple-pr-news-test"

@api @javascript @sitemaps
Scenario: Unpublish Content And Check Sitemap
  Given "event" content:
      # | field_sec_event_date | title                    | field_event_type  | body                 | field_location:country_code | :address_line1             | :administrative_area | :locality   | :postal_code | field_sec_event_end_date | field_display_title      | status | moderation_state |
      # | +1 week              | Behat Simple Event Test  | meeting           | Some text goes here. | US                          | 33 Arch Street, 24th Floor | MA                   | Boston      | 02110        | +2 weeks                 | behat simple event test  | 1      | published        |
      | field_sec_event_date | title                    | field_event_type  | body                 | field_sec_event_end_date | field_display_title      | status | moderation_state |
      | +1 week              | Behat Simple Event Test  | meeting           | Some text goes here. | +2 weeks                 | behat simple event test  | 1      | published        |
    And I am logged in as a user with the "administrator" role
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
    And I should see the link "http://sec.lndo.site/news/upcoming-events/behat-simple-event-test"
  When I am on "/admin/content"
    And I click on the element with css selector "#edit-node-bulk-form-0"
    And I select "Set Content as Unpublished" from "action"
    And I press "Apply to selected items"
    And I wait for AJAX to finish
  Then I should see the text "Set Content as Unpublished was applied to 1 item."
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should not see the link "http://sec.lndo.site/news/upcoming-events/behat-simple-event-test"

@api @javascript @sitemaps
Scenario: Unpublish PDF Static File Media On Sitemap
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/media/add/static_file"
    And I fill in "Title" with "Behat Simple PDF File Test"
    And I fill in "Display Title" with "test simple pdf file test"
    And I attach the file "behat-file-lynx.pdf" to "File Upload"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the link "Behat Simple PDF File Test" in the status_message region
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
    And I should see the link "http://sec.lndo.site/file/behat-simple-pdf-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file-lynx.pdf"
  When I am on "/admin/content/media"
    And I click on the element with css selector "#edit-media-bulk-form-0"
    And I wait for ajax to finish
    And I select "Unpublish media" from "action"
    And I press "Apply to selected items"
    And I wait for ajax to finish
  Then I should see the text "Unpublish media was applied to 1 item."
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should not see the link "http://sec.lndo.site/file/behat-simple-pdf-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file-lynx.pdf"

@api @javascript @sitemaps
Scenario: Common Static Files Media On Sitemap
  Given I create "media" of type "static_file":
    | name                        | field_display_title        | field_media_file | field_description_abstract | status |
    | Behat Simple DOC File Test  | test simple doc file test  | behat-file.doc   | This is description abs    | 0      |
    | Behat Simple DOCX File Test | test simple docx file test | behat-file.docx  | This is description abs    | 0      |
    | Behat Simple XLS File Test  | test simple xls file test  | behat-file.xls   | This is description abs    | 0      |
    | Behat Simple XLSX File Test | test simple xlsx file test | behat-file.xlsx  | This is description abs    | 0      |
    | Behat Simple PPT File Test  | test simple ppt file test  | behat-file.ppt   | This is description abs    | 0      |
    | Behat Simple PPTX File Test | test simple pptx file test | behat-file.pptx  | This is description abs    | 0      |
    | Behat Simple TXT File Test  | test simple txt file test  | behat-file.txt   | This is description abs    | 0      |
    | Behat Simple CSV File Test  | test simple csv file test  | behat-file.csv   | This is description abs    | 0      |
    | Behat Simple ZIP File Test  | test simple zip file test  | behat-file.zip   | This is description abs    | 0      |
    | Behat Simple PDF File Test  | test simple pdf file test  | behat-file.pdf   | This is description abs    | 0      |
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate that unpublished media + attached file(s) should not be on sitemap
  Then I should not see the link "http://sec.lndo.site/file/behat-simple-doc-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.doc"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-docx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.docx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-xls-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.xls"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-xlsx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.xlsx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-ppt-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.ppt"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-pptx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.pptx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-txt-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.txt"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-csv-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.csv"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-zip-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.zip"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-pdf-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.pdf"
  When I am on "/admin/content/media"
    And I click on the element with css selector "#edit-media-bulk-form-0"
    And I click on the element with css selector "#edit-media-bulk-form-1"
    And I click on the element with css selector "#edit-media-bulk-form-2"
    And I click on the element with css selector "#edit-media-bulk-form-3"
    And I click on the element with css selector "#edit-media-bulk-form-4"
    And I click on the element with css selector "#edit-media-bulk-form-5"
    And I click on the element with css selector "#edit-media-bulk-form-6"
    And I click on the element with css selector "#edit-media-bulk-form-7"
    And I click on the element with css selector "#edit-media-bulk-form-8"
    And I click on the element with css selector "#edit-media-bulk-form-9"
    And I select "Publish media" from "action"
    And I press "Apply to selected items"
    And I wait for ajax to finish
  Then I should see the text "Publish media was applied to 10 items."
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate that published media + attached file(s) should be on sitemap
  Then I should see the link "http://sec.lndo.site/file/behat-simple-doc-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.doc"
    And I should see the link "http://sec.lndo.site/file/behat-simple-docx-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.docx"
    And I should see the link "http://sec.lndo.site/file/behat-simple-xls-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.xls"
    And I should see the link "http://sec.lndo.site/file/behat-simple-xlsx-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.xlsx"
    And I should see the link "http://sec.lndo.site/file/behat-simple-ppt-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.ppt"
    And I should see the link "http://sec.lndo.site/file/behat-simple-pptx-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.pptx"
    And I should see the link "http://sec.lndo.site/file/behat-simple-txt-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.txt"
    And I should see the link "http://sec.lndo.site/file/behat-simple-csv-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.csv"
    And I should see the link "http://sec.lndo.site/file/behat-simple-zip-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.zip"
    And I should see the link "http://sec.lndo.site/file/behat-simple-pdf-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.pdf"
  When I am on "/admin/content/media"
    And I click on the element with css selector "#edit-media-bulk-form-0"
    And I click on the element with css selector "#edit-media-bulk-form-1"
    And I click on the element with css selector "#edit-media-bulk-form-2"
    And I click on the element with css selector "#edit-media-bulk-form-3"
    And I click on the element with css selector "#edit-media-bulk-form-4"
    And I click on the element with css selector "#edit-media-bulk-form-5"
    And I click on the element with css selector "#edit-media-bulk-form-6"
    And I click on the element with css selector "#edit-media-bulk-form-7"
    And I click on the element with css selector "#edit-media-bulk-form-8"
    And I click on the element with css selector "#edit-media-bulk-form-9"
    And I select "Delete media" from "action"
    And I press "Apply to selected items"
    And I press "Delete"
    And I wait for ajax to finish
  Then I should see the text "Deleted 10 items."
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate deleted media + attached file(s) should not be on sitemap once media is deleted
  Then I should not see the link "http://sec.lndo.site/file/behat-simple-doc-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.doc"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-docx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.docx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-xls-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.xls"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-xlsx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.xlsx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-ppt-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.ppt"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-pptx-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.pptx"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-txt-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.txt"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-csv-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.csv"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-zip-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.zip"
    And I should not see the link "http://sec.lndo.site/file/behat-simple-pdf-file-test"
    And I should not see the link "http://sec.lndo.site/files/behat-file.pdf"

@api @javascript @sitemaps
Scenario: Article Content With Uploaded File On Sitemap
  Given I am logged in as a user with the "Content Approver" role
    And I create "media" of type "static_file":
      | name              | field_media_file | status |
      | Behat Test File 1 | behat-file.docx  | 1      |
      | Behat Test File 2 | behat-file.txt   | 1      |
      | Behat Test File 3 | behat-file.pdf   | 1      |
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "Behat Simple DOCX File Test"
    And I fill in "Display Title" with "test simple doc file test"
    And I select the first autocomplete option for "Behat Test File 1" on the "Use existing media" field
    And I wait for ajax to finish
    And I select "behat" from "Primary Division/Office"
    And I click the input with the value "Save and Create New Draft"
  Then I should see the link "behat-file.docx"
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "Behat Simple TXT File Test"
    And I fill in "Display Title" with "test simple txt file test"
    And I select the first autocomplete option for "Behat Test File 2" on the "Use existing media" field
    And I wait for ajax to finish
    And I select "behat" from "Primary Division/Office"
    And I click the input with the value "Save and Create New Draft"
  Then I should see the link "behat-file.txt"
  When I visit "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "Behat Simple PDF File Test"
    And I fill in "Display Title" with "test simple pdf file test"
    And I select the first autocomplete option for "Behat Test File 3" on the "Use existing media" field
    And I wait for ajax to finish
    And I select "behat" from "Primary Division/Office"
    And I click the input with the value "Save and Create New Draft"
  Then I should see the link "behat-file.pdf"
  When I am logged in as a user with the "administrator" role
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate that unpublished node should not be on sitemap
  Then I should not see the link "http://sec.lndo.site/behat-simple-docx-file-test"
    And I should not see the link "http://sec.lndo.site/behat-simple-txt-file-test"
    And I should not see the link "http://sec.lndo.site/behat-simple-pdf-file-test"
  When I am on "/admin/content/search"
    And I click on the element with css selector "#edit-node-bulk-form-0"
    And I click on the element with css selector "#edit-node-bulk-form-1"
    And I click on the element with css selector "#edit-node-bulk-form-2"
    And I wait for ajax to finish
    And I select "Set Content as Published" from "action"
    And I press "Apply to selected items"
    And I wait for ajax to finish
  Then I should see the text "Set Content as Published was applied to 3 items."
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate that published node + media file(s) should be on sitemap
  Then I should see the link "http://sec.lndo.site/behat-simple-docx-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.docx"
    And I should see the link "http://sec.lndo.site/behat-simple-txt-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.txt"
    And I should see the link "http://sec.lndo.site/behat-simple-pdf-file-test"
    And I should see the link "http://sec.lndo.site/files/behat-file.pdf"
  When I am on "/admin/content/search"
    And I click on the element with css selector "#edit-node-bulk-form-0"
    And I click on the element with css selector "#edit-node-bulk-form-1"
    And I click on the element with css selector "#edit-node-bulk-form-2"
    And I wait for ajax to finish
    And I select "Delete content" from "action"
    And I press "Apply to selected items"
    And I wait for ajax to finish
    And I press "Delete"
  Then I should see the text "Deleted 3 content items."
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  # Validate deleted node should not be on sitemap once node is deleted
  Then I should not see the link "http://sec.lndo.site/behat-simple-docx-file-test"
    And I should not see the link "http://sec.lndo.site/behat-simple-txt-file-test"
    And I should not see the link "http://sec.lndo.site/behat-simple-pdf-file-test"

@api @javascript @sitemaps
Scenario Outline: Verify The Latest Version Of Static File On Sitemap After File Replacement
  Given I create "media" of type "static_file":
    | name                       | field_display_title | field_media_file  | field_description_abstract | status |
    | Behat Replace Static File  | published media     | behat-file-im.txt | This is description abs    | 1      |
    And I am logged in as a user with the "Administrator" role
  When I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/file/behat-replace-static-file"
    And I should see the link "http://sec.lndo.site/files/behat-file-im.txt"
  When I visit "http://sec.lndo.site/files/behat-file-im.txt"
  Then I should see the text "this is a txt file"
  When I am on "/file/behat-replace-static-file/edit"
    And I attach the file "<filename>" to "File"
    And I wait for ajax to finish
    And I <checkbox_action> the box "edit-keep-original-filename"
    And I select "behat" from "Primary Division/Office"
    And I press "Save"
    And I am on "/admin/config/search/simplesitemap"
    And I press "Rebuild queue & generate"
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/file/behat-replace-static-file"
    And I should see the link "<file_link>"
  When I visit "<file_link>"
  Then I should see the text "this is an updated version of the txt file"
  When I visit "http://sec.lndo.site/files/behat-file-im.txt"
  Then I should see the text "<expected_text>"

    Examples:
      | checkbox_action | filename               | file_link                                         | expected_text                              |
      | check           | behat-file-updated.txt | http://sec.lndo.site/files/behat-file-im.txt      | this is an updated version of the txt file |
      | uncheck         | behat-file-updated.txt | http://sec.lndo.site/files/behat-file-updated.txt | Not Found                                  |

@api @javascript @sitemaps
Scenario: Verify The Latest Uploaded File On Article Is Showing Up In Sitemap
  Given I create "media" of type "static_file":
    | name              | field_media_file    | status |
    | Behat Test File 1 | behat-file-cat.pdf  | 1      |
    | Behat Test File 2 | behat-file-lynx.pdf | 1      |
    And "secarticle" content:
      | field_article_type_secarticle | moderation_state | title                     | field_display_title       | status | body             | field_primary_division_office |
      | Forms                         | published        | Behat Simple Article Test | behat simple article test | 1      | This is the body | behat                         |
  When I am logged in as a user with the "administrator" role
    And I am on "/forms/behat-simple-article-test/edit"
    And I select the first autocomplete option for "Behat Test File 1" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
  Then I should see the link "behat-file-cat.pdf"
  When I am on "/admin/config/search/simplesitemap/settings"
    And I check "Regenerate all sitemaps after hitting"
    And I press the "Save configuration" button
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/files/behat-file-cat.pdf"
    And I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I am on "/forms/behat-simple-article-test/edit"
    And I press the "Remove" button
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Test File 2" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
  Then I should see the link "behat-file-lynx.pdf"
  When I am on "/admin/config/search/simplesitemap/settings"
    And I check "Regenerate all sitemaps after hitting"
    And I press the "Save configuration" button
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/files/behat-file-lynx.pdf"
    And I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I am on "/forms/behat-simple-article-test/revisions"
    And I click "Revert" in the "Anonymous" row
    And I press "Revert"
    And I am on "/admin/config/search/simplesitemap/settings"
    And I check "Regenerate all sitemaps after hitting"
    And I press the "Save configuration" button
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  # Published media will be on sitemap
    And I should see the link "http://sec.lndo.site/files/behat-file-cat.pdf"
    And I should see the link "http://sec.lndo.site/files/behat-file-lynx.pdf"

@api @javascript @sitemaps
Scenario: Override Sitemap As Sitebuilder
  Given "secarticle" content:
    | field_article_type_secarticle | moderation_state | title                     | field_display_title       | status | body                   | field_primary_division_office |
    | Forms                         | published        | Behat Simple Article Test | behat simple article test | 1      | For sitebuilder access | office of justice             |
    And I am logged in as a user with the "sitebuilder" role
  When I am on "/forms/behat-simple-article-test/edit"
    And I press "Simple XML Sitemap"
    And I select the radio button "Do not index this Article entity in sitemap Default"
    And I check the box "Regenerate all sitemaps after hitting Save"
    And I publish it
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should not see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I am on "/forms/behat-simple-article-test/edit"
    And I press "Simple XML Sitemap"
    And I click on the element with css selector "#edit-simple-sitemap-default"
    And I select the radio button "Index this Article entity in sitemap Default (default)"
    And I check the box "Regenerate all sitemaps after hitting Save"
    And I publish it
    And I wait 5 seconds
    And I visit "/sec-sitemap.xml"
  Then I should see the link "http://sec.lndo.site/forms/behat-simple-article-test"
  When I click "http://sec.lndo.site/forms/behat-simple-article-test"
  Then I should see the heading "behat simple article test"
    And I should see the text "For sitebuilder access"
