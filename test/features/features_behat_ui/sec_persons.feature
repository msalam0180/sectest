Feature: Person View Page
  As a Site Visitor, the user should be able to view list pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Person Related Speech, Testimony, Statement and Press Releases Blocks
  Given "secperson" content:
    | title      | field_first_name_secperson | field_last_name_secperson | body                                                                               | field_enable_biography_page | status |
    | John Behat | John                       | Behat                     | John started working with behat in 2017 and has been maintaining behat ever since. | 1                           | 1      |
    And I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | Behat File | behat-file_corpfin.pdf | 1      |
    And "news" content:
    | field_news_type_news | field_primary_division_office | title           | status | field_description_abstract     | field_display_title             | field_publish_date  | field_person | field_media_file_upload | body         |
    | Speech               | Agency-wide                   | Speech 1        | 1      | Speech by Behat Tester         | Speech 1 by Behat Tester        | 2018-11-11 12:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 2        | 1      | Speech by Behat Tester         | Speech 2 by Behat Tester        | 2018-12-01 12:00:00 | John Behat   | Behat File              | this is body |
    | Speech               | Agency-wide                   | Speech 3        | 1      | Speech by Behat Tester         | Speech 3 by Behat Tester        | 2017-06-13 16:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 4        | 1      | Speech by Behat Tester         | Speech 4 by Behat Tester        | 2016-12-19 12:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 5        | 1      | Speech by Behat Tester         | Speech 5 by Behat Tester        | 2016-06-13 16:00:00 | John Behat   | Behat File              |              |
    | Testimony            | Agency-wide                   | Testimony 1     | 1      | Testimony by Behat Tester      | Testimony 1 by Behat Tester     | 2018-05-12 11:00:00 | John Behat   | Behat File              |              |
    | Testimony            | Agency-wide                   | Testimony 2     | 1      | Testimony by Behat Tester      | Testimony 2 by Behat Tester     | 2018-07-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Testimony            | Agency-wide                   | Testimony 3     | 1      | Testimony by Behat Tester      | Testimony 3 by Behat Tester     | 2018-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 1 | 1      | Statement by Behat Tester      | Statement 1 by Behat Tester     | 2018-09-11 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 2 | 1      | Statement by Behat Tester      | Statement 2 by Behat Tester     | 2018-10-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Statement            | Agency-wide                   | Pub Statement 3 | 1      | Statement by Behat Tester      | Statement 3 by Behat Tester     | 2017-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 4 | 1      | Statement by Behat Tester      | Statement 4 by Behat Tester     | 2018-07-11 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 1 | 1      | Press release by Behat Tester  | Press release 1 by Behat Tester | 2018-03-11 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 2 | 1      | Press release by Behat Tester  | Press release 2 by Behat Tester | 2018-06-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Press Release        | Agency-wide                   | Press release 3 | 1      | Press release by Behat Tester  | Press release 3 by Behat Tester | 2017-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 4 | 1      | Press release by Behat Tester  | Press release 4 by Behat Tester | 2018-07-11 12:00:00 | John Behat   | Behat File              |              |
  Then I take a screenshot on "sec" using "persons.feature" file with "@person_page" tag
