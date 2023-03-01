Feature: Account and Auditing Release View
As a user to the site, I should be able to view Accounts and Auditing related contents

@api
Scenario: Validate Fields to Show on Accounting and Auditing View Page
  Given "rulemaking_index" terms:
      | name     |
      | ui-98-po |
    And "customized_comment_form" content:
      | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
      | Comment behat | Display Title for 1 | 1      | ui-98-po          | /comments/ui-98-po | ui-98-po     |
    And I create "media" of type "static_file":
      | name          | field_display_title | field_media_file    | field_description_abstract | status |
      | Behat 1stFile | published media     | behat-file_data.pdf | This is description abs    | 1      |
    And I create "media" of type "link":
      | name           | field_media_entity_link                                | status |
      | Behat Link     | https://sec.lndo.site/page/enforcement-section-landing | 1      |
      | Behat External | http://google.com                                      | 1      |
    And I am viewing an "release" content:
      | title                        | This is the title          |
      | field_comments_due_date      | 2021-02-02 12:00:00        |
      | field_comments_notice        | Note                       |
      | field_delinquent_filings     | 1                          |
      | field_release_file_number    | ui-98-po                   |
      | field_primary_division_office| Enforcement                |
      | field_release_file           | Behat 1stFile              |
      | field_release_number         | AAER-234, 2-12312          |
      | body                         | This is the body           |
      | field_publish_date           | 2021-02-02 12:00:00        |
      | field_release_type           | Administrative Proceedings |
      | field_respondents            | Frank                      |
      | field_see_also               | Behat Link, Behat External |
      | moderation_state             | published                  |
      | field_submit_comments        | Comment behat              |
    And I am logged in as a user with the "authenticated" role
  When I am on "/divisions/enforce/friactions"
  Then I should see the heading "Accounting and Auditing Enforcement Releases"
    And I should see the text "The list below provides links to financial reporting related enforcement actions concerning civil lawsuits brought by the Commission in federal court and notices and orders concerning the institution and/or settlement of administrative proceedings. This list only highlights certain actions and is not meant to be a complete and exhaustive compilation of all of the actions that fall into this category."
    And I should see the link "Enforcement" in the navigation region
    And I should see the text "Release No. AAER-234, 2-12312" in the "Frank" row
    And I should see the link "https://sec.lndo.site/page/enforcement-section-landing"
    And I should see the link "http://google.com"
    And I should see the date "Feb. 2, 2021" in the "Frank" row
    And I should not see "Comments Due: Note"
    And I should not see "Submit Comments on: Comment behat"
  When I click "Frank"
  Then I should be on "/files/behat-file_data.pdf"

@api @javascript
Scenario: Sorting and Filtering of Accounting Items
  Given "release" content:
    | title | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date |
    | AP1   | Administrative Proceedings | AAER-12345           | Allen             | published        | -10 days           |
    | AP2   | Administrative Proceedings | AAER-23456           | Beverly           | published        | -20 days           |
    | AP3   | Administrative Proceedings | AAER-34567           | Caroline          | published        | -25 days           |
    | AP4   | Administrative Proceedings | AAER-45678           | David             | published        | 01-01-2021         |
    | AP5   | Administrative Proceedings | AAER-56789           | Edward            | published        | 15-01-2021         |
    | AP6   | Administrative Proceedings | AAER-67890           | Franky            | published        | 03-03-2021         |
    | AP7   | Administrative Proceedings | AAER-78901           | Grover            | published        | 02-02-2020         |
    | AP8   | Administrative Proceedings | AAER-78901           | Henry             | published        | 15-02-2020         |
    And I am logged in as a user with the "authenticated" role
  When I am on "/divisions/enforce/friactions"
  Then I should see the link "Allen" before I see the link "Beverly" in the "Releases" view
    And I should see the link "Beverly" before I see the link "Caroline" in the "Releases" view
    And I should see the link "Caroline" before I see the link "Franky" in the "Releases" view
  When I click the sort filter "Date"
  Then I should see the link "Beverly" before I see the link "Allen" in the "Releases" view
    And I should see the link "Caroline" before I see the link "Beverly" in the "Releases" view
    And I should see the link "Franky" before I see the link "Caroline" in the "Releases" view
    And I should see the link "Grover" before I see the link "Henry" in the "Releases" view
  When I click the sort filter "Date"
  Then I should see the link "Caroline" before I see the link "Franky" in the "Releases" view
    And I should see the link "Beverly" before I see the link "Franky" in the "Releases" view
    And I should see the link "Caroline" before I see the link "Edward" in the "Releases" view
    And I should see the link "Allen" before I see the link "Beverly" in the "Releases" view
  When I click the sort filter "Respondents"
  Then I should see the link "Allen" before I see the link "Beverly" in the "Releases" view
    And I should see the link "Caroline" before I see the link "David" in the "Releases" view
    And I should see the link "David" before I see the link "Edward" in the "Releases" view
  When I click the sort filter "Respondents"
  Then I should see the link "Henry" before I see the link "Grover" in the "Releases" view
    And I should see the link "Grover" before I see the link "Franky" in the "Releases" view
    And I should see the link "Franky" before I see the link "Edward" in the "Releases" view
  When I select "2021" from "Year"
  Then I should see the link "Franky" before I see the link "David" in the "Releases" view
    And I should not see the link "Henry"
  When I select "January" from "Month"
  Then I should see the link "Edward" before I see the link "David" in the "Releases" view
    And I should not see the link "Franky"
  When I select "2020" from "Year"
    And I select "February" from "Month"
    And I click the sort filter "Respondents"
  Then I should see the link "Grover" before I see the link "Henry" in the "Releases" view

@api
Scenario: Multiple Values Release Numbers, See Also for Accounting and Auditing
  Given I create "media" of type "link":
      | name     | field_media_entity_link                                | status | mid |
      | Internal | https://sec.lndo.site/page/enforcement-section-landing | 1      | 1   |
      | External | http://google.com                                      | 1      | 2   |
    And I am viewing an "release" content:
      | title                | This is the title          |
      | field_release_number | AAER-234, AAER-12312       |
      | field_respondents    | Sabrina                    |
      | field_see_also       | Internal, External         |
      | moderation_state     | published                  |
      | field_publish_date   | 2021-02-02 12:00:00        |
      | field_release_type   | Administrative Proceedings |
    And I am logged in as a user with the "authenticated" role
  When I visit "/divisions/enforce/friactions"
  Then I should see the link "Sabrina"
    And I should see the text "AAER-234, AAER-12312" in the "Feb. 2, 2021" row
    And I should see "See Also: https://sec.lndo.site/page/enforcement-section-landing , http://google.com" in the "Feb. 2, 2021" row

@api @javascript
Scenario: Update Custom Block Accounts and Audits Enforcement Releases Topper
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/divisions/enforce/friactions"
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
    And I select "Show Default Quick Links" from "Quick Links"
    And I press "Save"
    And I am logged in as a user with the "authenticated" role
    And I am on "/divisions/enforce/friactions"
  Then I should see the text "Quick Links"
    And I should see the link "Litigated AP Case Materials (Open)"
    And I should see the link "Litigated AP Case Materials (Closed)"
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/friactions"
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
    And I select "Show Alternate Default Quick Links" from "Quick Links"
    And I press "Save"
    And I am logged in as a user with the "authenticated" role
    And I am on "/divisions/enforce/friactions"
  Then I should see the text "Quick Links"
    And I should see the link "Litigated AP Case Materials (Open)"
    And I should see the link "Litigated AP Case Materials (Closed)"
    And I should see the link "Electronic Filings in Administrative Proceedings (eFAP)"
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/friactions"
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
    And I select "Customize Quick Links" from "Quick Links"
    And I fill in "field_customized_quick_links[0][uri]" with "/litigation/admin"
    And I fill in "field_customized_quick_links[0][title]" with "Admin Page"
    And I press "Save"
    And I am logged in as a user with the "authenticated" role
    And I am on "/divisions/enforce/friactions"
  Then I should see the text "Quick Links"
    And I should see the link "Admin Page"
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/friactions"
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-accountsandauditsenforcementreleasestopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
    And I select "Hide Quick Links" from "Quick Links"
    And I press "Save"
    And I am logged in as a user with the "authenticated" role
    And I am on "/divisions/enforce/friactions"
  Then I should not see the text "Quick Links"
