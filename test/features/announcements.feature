Feature: Verify Articles with PDF in announcement and structure data list view
  As a user of the site
  I want to be able to upload PDF
  So that when I click on the link it should open a PDF

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for announcement
  Given  I create "media" of type "static_file":
      | name              | field_display_title  | field_media_file        | field_description_abstract | status |
      | Behat Test File 1 | static file          | behat-file_im_ann.pdf   | This is description abs    | 1      |
      | Behat Test File 2 | static file          | behat-file_ocie_ann.pdf | This is description abs    | 1      |
      | Behat Test File 3 | static file          | behat-file_st_news.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                                                           | field_display_title                                                     | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office           | field_release_number | field_audience | field_act              |
      | PDF having article type as Announcement and Division as Investment Management                   | DT Announcement and Division as Investment Management                   | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Investment Management                   | 123-KO               | Auditors       | Securities Act of 1933 |
      | PDF having article type as announcement and Compliance Inspections and Examinations as Division | DT announcement and Compliance Inspections and Examinations as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Compliance Inspections and Examinations | 123-KO               | Auditors       | Securities Act of 1933 |
      | PDF having article type as Announcement and division as Structured Disclosure                   | DT Announcement and division as Structured Disclosure                   | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Structured Disclosure                   | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am logged in as a user with the "administrator" role
    And I visit "/investment/announcement/pdf-having-article-type-announcement-and-division-investment-management/edit"
    And I select the first autocomplete option for "Behat Test File 1" on the "Use existing media" field
    And I publish it
    And I am on "/im/announcements"
  Then I should see the link "DT Announcement and Division as Investment Management"
  When I click "DT Announcement and Division as Investment Management"
  Then I should be on "/files/behat-file_im_ann.pdf"
  When I am logged in as a user with the "content_approver" role
    And I visit "/exams/announcement/pdf-having-article-type-announcement-and-compliance-inspections-and-examinations/edit"
    And I select the first autocomplete option for "Behat Test File 2" on the "Use existing media" field
    And I publish it
    And I am not logged in
    And I am on "/exams/announcements"
  Then I should see the link "DT announcement and Compliance Inspections and Examinations as Division"
  When I click "DT announcement and Compliance Inspections and Examinations as Division"
  Then I should be on "/files/behat-file_ocie_ann.pdf"
  When I am logged in as a user with the "content_approver" role
    And I visit "/structureddata/announcement/pdf-having-article-type-announcement-and-division-structured-disclosure/edit"
    And I select the first autocomplete option for "Behat Test File 3" on the "Use existing media" field
    And I publish it
    And I am not logged in
    And I am on "/structureddata/news"
  Then I should see the link "DT Announcement and division as Structured Disclosure"
  When I click "DT Announcement and division as Structured Disclosure"
  Then I should be on "/files/behat-file_st_news.pdf"
