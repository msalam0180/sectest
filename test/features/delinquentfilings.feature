Feature: Delinquent Filings List Page
As a user to the site, I should be able to view delinquent filing release contents

@api @javascript
Scenario: Validate Delinquent Filings View Page
  Given "rulemaking_index" terms:
      | name     |
      | ui-98-po |
    And "customized_comment_form" content:
      | title        | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
      | Comment Form | Display Title for 1 | 1      | ui-98-po          | /comments/ui-98-po | ui-98-po     |
    And "division_office" terms:
      | name              |
      | office of justice |
    And I create "media" of type "static_file":
      | name                      | field_display_title | field_media_file    | field_description_abstract | status |
      | Behat Cats Static 1stFile | published media     | behat-file_data.pdf | This is description abs    | 1      |
      | Behat Cats Static File2   | published media2    | behat-file_foia.pdf | This is description abs2   | 1      |
  When I am logged in as a user with the "Content Creator" role
    And I am on "/node/add/release"
    And I fill in "Title" with "Behat Delinquent Filing"
    And I select "ALJ Orders" from "Release Type"
    And I check the box "Delinquent Filing"
    And I fill in "Release Number" with "34-12345"
    And I select the first autocomplete option for "ui-98-po" on the "File Number" field
    And I fill in "Respondents" with "Behat v. You"
    And I press "Add existing Release File"
    And I select the first autocomplete option for "Behat Cats Static 1stFile" on the "field_release_file[form][0][entity_id]" field
    And I press "Add Release File"
    And I fill in "edit-field-publish-date-0-value-date" with "01-01-2021"
    And I scroll "#edit-body-wrapper" into view
    And I type "Detail body of Behat ALJ Orders" in the "Release Page Content" WYSIWYG editor
    And I select "office of justice" from "Primary Division/Office"
    And I press "Save"
  Then I am on "/divisions/enforce/delinquent/delinqindex"
    And I should see the heading "Releases Related to Delinquent Filings"
    And I should see the css selector "#section-menu"
    And I should see the link "Enforcement" in the navigation region
    And I should see the link "Trading Suspensions" in the navigation region
    And I should see the link "Administrative Proceedings" in the navigation region
    And I should see the css selector "#sidebar-first > aside > nav"
    And I should see the text "Release No. 34-12345" in the "Behat v. You" row
    And I should see the date "Jan. 1, 2021" in the "Behat v. You" row
  When I click "Behat v. You"
  Then I should be on "/files/behat-file_data.pdf"

@api @javascript
Scenario: Validate Delinquent List Page Header and Quick Links
  Given "release" content:
    | title           | body         | field_release_type         | field_release_number         | field_respondents | status | field_publish_date | field_delinquent_filings | field_release_file |
    | ReleaseContent1 | detail body1 | Administrative Proceedings | 34-12345, 34-12355, 34-45687 | Allen             | 1      | -10 days           | 1                        |                    |
    And I am logged in as a user with the "authenticated" role
  When I am on "/divisions/enforce/delinquent/delinqindex"
    And I click "Allen"
  Then I should be on "/litigation/admin/releasecontent1"
    And I should see the heading "Allen"
    And I should see "detail body1"
  When I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#filter > div > div.subscribe-rss > a"
  Then I should see "<title>Allen</title>"
  #add custom quick links
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Customize Quick Links" from "field_quick_links"
    And I fill in "field_customized_quick_links[0][uri]" with "http://sec.lndo.site/edgar/about"
    And I fill in "field_customized_quick_links[0][title]" with "EDGAR"
    And I press "field_customized_quick_links_add_more"
    And I fill in "field_customized_quick_links[1][uri]" with "https://www.google.com"
    And I fill in "field_customized_quick_links[1][title]" with "External Google Link"
    And I press "Save"
  When I am logged in as a user with the "authenticated user" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click "EDGAR"
  Then I should see the heading "About EDGAR"
  When I am on "/divisions/enforce/delinquent/delinqindex"
  And I should see the "a" element with the "href" attribute set to "https://www.google.com" in the "delinquint_view_topper" region
  #alternate quick links
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Show Alternate Default Quick Links" from "field_quick_links"
    And I press "Save"
  When I am logged in as a user with the "authenticated user" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
  Then I should see the link "Litigated AP Case Materials (Open)"
    And I should see the link "Litigated AP Case Materials (Closed)"
    And I should see the link "Electronic Filings in Administrative Proceedings (eFAP)"
  #hide quick links
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Hide Quick Links" from "field_quick_links"
    And I press "Save"
  When I am logged in as a user with the "authenticated user" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
  Then I should not see "Quick Links"
    And I should not see the link "Litigated AP Case Materials (Open)"
  #default quicklinks
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Show Default Quick Links" from "field_quick_links"
    And I press "Save"
  When I am logged in as a user with the "authenticated user" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I should see "Quick Links"
  When I click "Litigated AP Case Materials (Open)"
  Then I should see the heading "Open Administrative Proceeding Cases"
  When I am on "/divisions/enforce/delinquent/delinqindex"
    And I click "Litigated AP Case Materials (Closed)"
  Then I should see the heading "Closed Administrative Proceeding Cases"

@api @javascript
Scenario: Validate Delinquent List Sorting
  Given I create "media" of type "static_file":
    | name                      | field_display_title | field_media_file    | field_description_abstract | status |
    | Behat Cats Static 1stFile | published media     | behat-file_data.pdf | This is description abs    | 1      |
    And "release" content:
    | title           | body         | field_release_type               | field_release_number           | field_respondents | status | field_publish_date | field_delinquent_filings | field_release_file        |
    | ReleaseContent1 | detail body1 | Administrative Proceedings       | 34-12345, 34-12355, 34-45687   | Allen             | 1      | -10 days           | 1                        |                           |
    | ReleaseContent2 | detail body2 | ALJ Initial Decisions            | 34-23456                       | Beverly           | 1      | -20 days           | 1                        |                           |
    | ReleaseContent3 | detail body3 | ALJ Orders                       | 34-34567                       | Caroline          | 1      | -25 days           | 1                        |                           |
    | ReleaseContent4 | detail body4 | Litigation Releases              | 34-45678                       | David             | 1      | 01-01-2021         | 1                        |                           |
    | ReleaseContent5 | detail body5 | Opinions and Adjudicatory Orders | 34-56789                       | Edward            | 1      | 15-01-2021         | 1                        |                           |
    | ReleaseContent6 | detail body6 | Stop Orders                      | 34-67890                       | Franky            | 1      | 03-03-2021         | 1                        |                           |
    | ReleaseContent7 | detail body7 | Trading Suspensions              | 34-78901                       | Grover            | 1      | 02-02-2020         | 1                        | Behat Cats Static 1stFile |
    | ReleaseContent8 | detail body8 | Trading Suspensions              | 34-78901                       | Hanry             | 1      | 15-02-2020         | 1                        |                           |
    | ReleaseContent9 | detail body9 | Trading Suspensions              | 34-88888                       | Ivan              | 1      | 15-02-2020         | 0                        |                           |
    | ReleaseContent0 | detail body0 | Trading Suspensions              | 34-19991                       | Jerry             | 0      | 15-02-2020         | 1                        |                           |
    And I am logged in as a user with the "authenticated" role
  When I am on "/divisions/enforce/delinquent/delinqindex"
  Then I should not see the link "Ivan"
    And I should not see the link "Jerry"
    And I should see the link "Beverly" before I see the link "Caroline" in the "Releases" view
    And I should see the link "Allen" before I see the link "Beverly" in the "Releases" view
    And I should see the link "Caroline" before I see the link "Franky" in the "Releases" view
  When I click the sort filter "Date"
  Then I should see the link "Caroline" before I see the link "Allen" in the "Releases" view
  When I select "2021" from "Year"
  Then I should see the link "Franky" before I see the link "David" in the "Releases" view
    And I should not see the link "Hanry" in the "trading_sus_view" region
  When I select "January" from "Month"
  Then I should see the link "Edward" before I see the link "David" in the "Releases" view
    And I should not see the link "Franky" in the "trading_sus_view" region
  When I select "2020" from "Year"
    And I select "February" from "Month"
    And I click the sort filter "Respondents"
  Then I should see the link "Grover" before I see the link "Hanry" in the "Releases" view
