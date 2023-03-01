@list
Feature: Forms List Page
    As a visitor to SEC.gov
    I want to be able to view and sort through the information on List Pages
    So that I can quickly navigate to the most important information on the SEC.gov

@api @javascript
Scenario: View the Forms List Page
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       | field_publish_date  | field_date          | field_media_file_upload |
      | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |                     |                     | Behat File              |
      | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 0      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |                     |                     |                         |
      | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |                     |                     |                         |
      | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |                     |                     |                         |
      | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          | 2018-11-05T17:00:00 | 2019-11-05T17:00:00 |                         |
      | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 | 2018-12-10T17:00:00 | 2019-12-10T17:00:00 |                         |
  When I visit "/forms"
  Then I should see the heading "Forms List"
    #list view should display description link to forms with display title as text
    And I should see the link "Field Trip Form Behat Test 1 (PDF)"
    #list view should not display draft items
    And I should not see the link "Vacation Request Form Behat Test 2"
    And I should see the link "Driver License Renewal Form Behat Test 3"
    And I should see the link "Passport Renewal Form Behat Test 4"
    And I should see the link "Building Entry Form Behat Test 5"
    #list view should display the correct Last Updated date which is to use modified date if specified
    And I should see the text "Nov. 2019" in the "Building Entry Form Behat Test 5" row
    And I should see the text "Dec. 2019" in the "Visitor Parking Form Behat Test 6" row
    #list view should display topic
    And I should see the text "Dodd-Frank Act of 2010, Investment Advisers" in the "Field Trip Form Behat Test 1" row
    And I should see the text "Investment Company Act of 1940, Broker-Dealers" in the "Driver License Renewal Form Behat Test 3" row
    And I should see the text "JOBS Act of 2012, Self-Regulatory Organizations" in the "Passport Renewal Form Behat Test 4" row
    And I should see the text "Securities Act of 1933, Auditors" in the "Building Entry Form Behat Test 5" row
    And I should see the text "Securities Exchange Act of 1934, Public Companies" in the "Visitor Parking Form Behat Test 6" row
    #list view should display number
    And I should see the text "A-BNB" in the "Field Trip Form Behat Test 1" row
    And I should see the text "007" in the "Driver License Renewal Form Behat Test 3" row
    And I should see the text "ABC" in the "Passport Renewal Form Behat Test 4" row
    And I should see the text "123-KO" in the "Building Entry Form Behat Test 5" row
    And I should see the text "TKO-123" in the "Visitor Parking Form Behat Test 6" row
    #list view should display SEC Updated
    And I should see the text "SEC9999" in the "Field Trip Form Behat Test 1" row
    And I should see the text "SEC7777" in the "Driver License Renewal Form Behat Test 3" row
    And I should see the text "SEC6666" in the "Passport Renewal Form Behat Test 4" row
    And I should see the text "SEC5555" in the "Building Entry Form Behat Test 5" row
    And I should see the text "SEC4444" in the "Visitor Parking Form Behat Test 6" row

@api @javascript
Scenario: Default Sorting for Forms List Page
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
  Then "Driver License Renewal Form Behat Test 3" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Field Trip Form Behat Test 1" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Visitor Parking Form Behat Test 6" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Forms List Page by Form Number
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I click the sort filter "Number"
  Then "Vacation Request Form Behat Test 2" should precede "Visitor Parking Form Behat Test 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Passport Renewal Form Behat Test 4" should precede "Field Trip Form Behat Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Building Entry Form Behat Test 5" should precede "Driver License Renewal Form Behat Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Number"
    And "Driver License Renewal Form Behat Test 3" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Field Trip Form Behat Test 1" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Visitor Parking Form Behat Test 6" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Forms List Page by Form Description
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I click the sort filter "Description"
  Then "Building Entry Form Behat Test 5" should precede "Driver License Renewal Form Behat Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Field Trip Form Behat Test 1" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Vacation Request Form Behat Test 2" should precede "Visitor Parking Form Behat Test 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Description"
    And "Visitor Parking Form Behat Test 6" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Passport Renewal Form Behat Test 4" should precede "Field Trip Form Behat Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Driver License Renewal Form Behat Test 3" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Forms List Page by Last Updated
  Given "secarticle" content:
    | title        | field_display_title                      | field_publish_date  | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       | field_date          |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | 2018-02-15T01:00:00 | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |                     |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | 2017-04-15T01:00:00 | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |                     |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | 2019-06-15T01:00:00 | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |                     |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | 2019-09-15T01:00:00 | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |                     |
    | Bahat From 5 | Building Entry Form Behat Test 5         | 2019-03-15T01:00:00 | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |                     |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | 2019-10-15T01:00:00 | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |                     |
    | Bahat Form 7 | Wrong Last Updated Date Form             | 2019-02-15T01:00:00 | 1      | OSSS-5131                      | Forms                         | Agency-Wide                   | Core_867-1           | Public Companies              | Securities Exchange Act of 1934 |                     |
    | Bahat Form 8 | Modified Last Updated Date Form          | 2019-01-15T01:00:00 | 1      | OSSS                           | Forms                         | Agency-Wide                   | Core_867-1           | Public Companies              | Securities Exchange Act of 1934 | 2019-03-15T01:00:00 |
  When I visit "/forms"
    And I should see "Feb. 2019" in the "Wrong Last Updated Date Form" row
    And I should see "March 2019" in the "Modified Last Updated Date Form" row
    And I click the sort filter "Last Updated"
  Then "Vacation Request Form Behat Test 2" should precede "Field Trip Form Behat Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Building Entry Form Behat Test 5" should precede "Driver License Renewal Form Behat Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Passport Renewal Form Behat Test 4" should precede "Visitor Parking Form Behat Test 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Last Updated"
  Then "Visitor Parking Form Behat Test 6" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Driver License Renewal Form Behat Test 3" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Field Trip Form Behat Test 1" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Forms List Page by SEC Number
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I click the sort filter "SEC Number"
  Then "Visitor Parking Form Behat Test 6" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Passport Renewal Form Behat Test 4" should precede "Driver License Renewal Form Behat Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Vacation Request Form Behat Test 2" should precede "Field Trip Form Behat Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "SEC Number"
    And "Field Trip Form Behat Test 1" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Driver License Renewal Form Behat Test 3" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Building Entry Form Behat Test 5" should precede "Visitor Parking Form Behat Test 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Forms List Page by Topic
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I click the sort filter "Topic(s)"
  Then "Field Trip Form Behat Test 1" should precede "Vacation Request Form Behat Test 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Driver License Renewal Form Behat Test 3" should precede "Passport Renewal Form Behat Test 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Building Entry Form Behat Test 5" should precede "Visitor Parking Form Behat Test 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And I click the sort filter "Topic(s)"
    And "Visitor Parking Form Behat Test 6" should precede "Building Entry Form Behat Test 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Passport Renewal Form Behat Test 4" should precede "Driver License Renewal Form Behat Test 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Vacation Request Form Behat Test 2" should precede "Field Trip Form Behat Test 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Filter Forms List Page by Filed By or Statute
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I select "Investment Advisers" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Field Trip Form Behat Test 1"
    And I should not see the link "Visitor Parking Form Behat Test 6"
    And I select "Clearing Agencies" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Vacation Request Form Behat Test 2"
    And I should not see the link "Field Trip Form Behat Test 1"
    And I select "Broker-Dealers" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Driver License Renewal Form Behat Test 3"
    And I should not see the link "Vacation Request Form Behat Test 2"
    And I select "Self-Regulatory Organizations" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Passport Renewal Form Behat Test 4"
    And I should not see the link "Driver License Renewal Form Behat Test 3"
    And I select "Auditors" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Building Entry Form Behat Test 5"
    And I should not see the link "Passport Renewal Form Behat Test 4"
    And I select "Public Companies" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
    And I should see the link "Visitor Parking Form Behat Test 6"
    And I should not see the link "Building Entry Form Behat Test 5"
    And I select "-View All-" from "edit-field-audience-target-id"
    And I wait for AJAX to finish
  Then I select "Dodd-Frank Act of 2010" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Field Trip Form Behat Test 1"
    And I should not see the link "Visitor Parking Form Behat Test 6"
    And I select "Investment Advisers Act of 1940" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Vacation Request Form Behat Test 2"
    And I should not see the link "Field Trip Form Behat Test 1"
    And I select "Investment Company Act of 1940" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Driver License Renewal Form Behat Test 3"
    And I should not see the link "Vacation Request Form Behat Test 2"
    And I select "JOBS Act of 2012" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Passport Renewal Form Behat Test 4"
    And I should not see the link "Driver License Renewal Form Behat Test 3"
    And I select "Securities Act of 1933" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Building Entry Form Behat Test 5"
    And I should not see the link "Passport Renewal Form Behat Test 4"
    And I select "Securities Exchange Act of 1934" from "edit-field-act-target-id"
    And I wait for AJAX to finish
    And I should see the link "Visitor Parking Form Behat Test 6"
    And I should not see the link "Building Entry Form Behat Test 5"

@api @javascript
Scenario: Filter Forms List Page by Keyword
  Given "secarticle" content:
    | title        | field_display_title                      | changed   | status | field_list_page_det_secarticle | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience                | field_act                       |
    | Bahat Form 1 | Field Trip Form Behat Test 1             | +1 month  | 1      | SEC9999                        | Forms                         | Agency-Wide                   | A-BNB                | Investment Advisers           | Dodd-Frank Act of 2010          |
    | Bahat Form 2 | Vacation Request Form Behat Test 2       | -3 month  | 1      | SEC8888                        | Forms                         | Agency-Wide                   | VZ987                | Clearing Agencies             | Investment Advisers Act of 1940 |
    | Bahat Form 3 | Driver License Renewal Form Behat Test 3 | +8 month  | 1      | SEC7777                        | Forms                         | Agency-Wide                   | 007                  | Broker-Dealers                | Investment Company Act of 1940  |
    | Bahat Form 4 | Passport Renewal Form Behat Test 4       | +11 month | 1      | SEC6666                        | Forms                         | Agency-Wide                   | ABC                  | Self-Regulatory Organizations | JOBS Act of 2012                |
    | Bahat From 5 | Building Entry Form Behat Test 5         | +90 day   | 1      | SEC5555                        | Forms                         | Agency-Wide                   | 123-KO               | Auditors                      | Securities Act of 1933          |
    | Bahat Form 6 | Visitor Parking Form Behat Test 6        | +2 year   | 1      | SEC4444                        | Forms                         | Agency-Wide                   | TKO-123              | Public Companies              | Securities Exchange Act of 1934 |
  When I visit "/forms"
    And I fill in "listSearch" with "Renewal"
    And I wait for AJAX to finish
  Then the search results should not show the link "Field Trip Form Behat Test 1"
    And the search results should not show the link "Vacation Request Form Behat Test 2"
    And the search results should show the link "Driver License Renewal Form Behat Test 3"
    And the search results should show the link "Passport Renewal Form Behat Test 4"
    And the search results should not show the link "Building Entry Form Behat Test 5"
    And the search results should not show the link "Visitor Parking Form Behat Test 6"

@api @javascript
Scenario: Verify PDF file opens when the link is clicked from the list view for forms
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title                                                                          | field_display_title                                                            | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file having article type as forms and Corporate Finance as Division | Verify PDF file having article type as forms and Corporate Finance as Division | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  When I am logged in as a user with the "content_approver" role
    And I visit "/admin/content"
    And I click "Edit" in the "Verify PDF file having article type as forms and Corporate Finance as Division" row
    And I wait 2 seconds
    And I select the first autocomplete option for "Behat Test File" on the "Use existing media" field
    And I publish it
    And I am not logged in
    And I am on "/forms"
  Then I should see the text "Verify PDF file having article type as forms and Corporate Finance as Division"
  When I click "Verify PDF file having article type as forms and Corporate Finance as Division"
    And I wait 2 seconds
  Then I should be on "/files/behat-form1.pdf"
