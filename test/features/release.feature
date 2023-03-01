Feature: Release Content Type
  As a Content Creator
  I want to be able to create release content
  So that visitors to SEC.gov can learn about the secgov

  @api
  Scenario Outline: View Releases Content Types
    Given "division_office" terms:
        | name       |
        | division 1 |
        | office 1   |
      And I am viewing an "release" content:
        | title                         | This is the title   |
        | body                          | This is the body    |
        | field_primary_division_office | office 1            |
        | field_release_number          | 1234                |
        | field_release_type            | <Release type>      |
        | field_respondents             | My test article     |
        | moderation_state              | published           |
        | field_publish_date            | 2021-02-02 12:00:00 |
    Then I should see the text "My test article"
      And I should see the link "Enforcement" in the navigation region
      And I should see the text "This is the body"

    Examples:
      | Release type                     |
      | Trading Suspensions              |
      | ALJ Initial Decisions            |
      | ALJ Orders                       |
      | Opinions and Adjudicatory Orders |
      | Administrative Proceedings       |
      | Stop Orders                      |
      | Litigation Releases              |

  @api
  Scenario Outline: Create Releases Over the UI
    Given I am logged in as a user with the "Administrator" role
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Test <Release type>"
      And I select "<Release type>" from "Release Type"
      And I fill in "Release Number" with "123"
      And I fill in "Respondent" with "Name"
      And I press "Save"
    Then I should see the text "Behat Test <Release type>"

    Examples:
      | Release type                     |
      | Trading Suspensions              |
      | ALJ Initial Decisions            |
      | ALJ Orders                       |
      | Opinions and Adjudicatory Orders |
      | Administrative Proceedings       |
      | Stop Orders                      |
      | Litigation Releases              |


  @api
  Scenario Outline: Mandatory Fields For Release
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/node/add/release"
      And I fill in "Title" with "<title>"
      And I select "<release_type>" from "Release Type"
      And I fill in "Release Number" with "<release_number>"
      And I fill in "Respondents" with "<respondents>"
      And I fill in "edit-field-publish-date-0-value-date" with "<publish date>"
      And I press "Save"
    Then I should see "Fields marked with an asterisk(*) are required."

    Examples:
      | title | release_type               | release_number | respondents | publish date |
      |       | Trading Suspensions        | 123            | test        | 01-01-2021   |
      | null  |                            | 456            | A           | 01-01-2021   |
      | test  | ALJ Orders                 |                | 54          | 01-01-2021   |
      | null  | Administrative Proceedings | 789            |             | 01-01-2021   |
      | title | Trading Suspensions        | 123            | test        |              |

  @api @javascript
  Scenario Outline: Verify All Release Fields
    Given I am logged in as a user with the "Content Creator" role
      And "rulemaking_index" terms:
        | name       |
        | ui-98-po   |
        | ab-12-cd   |
      And "division_office" terms:
        | name       |
        | office 1   |
      And I create "media" of type "static_file":
        | name                     | field_display_title | field_media_file    | field_description_abstract | status |
        | Behat live static file 1 | published media     | behat-file.pdf      | This is description abs    | 1      |
        | Behat live static file 2 | published media     | behat-file_foia.pdf | This is description abs    | 1      |
      And "link" content:
        | title           | field_url                                                   | field_topics            | field_subtopic | field_primary_division_office | status | moderation_state | field_publish_date  |
        | TRG TEST Link 1 | Content Search - https://sec.lndo.site/admin/content/search | Accounting and Auditing | Forms          | Investment Management         | 1      | published        | 2021-09-11 12:00:00 |
      And "customized_comment_form" content:
        | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
        | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Test All Fields"
      And I select "<release_type>" from "Release Type"
      And I check the box "Delinquent Filing"
      And I fill in "Release Number" with "rm-123"
      And I fill in "File Number" with "1234ABCD"
      And I fill in "Respondent" with "Name"
      And I press "Add existing Release File"
      And I select the first autocomplete option for "Behat live static file 1" on the "field_release_file[form][0][entity_id]" field
      And I press "Add Release File"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 2" on the "field_see_also[form][0][entity_id]" field
      And I press "Add Reference"
      And I scroll "#edit-body-wrapper" into view
      And I type "This is the body" in the "Release Page Content" WYSIWYG editor
      And I select "office 1" from "Primary Division/Office"
      And I select the first autocomplete option for "Proposed Ruling XYZ Comment Form 1" on the "field_submit_comments[0][target_id]" field
      And I type "Behat due 1/1/2030" in the "Comments Due Text" WYSIWYG editor
      And I select the first autocomplete option for "TRG TEST Link 1" on the "field_comments_received[0][uri]" field
      And I fill in "field_comments_received[0][title]" with "Link1"
      And I press "Save"
    Then I should see the heading "Name"
      And I should not see the text "Release No. 123"
      And I should see the text "This is the body"
      And I should not see "1234ABCD"
      And I should not see "See Also:"
    When I visit "<list_page>"
    Then I should see the heading "<title>"
      And I should see the link "Administrative Proceedings" in the navigation region
      And I should see the link "Name"
      And I should see "Release No. rm-123"
      And I should see "See Also: published media"
      And I should see "Comments Due: Behat due 1/1/2030"
      And I should see "Comments Received: Link1"
      And I should see "Submit Comments on: Proposed Ruling XYZ Comment Form 1"
      And the hyperlink "Proposed Ruling XYZ Comment Form 1" should match the Drupal url "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1"
    When I click "Name"
    Then I should be on "/files/behat-file.pdf"
    When I am on "<list_page>"
      And I click "published media"
    Then I should be on "/files/behat-file_foia.pdf"
    When I visit "/<list_page>/behat-test-all-fields/edit"
      And I fill in "edit-field-comments-due-date-0-value-date" with "01/02/2022"
      And I press "Save"
    Then I am on "<list_page>"
    And I should see the text "Comments Due: January 2, 2022"

 Examples:
      | release_type                     | list_page               | title                            |
      | Trading Suspensions              | /litigation/suspensions | Trading Suspensions              |
      | ALJ Initial Decisions            | /alj/aljdec             | ALJ Initial Decisions            |
      | ALJ Orders                       | /alj/aljorders          | ALJ Orders                       |
      | Opinions and Adjudicatory Orders | /litigation/opinions    | Opinions and Adjudicatory Orders |
      | Administrative Proceedings       | /litigation/admin       | Administrative Proceedings       |
      | Stop Orders                      | /litigation/stoporders  | Stop Orders                      |
      | Litigation Releases              | /litigation/litreleases | Litigation Releases              |

  @api @javascript
  Scenario Outline: Verify Release List Sorting
    Given "release" content:
      | title         | body         | field_release_type | field_release_number | field_respondents | status | field_publish_date |
      | Release Item1 | detail body1 | <release_type>     | 34-12345             | Allen             | 1      | -10 days           |
      | Release Item2 | detail body2 | <release_type>     | 34-23456             | Beverly           | 1      | -20 days           |
      | Release Item3 | detail body3 | <release_type>     | 34-34567             | Caroline          | 1      | -25 days           |
      | Release Item4 | detail body4 | <release_type>     | 34-45678             | David             | 1      | 01-01-2021         |
      | Release Item5 | detail body5 | <release_type>     | 34-56789             | Edward            | 1      | 15-01-2021         |
      | Release Item6 | detail body6 | <release_type>     | 34-67890             | Franky            | 1      | 03-03-2021         |
      | Release Item7 | detail body7 | <release_type>     | 34-78901             | Grover            | 1      | 02-02-2020         |
      | Release Item8 | detail body8 | <release_type>     | 34-78901             | Hanry             | 1      | 15-02-2020         |
      And I am logged in as a user with the "authenticated" role
    When I am on "<list_page>"
    Then I should see the link "Beverly" before I see the link "Caroline" in the "Releases Via Taxonomy" view
      And I should see the link "Allen" before I see the link "Beverly" in the "Releases Via Taxonomy" view
      And I should see the link "Caroline" before I see the link "Franky" in the "Releases Via Taxonomy" view
    When I click the sort filter "Date"
    Then I should see the link "Caroline" before I see the link "Beverly" in the "Releases Via Taxonomy" view
      And I should see the link "Beverly" before I see the link "Allen" in the "Releases Via Taxonomy" view
      And I should see the link "Franky" before I see the link "Caroline" in the "Releases Via Taxonomy" view
    When I select "2021" from "Year"
    Then I should see the link "Franky" before I see the link "David" in the "Releases Via Taxonomy" view
      And I should not see the link "Hanry" in the navigation region
    When I select "January" from "Month"
    Then I should see the link "Edward" before I see the link "David" in the "Releases Via Taxonomy" view
      And I should not see the link "Franky" in the navigation region
    When I select "2020" from "Year"
      And I select "February" from "Month"
      And I click the sort filter "Respondents"
    Then I should see the link "Grover" before I see the link "Hanry" in the "Releases Via Taxonomy" view
    When I click the sort filter "Respondents"
    Then I should see the link "Hanry" before I see the link "Grover" in the "Releases Via Taxonomy" view

  Examples:
        | release_type                     | list_page               |
        | Trading Suspensions              | /litigation/suspensions |
        | ALJ Initial Decisions            | /alj/aljdec             |
        | ALJ Orders                       | /alj/aljorders          |
        | Opinions and Adjudicatory Orders | /litigation/opinions    |
        | Administrative Proceedings       | /litigation/admin       |
        | Stop Orders                      | /litigation/stoporders  |
        | Litigation Releases              | /litigation/litreleases |

  @api
  Scenario Outline: Release with multiple values on Release Numbers, File Numbers, See Also, and Comments
    Given "rulemaking_index" terms:
        | name     |
        | ui-98-po |
        | ab-12-cd |
        | 34-12345 |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
        | Comment behat | Display Title for 1 | 1      | ui-98-po          | /comments/ui-98-po | ui-98-po     |
      And I create "media" of type "static_file":
        | name          | field_display_title | field_media_file    | field_description_abstract | status |
        | Behat 1stFile | published media     | behat-file_data.pdf | This is description abs    | 1      |
        | Behat File2   | published media2    | behat-file_foia.pdf | This is description abs2   | 1      |
      And I create "media" of type "link":
        | name           | field_media_entity_link                                | status | mid |
        | Behat Link     | https://sec.lndo.site/page/enforcement-section-landing | 1      | 1   |
        | Behat External | http://google.com                                      | 1      | 2   |
      And I am viewing an "release" content:
        | title                   | This is the title                   |
        | body                    | This is the body                    |
        | field_release_number    | 1-234, 2-12312                      |
        | field_release_file      | Behat 1stFile, Behat File2          |
        | field_release_type      | <release_type>          |
        | field_respondents       | My test article                     |
        | field_see_also          | Behat Link, Behat External          |
        | moderation_state        | published                           |
        | field_submit_comments   | Comment Form, Comment behat         |
        | field_publish_date      | 2021-02-02 12:00:00                 |
        | field_comments_received | Go to SEC.gov - https://www.sec.gov |
      And I am logged in as a user with the "authenticated" role
    When I visit "<list_page>"
    Then I should see the text "1-234, 2-12312"
      And I should see "See Also: https://sec.lndo.site/page/enforcement-section-landing , http://google.com"
      And I should see "Comments Received: Go to SEC.gov"
      And I should see "Submit Comments on: Comment Form, Comment behat"

  Examples:
        | release_type                     | list_page               |
        | Trading Suspensions              | /litigation/suspensions |
        | ALJ Initial Decisions            | /alj/aljdec             |
        | ALJ Orders                       | /alj/aljorders          |
        | Opinions and Adjudicatory Orders | /litigation/opinions    |
        | Administrative Proceedings       | /litigation/admin       |
        | Stop Orders                      | /litigation/stoporders  |
        | Litigation Releases              | /litigation/litreleases |

  @api
  Scenario Outline: Verify Release Taxonomy Title Overwrite
    Given I am logged in as a user with the "sitebuilder" role
    When I am on "<list_page>/edit"
      And I fill in "Page Title Override" with "Behat Override"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
    Then I should see the heading "Behat Override"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "<list_page>/edit"
      And I fill in "Page Title Override" with ""
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
    Then I should see the heading "<title>"

    Examples:
      | list_page               | title                            |
      | /litigation/suspensions | Trading Suspensions              |
      | /alj/aljdec             | ALJ Initial Decisions            |
      | /alj/aljorders          | ALJ Orders                       |
      | /litigation/opinions    | Opinions and Adjudicatory Orders |
      | /litigation/admin       | Administrative Proceedings       |
      | /litigation/stoporders  | Stop Orders                      |
      | /litigation/litreleases | Litigation Releases              |

  @api
  Scenario Outline: Verify Release Default Quick Links
    Given I am logged in as a user with the "sitebuilder" role
    When I am on "<list_page>/edit"
    Then I select "Show Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
    Then I should see "Quick Links"
      And I click "Litigated AP Case Materials (Open)"
      And I should see the heading "Open Administrative Proceeding Cases"
    When I am on "<list_page>"
      And I click "Litigated AP Case Materials (Closed)"
    Then I should see the heading "Closed Administrative Proceeding Cases"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "<list_page>/edit"
    Then I select "Show Alternate Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
    Then I should see the link "Litigated AP Case Materials (Open)"
      And I should see the link "Litigated AP Case Materials (Closed)"
      And I should see the link "Electronic Filings in Administrative Proceedings (eFAP)"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "<list_page>/edit"
    Then I select "Customize Quick Links" from "field_quick_links"
      And I fill in "field_customized_quick_links[0][uri]" with "http://sec.lndo.site/edgar/about"
      And I fill in "field_customized_quick_links[0][title]" with "EDGAR"
      And I press "field_customized_quick_links_add_more"
      And I fill in "field_customized_quick_links[1][uri]" with "https://www.google.com"
      And I fill in "field_customized_quick_links[1][title]" with "External Google Link"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
      And I click "EDGAR"
    Then I should see the heading "About EDGAR"
    When I am on "<list_page>"
      And I should see the "a" element with the "href" attribute set to "https://www.google.com" in the "release_view_about" region
    When I am logged in as a user with the "sitebuilder" role
      And I am on "<list_page>/edit"
    Then I select "Hide Quick Links" from "field_quick_links"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "<list_page>"
    Then I should not see "Quick Links"
      And I should not see the link "Litigated AP Case Materials (Open)"

    Examples:
      | release_type                     | list_page               | title                            |
      | Trading Suspensions              | /litigation/suspensions | Trading Suspensions              |
      | ALJ Initial Decisions            | /alj/aljdec             | ALJ Initial Decisions            |
      | ALJ Orders                       | /alj/aljorders          | ALJ Orders                       |
      | Opinions and Adjudicatory Orders | /litigation/opinions    | Opinions and Adjudicatory Orders |
      | Administrative Proceedings       | /litigation/admin       | Administrative Proceedings       |
      | Stop Orders                      | /litigation/stoporders  | Stop Orders                      |
      | Litigation Releases              | /litigation/litreleases | Litigation Releases              |

# All Release Import tests depends on certain files. To make things easier, all tests use the same pdf files.
# By default the wupdate.json file works for Trading Ssupensions. On testing other imports the wupdate.json file needs to be rename current and replace wupdate.json file.
# For example - testing: [Release Import Administrative Proceedings Using JSON and PDF Files] rename wupdate.json to wupdate-ts.json and wupdate-ap.json to wupdate.json before testing.
  @api @javascript
  Scenario: Release Import Trading Suspensions Using JSON and PDF Files
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/admin/release_importer"
      And I attach the file "1234-9876.pdf" to "Files to be Imported"
      And I attach the file "1234-9876-o.pdf" to "Files to be Imported"
      And I attach the file "wupdate.json" to "Files to be Imported"
      And I press "Import"
    Then I should see "Imported Trading Suspension Order 1234-9876"
      And I should see "Imported Trading Suspension Release 1234-9876"
      And I should see "Imported Release No. 1234-9876"
      And I should see "Your files were successfully imported."
    When I am on "/litigation/suspensions"
    Then I should not see "1234-9876"
    When I am on "litigation/suspensions/1234-9876/edit"
      And I click on the element with css selector "#edit-status-value"
      And I press "Save"
      And I am on "/litigation/suspensions"
    Then I should see "1234-9876"
      And I should see the link "Behat Trading Suspension"
      And the hyperlink "Behat Trading Suspension" should match the Drupal url "/files/litigation/suspensions/2021/1234-9876.pdf"
      And I should see the text "Release No. 1234-9876"
      And I should see "See also:"
      And the hyperlink "Order" should match the Drupal url "/files/litigation/suspensions/2021/1234-9876-o.pdf"

  # @api @javascript
  # Scenario: Release Import Administrative Proceedings Using JSON and PDF Files
  #   Given I am logged in as a user with the "Content Creator" role
  #   When I am on "/admin/release_importer"
  #     And I attach the file "1234-9876.pdf" to "Files to be Imported"
  #     And I attach the file "1234-9876-o.pdf" to "Files to be Imported"
  #     And I attach the file "wupdate.json" to "Files to be Imported"
  #     And I press "Import"
  #   Then I should see "Imported Administrative Proceedings Order 1234-9876"
  #     And I should see "Imported Administrative Proceedings Release 1234-9876"
  #     And I should see "Imported Administrative Proceedings Release 1234-9876-o"
  #     And I should see "Imported Release No. 1234-9876-o"
  #     And I should see "Imported Release No. 1234-9876"
  #     And I should see "Your files were successfully imported."
  #   When I am on "/litigation/admin"
  #   Then I should not see "1234-9876"
  #   When I am on "/litigation/admin/1234-9876/edit"
  #     And I click on the element with css selector "#edit-status-value"
  #     And I press "Save"
  #     And I am on "/litigation/admin"
  #   Then I should see "1234-9876"
  #     And I should not see "1234-9876-o"
  #     And I should see the link "Behat AP"
  #     And the hyperlink "Behat AP" should match the Drupal url "/files/litigation/admin/2020/1234-9876.pdf"
  #     And I should see the text "Release No. 1234-9876"
  #     And I should see "1234-9876, 34-90664, AAER-4196"

  # @api @javascript
  # Scenario: Release Import ALJ Initial Decisions Using JSON and PDF Files
  #   Given I am logged in as a user with the "Content Creator" role
  #   When I am on "/admin/release_importer"
  #     And I attach the file "1234-9876.pdf" to "Files to be Imported"
  #     And I attach the file "1234-9876-o.pdf" to "Files to be Imported"
  #     And I attach the file "wupdate.json" to "Files to be Imported"
  #     And I press "Import"
  #   Then I should see "Imported ALJ Initial Decision Release ID-495"
  #     And I should see "Imported ALJ Initial Decision Release ID-495"
  #     And I should see "Imported Release No. ID-495"
  #     And I should see "Your files were successfully imported."
  #   When I am on "/alj/aljdec"
  #   Then I should not see "ID-495"
  #   When I am on "/alj/aljdec/id-495/edit"
  #     And I click on the element with css selector "#edit-status-value"
  #     And I press "Save"
  #     And I am on "/alj/aljdec"
  #   Then I should see "ID-495"
  #     And I should see the link "Behat ALJ Initial Decisions"
  #     And the hyperlink "Behat ALJ Initial Decisions" should match the Drupal url "/files/alj/aljdec/2013/1234-9876.pdf"
  #     And I should see the text "Release No. ID-495"
  #     And I should see "See also:"
  #     And the hyperlink "Order Instituting Proceedings" should match the Drupal url "/files/litigation/admin/2012/1234-9876-o.pdf"

  # @api @javascript
  # Scenario: Release Import ALJ Orders Using JSON and PDF Files
  #   Given I am logged in as a user with the "Content Creator" role
  #   When I am on "/admin/release_importer"
  #     And I attach the file "1234-9876.pdf" to "Files to be Imported"
  #     And I attach the file "1234-9876-o.pdf" to "Files to be Imported"
  #     And I attach the file "wupdate.json" to "Files to be Imported"
  #     And I press "Import"
  #   Then I should see "Imported ALJ Order Release 1234-9876"
  #     And I should see "Imported Release No. 1234-9876"
  #     And I should see "Your files were successfully imported."
  #   When I am on "/alj/aljorders"
  #   Then I should not see "1234-9876"
  #   When I am on "/alj/aljorders/1234-9876/edit"
  #     And I click on the element with css selector "#edit-status-value"
  #     And I press "Save"
  #     And I am on "/alj/aljorders"
  #   Then I should see "1234-9876"
  #     And I should see the link "Behat ALJ Orders"
  #     And the hyperlink "Behat ALJ Orders" should match the Drupal url "/files/alj/aljorders/2020/1234-9876.pdf"
  #     And I should see the text "Release No. 1234-9876"

  # @api @javascript
  # Scenario: Release Import Litigation Using JSON and PDF Files
  #   Given I am logged in as a user with the "Content Creator" role
  #   When I am on "/admin/release_importer"
  #     And I attach the file "1234-9876.pdf" to "Files to be Imported"
  #     And I attach the file "1234-9876-o.pdf" to "Files to be Imported"
  #     And I attach the file "wupdate.json" to "Files to be Imported"
  #     And I press "Import"
  #   Then I should see "Imported Litigation Release LR-24939"
  #     And I should see "Imported Release No. LR-24939"
  #     And I should see "Your files were successfully imported."
  #   When I am on "/litigation/litreleases"
  #   Then I should not see "LR-24939"
  #   When I am on "/litigation/litreleases/lr-24939/edit"
  #     And I click on the element with css selector "#edit-status-value"
  #     And I press "Save"
  #     And I am on "/litigation/litreleases"
  #   Then I should see "LR-24939"
  #     And I should see the link "Behat Litigation"
  #     And the hyperlink "Behat Litigation" should match the Drupal url "/files/litigation/litreleases/2020/1234-9876.pdf"
  #     And I should see the text "Release No. LR-24939, AAER-4185"

  # @api @javascript
  # Scenario: Release Import Opinions and Adjudicatory Orders Using JSON and PDF Files
  #   Given I am logged in as a user with the "Content Creator" role
  #   When I am on "/admin/release_importer"
  #     And I attach the file "1234-9876.pdf" to "Files to be Imported"
  #     And I attach the file "wupdate.json" to "Files to be Imported"
  #     And I press "Import"
  #   Then I should see "Imported Opinions and Adjudicatory Orders Release 1234-9876"
  #     And I should see "Imported Release No. 1234-9876"
  #     And I should see "Your files were successfully imported."
  #   When I am on "/litigation/opinions"
  #   Then I should not see "1234-9876"
  #   When I am on "/litigation/opinions/1234-9876/edit"
  #     And I click on the element with css selector "#edit-status-value"
  #     And I press "Save"
  #     And I am on "/litigation/opinions"
  #   Then I should see "1234-9876"
  #     And I should see the link "Behat Opinions"
  #     And the hyperlink "Behat Opinions" should match the Drupal url "/files/litigation/opinions/2015/1234-9876.pdf"
  #     And I should see the text "Release No. 1234-9876, IA-4190, IC-31806"

@api @javascript
  Scenario: Release Content Update To Add See Also and File Number Field
    Given I am logged in as a user with the "Content Creator" role
      And "field_file_number" terms:
        | name      |
        | 3-13022  |
      And I create "media" of type "static_file":
        | name                     | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
        | Behat live static file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
        | Behat live static file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
      And I create "media" of type "link":
        | name              | field_media_entity_link                                | status | mid |
        | Behat Page Link   | http://sec.lndo.site/page/enforcement-section-landing  | 1      | 1   |
      And I am on "media/1/edit"
      And I fill in "field_media_entity_link[0][title]" with "External Link"
      And I press "Save"
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Field Update"
      And I select "Trading Suspensions" from "Release Type"
      And I fill in "Release Number" with "rm-123"
      And I fill in "File Number" with "1234ABCD"
      And I fill in "Respondent" with "Ron Burgundy"
      And I press "Add existing Release File"
      And I select the first autocomplete option for "Behat live static file 1" on the "field_release_file[form][0][entity_id]" field
      And I press "Add Release File"
      And I select "Static File" from "edit-field-see-also-actions-bundle"
      And I press "Add new Reference"
      And I fill in the following:
        | field_see_also[form][0][name][0][value] 			         | Behat Stat File |
        | field_see_also[form][0][field_display_title][0][value] | New stat file   |
      And I attach the file "behat-file_rptpub.pdf" to "File Upload"
      And I select "Trading and Markets" from "field_see_also[form][0][field_primary_division_office]"
      And I check "Published"
      And I press "Create Reference"
      And I select "Link" from "field_see_also[actions][bundle]"
      And I scroll "#edit-field-see-also-wrapper" into view
      And I press "Add new Reference"
      And I fill in the following:
        | Name 	    | Behat Link           |
        | URL       | http://sec.lndo.site |
        | Link text | SEC homepage         |
      And I check "Published"
      And I press "Create Reference"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat Page Link" on the "field_see_also[form][2][entity_id]" field
      And I press "Add Reference"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 1" on the "field_see_also[form][3][entity_id]" field
      And I press "Add Reference"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 2" on the "field_see_also[form][4][entity_id]" field
      And I press "Add Reference"
      And I press "Save"
    Then I am on "/litigation/suspensions"
      And I should see "See Also: New stat file , SEC homepage , External Link , Behat 1 , published media"
      And I click "External Link" in the "Ron Burgundy" row
      And I should be on "/page/enforcement-section-landing"
      And I am on "/litigation/suspensions"
      And I click "Behat 1" in the "Ron Burgundy" row
      And I should be on "/files/behat-file_data.pdf"
      And I am on "/litigation/suspensions"
      And I click "published media" in the "Ron Burgundy" row
      And I should be on "/files/behat-file_invalert.pdf"
      And I am on "/litigation/suspensions"
      And I click "New stat file" in the "Ron Burgundy" row
      And I should be on "/files/behat-file_rptpub.pdf"
      And I am on "/litigation/suspensions"
      And I click "SEC homepage" in the "Ron Burgundy" row
      And I should be on "/"
    When I am on "/litigation/suspensions/behat-field-update/edit"
      And I press "Show row weights" in the "see_also" region
      And I select "4" from "field_see_also[entities][0][delta]"
      And I select "2" from "field_see_also[entities][1][delta]"
      And I select "1" from "field_see_also[entities][2][delta]"
      And I select "0" from "field_see_also[entities][4][delta]"
      And I press "Save"
      And I am on "/litigation/suspensions"
      And I should see "See Also: published media , External Link , SEC homepage , Behat 1 , New stat file"

@api @javascript
  Scenario: Create New Release Using Add New Release, Edit and Delete Published Release
    Given I am logged in as a user with the "Content Creator" role
      And I create "media" of type "static_file":
        | name                     | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
        | Behat live static file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
        | Behat live static file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
      And I create "media" of type "link":
        | name              | field_media_entity_link                                | status | mid |
        | Behat Page Link   | http://sec.lndo.site/page/enforcement-section-landing  | 1      | 1   |
      And I am on "media/1/edit"
      And I fill in "field_media_entity_link[0][title]" with "External Link"
      And I press "Save"
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Field Update"
      And I select "Trading Suspensions" from "Release Type"
      And I fill in "Release Number" with "rm-123"
      And I fill in "Respondent" with "Ron Burgundy"
      And I press "Add new Release File"
      And I fill in the following:
        | Name          | New Behat Release           |
        | Display Title | Behat Release Display Title |
      And I attach the file "behat-file_rptpub.pdf" to "File Upload"
      And I select "Administrative Law Judges" from "Primary Division/Office"
      And I check "Published"
      And I press "Create Release File"
      And I scroll "#edit-field-see-also-wrapper" into view
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat Page Link" on the "field_see_also[form][0][entity_id]" field
      And I press "Add Reference"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 1" on the "field_see_also[form][1][entity_id]" field
      And I press "Add Reference"
      And I press "Save"
      And I should see the heading "Ron Burgundy"
    Then I am on "/litigation/suspensions"
      And I should see the link "Ron Burgundy" in the "trading_sus_view" region
      And I should see the link "External Link" in the "trading_sus_view" region
      And I should see the link "Behat 1" in the "trading_sus_view" region
    When I am on "/litigation/suspensions/behat-field-update/edit"
      And I press "ief-field_see_also-form-entity-remove-0"
      And I wait for ajax to finish
      And I press "ief-remove-confirm-field_see_also-form-0"
      And I wait for ajax to finish
      And I scroll "#edit-body-0-value" into view
      And I type "this release been edited" in the "Release Page Content" WYSIWYG editor
      And I press "Save"
      And I should see the heading "Ron Burgundy"
      And I should see the text "this release been edited"
    Then I am on "/litigation/suspensions"
      And I should not see the link "External Link" in the "trading_sus_view" region
    When I am on "/litigation/suspensions/behat-field-update/delete"
      And I press "Delete"
    Then I am on "/litigation/suspensions"
      And I should not see the link "Ron Burgundy" in the "trading_sus_view" region
    When I am on "/litigation/suspensions/behat-field-update"
    Then I should see the heading "Oops! Page Not Found."

  @api @javascript
  Scenario: Create Release With Multiple Release Numbers
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Rlease Number Test"
      And I select "Trading Suspensions" from "Release Type"
      And I fill in "Release Number" with "11-12345"
      And I press "field_release_number_add_more"
      And I fill in "field_release_number[1][value]" with "22-12345"
      And I press "field_release_number_add_more"
      And I fill in "field_release_number[2][value]" with "33-12345"
      And I press "field_release_number_add_more"
      And I fill in "field_release_number[3][value]" with "44-12345"
      And I fill in "Respondent" with "Name"
      And I press "Save"
    Then I am on "/litigation/suspensions"
      And I should see the text "Release No. 11-12345, 22-12345, 33-12345, 44-12345" in the "Name" row
    When I am on "/litigation/suspensions/behat-rlease-number-test/edit"
      And I scroll "#field-release-number-add-more-wrapper" into view
      And I press "Show row weights"
      And I select "3" from "edit-field-release-number-0-weight"
      And I select "0" from "edit-field-release-number-3-weight"
      And I select "2" from "edit-field-release-number-1-weight"
      And I select "1" from "edit-field-release-number-2-weight"
      And I press "Save"
    And I am on "/litigation/suspensions"
      And I should see the text "Release No. 44-12345, 33-12345, 22-12345, 11-12345" in the "Name" row

  @api @javascript
  Scenario: Release Import Error Message Missing Required PDF
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/admin/release_importer"
      And I attach the file "1234-9876.pdf" to "Files to be Imported"
      And I attach the file "wupdate.json" to "Files to be Imported"
      And I press "Import"
    Then I should see the text "The following files are required but were not be uploaded: 1234-9876-o.pdf"

  @api
  Scenario: Release Import Error Message Missing JSON File
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/admin/release_importer"
      And I attach the file "1234-9876.pdf" to "Files to be Imported"
      And I press "Import"
    Then I should see the text "Please include a json file in order to execute this import."

  @api
  Scenario: Release Import Error Message Wrong Stucture JSON File
    Given I am logged in as a user with the "Content Creator" role
    When I am on "/admin/release_importer"
      And I attach the file "wupdate-wrong-structure.json" to "Files to be Imported"
      And I press "Import"
    Then I should see the text "Please include a valid json file in order to execute this import. Syntax error"

  @api @javascript
  Scenario: Verify Comments on Release
    Given I am logged in as a user with the "Content Creator" role
      And "rulemaking_index" terms:
        | name       |
        | ui-98-po   |
        | ab-12-cd   |
      And "customized_comment_form" content:
        | title                              | field_display_title                                  | status | field_file_number | field_rule_path    | field_ruling |
        | Proposed Ruling XYZ Comment Form 1 | Display Title for Proposed Ruling XYZ Comment Form 1 | 1      | ab-12-cd          | /comments/ab-12-cd | ab-12-cd     |
        | Proposed Ruling Form 2             | Title for Proposed Ruling                            | 1      | ui-98-po          | /comments/ui-98-po | ui-98-po     |
    When I am on "/node/add/release"
      And I fill in "Title" with "Behat Field Update"
      And I select "Trading Suspensions" from "Release Type"
      And I fill in "Release Number" with "wer-7987"
      And I fill in "Respondent" with "Adam"
      And I select the first autocomplete option for "Proposed Ruling XYZ Comment Form 1" on the "field_submit_comments[0][target_id]" field
      And I click on the element with css selector "#edit-field-submit-comments-add-more"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Proposed Ruling Form 2" on the "field_submit_comments[1][target_id]" field
      And I press "Save"
      And I am logged in as a user with the "Authenticated user" role
      And I visit "/litigation/suspensions"
    Then I should see the text "Submit Comments on"
      And I should see the link "Proposed Ruling XYZ Comment Form 1"
      And the hyperlink "Proposed Ruling XYZ Comment Form 1" should match the Drupal url "/comments/ab-12-cd/proposed-ruling-xyz-comment-form-1"
      And I should see the link "Proposed Ruling Form 2"
      And the hyperlink "Proposed Ruling Form 2" should match the Drupal url "/comments/ui-98-po/proposed-ruling-form-2"
    When I click "Proposed Ruling XYZ Comment Form 1"
    Then I should see the text "Submit Comments on ab-12-cd"
      And I should see the text "Proposed Ruling XYZ Comment Form 1"
    When I am logged in as a user with the "Content Creator" role
      And I visit "/litigation/suspensions/behat-field-update/edit"
      And I fill in "Submit Comments" with ""
      And I press "Save"
    Then I visit "/litigation/suspensions"
      And I should see the text "Submit Comments on"
      And I should not see the link "Proposed Ruling XYZ Comment Form 1"
      And I should see the link "Proposed Ruling Form 2"
      And the hyperlink "Proposed Ruling Form 2" should match the Drupal url "/comments/ui-98-po/proposed-ruling-form-2"
    When I visit "/litigation/suspensions/behat-field-update/edit"
      And I fill in "Submit Comments" with ""
      And I press "Save"
    Then I visit "/litigation/suspensions"
      And I should not see the text "Submit Comments on"
      And I should not see the link "Proposed Ruling XYZ Comment Form 1"
      And I should not see the link "Proposed Ruling Form 2"

  @api @javascript
  Scenario: Create New Release Using Comments Due and Comments Received Feature
    Given I am logged in as a user with the "Content Creator" role
      And "link" content:
      | title           | field_url                                                   | field_topics            | field_subtopic | field_primary_division_office | status | moderation_state | field_publish_date  |
      | TRG TEST Link 1 | Content Search - https://sec.lndo.site/admin/content/search | Accounting and Auditing | Forms          | Investment Management         | 1      | published        | 2021-09-11 12:00:00 |
      And "news" content:
      | field_news_type_news | field_primary_division_office | title    | status | body                    | field_display_title   | field_publish_date  | field_release_number | field_speaker_name_and_title    | field_alternate_title_secarticle                              |
      | Testimony            | Agency-wide                   | First TM | 1      | This is the first body. | First Behat Testimony | 2018-09-11 12:00:00 | 2018-09              | Commissioner Michael S. Piwowar | <u>RSS</u> <em>Testimony Filer Test</em> <strong>0@0</strong> |
      And "release" content:
      | title             | body         | field_release_type         | field_release_number | field_respondents | moderation_state | nid   |
      | Admin Proceeding1 | detail body1 | Administrative Proceedings | 34-12345             | Allen             | published        | 45687 |
      | Admin Proceeding2 | detail body2 | Administrative Proceedings | 34-23456             | Beverly           | published        | 98457 |
    When I visit "/litigation/admin"
    Then I should not see the text "Comments Due:" in the "Allen" row
    When I visit "/node/45687/edit"
      And I scroll "#edit-field-comments-notice-wrapper" into view
      And I type "Behat due 1/1/2030" in the "Comments Due Text" WYSIWYG editor
      And I select the first autocomplete option for "TRG TEST Link 1" on the "field_comments_received[0][uri]" field
      And I fill in "field_comments_received[0][title]" with "Link1"
      And I press "field_comments_received_add_more"
      And I wait for ajax to finish
      And I select the first autocomplete option for "First TM" on the "field_comments_received[1][uri]" field
      And I fill in "field_comments_received[1][title]" with "Link2"
      And I press "field_comments_received_add_more"
      And I wait for ajax to finish
      And I fill in "field_comments_received[2][uri]" with "https://sec.lndo.site/"
      And I fill in "field_comments_received[2][title]" with "Link3"
      And I press "field_comments_received_add_more"
      And I wait for ajax to finish
      And I fill in "field_comments_received[3][uri]" with "https://www.google.com/"
      And I press "Save"
    Then I visit "/litigation/admin"
      And I should see the link "Allen"
      And I should see the text "Comments Due: Behat due 1/1/2030" in the "Allen" row
      And I should see the text "Comments Received: Link1, Link2, Link3, https://www.google.com/" in the "Allen" row
    When I click "Link1" in the "Allen" row
      And I switch to the new window
    Then I should be on "/admin/content/search"
      And I visit "/litigation/admin"
    When I click "Link2" in the "Allen" row
      And I switch to the new window
    Then I should be on "/news/testimony/first-tm"
      And I visit "/litigation/admin"
    When I click "Link3" in the "Allen" row
      And I switch to the new window
    Then I should be on "/"
    When I visit "/node/45687/edit"
      And I fill in "field_comments_due_date[0][value][date]" with "12/31/2031"
      And I press "Save"
      And I visit "/litigation/admin"
    Then I should see the text "Comments Due: December 31, 2031" in the "Allen" row
      And I should not see the text "Comments Due: Behat due 1/1/2030" in the "Allen" row
      And I should not see the text "Comments Due:" in the "Beverly" row
      And I should not see the text "Comments Received:" in the "Beverly" row
      And I close the current window
