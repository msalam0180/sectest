Feature: Drupal Admin Search
  As a Drupal Content Creator
  When I visit the Admin Drupal Search Page, I want to search content using search boxes on the list of searchable fields
  So that users can filter with any field

#Scenario: Validate all users who have access to search

Background:
  Given "division_office" terms:
      | name                |
      | DERA                |
      | Corpfin             |
    And "secarticle" content:
      | field_article_type_secarticle | moderation_state | title                  | field_display_title   | status | changed |
      | Data                          | draft            | Behat Article Test 1   | Bad Title             | 0      | +90 day |
      | Academic Publications         | published        | Behat Article Test 2   | Good Title            | 1      | 1 month |
      | Forms                         | published        | Behat Article Test 3   | Sad Title             | 1      | 2 month |
      | Fast Answers                  | published        | Behat Article Test 4   | Awesome Title         | 1      | +1 day  |
      | Other                         | published        | Behat Article Test 5   | Wonderful Title       | 1      | +2 day  |
      | Award Claim                   | published        | Behat Article Test 6   | Boxing Title          | 1      | +3 day  |
      |                               | published        | Behat Article Test 7   | Common Title          | 1      | now     |
    And "news" content:
       | field_news_type_news   |   title        | status |  field_display_title          | field_publish_date  | moderation_state | changed |
       | Testimony              |  First TM      | 0      | First Behat Testimony         | 2018-09-11 07:00:00 | draft            | +91 day |
       | Testimony              |  Second TM     | 1      | Second Behat Testimony        | 2018-09-12 08:00:00 | published        | 4 month |
       | Speech                 |  First SP      | 1      | First Behat Speech            | 2018-10-13 09:00:00 | published        | 5 month |
       | Speech                 |  Second SP     | 1      | Second Behat Speech           | 2018-10-14 10:00:00 | published        | +4 day  |
       | Statement              |  First PS      | 1      | First Behat Statement         | 2018-11-15 11:00:00 | published        | +5 day  |
       | Statement              |  Second PS     | 1      | Second Behat Statement        | 2018-11-16 12:00:00 | published        | +6 day  |
       | Press Release          |  First New PR  | 1      | First New Press Release       | 2018-12-17 13:00:00 | published        | +7 day  |
       | Press Release          |  Second New PR | 1      | Second New Press Release      | 2018-12-18 14:00:00 | published        |         |
    And "webcast" content:
       | title                      | field_display_title   | moderation_state   | changed | status | field_publish_date  |
       | BEHAT Test Webcast Content | My Webcast            | published          | +1 hour | 1      | 2018-12-19 15:00:00 |
    And "event" content:
      | title                    | status | moderation_state | changed |
      | BEHAT Test Event Content | 1      | published        | +2 hour |
    And "secperson" content:
      | title        | field_first_name_secperson | field_last_name_secperson |
      | Gary Lineker | Gary                       | Lineker                   |
      | David Platt  | David                      | Platt                     |

@api
#PASS
Scenario: Verify all fields exist in the Drupal search view
  Given I am logged in as a user with the "content_creator" role
    And I am on "/admin/content/search"
  Then I should see the text "Title"
    And I should see the text "Display Title"
    And I should see the text "Primary Division / Office"
    And I should see the text "Supporting Division / Office"
    And I should see the text "News Type"
    And I should see the text "Article Type"
    And I should see the text "Article SubType"
    And I should see the text "Authored by"
    And I should see the text "Free Text (All Fields)"
    And I should see the text "ID"
    And I should see the text "Person"
    And I should see the text "Edited by"

#TODO: There are more fields than this, but this is what was in the original test cases, and I transformed them below.
#Someone needs to add the additional fields to test
@api @javascript
Scenario Outline: Search Admin Content By Field
  Given "secarticle" content:
    | field_article_type_secarticle | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
    | Other                         | published        | This is the BEHAT title   | This is the BEHAT display title   | 1      | This is the body     | Corpfin                       |
    | Other                         | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | Corpfin                       |
    And I am logged in as a user with the "content_creator" role
  When I am on "/admin/content/search"
    And I fill in "<FieldName>" with "<SearchValue>"
    And I press "Filter"
    And I wait for Ajax to finish
  Then I should see the link "This is the BEHAT title"
    And I should not see the link "This is the NOT the title"

  Examples:
  | FieldName                 | SearchValue                     |
  | title_3                   | This is the BEHAT title         |
  | field_display_title_value | This is the BEHAT display title |

@api @javascript @failed
#FAIL: OSSS-8359 created- filter criteria for division/office field on search view is incorrect. Hence, incorrect search results are being displayed
Scenario Outline: Search Admin Content By Selectors
  Given "secarticle" content:
      | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
      | Data                          | Market Structure              | published        | This is the BEHAT title   | This is the BEHAT display title   | 1      | This is the body     | Corpfin                       |
      | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | DERA                          |
    And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title                     | status | body                     | field_display_title               | field_person |
      | Press Release        | Agency-wide                   | published        | This is the BEHAT title   | 1      | This is the first body.  | This is the BEHAT display title   | Gary Lineker |
      | Speech               | Agency-wide                   | published        | This is the NOT the title | 1      | This is the second body. | This is the NOT the display title | David Platt  |
    And I am logged in as a user with the "content_creator" role
  When I am on "/admin/content/search"
    And I select "<Selector>" from "<Field>"
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the link "This is the BEHAT title"
    And I should not see the link "This is the NOT the title"

   Examples:
      | Selector      | Field                     |
      | Data          | Article Type              |
      | Press Release | News Type                 |
      | Gary Lineker  | Person                    |
      | Corpfin       | Primary Division / Office |

@api @javascript
Scenario: Search Admin Content By Article SubType Selector
  Given "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title                     | field_display_title               | status | body                 | field_primary_division_office |
    | Data                          | Data-MarketStructure          | published        | This is the BEHAT title   | This is the BEHAT display title   | 1      | This is the body     | Corpfin                       |
    | Other                         | - None -                      | published        | This is the NOT the title | This is the NOT the display title | 1      | This is NOT the body | DERA                          |
    And I am logged in as a user with the "content_creator" role
  When I am on "/admin/content/search"
    And I select "Data" from "Article Type"
    And I wait for ajax to finish
    And I select "Market Structure" from "Article SubType"
    And I press "Filter"
    And I wait for ajax to finish
  Then I should see the link "This is the BEHAT title"
    And I should not see the link "This is the NOT the title"

@api @javascript
Scenario: Admin Content View Title Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "Article" from "Content type"
    And I additionally select "Event" from "Content type"
    And I additionally select "News" from "Content type"
    And I additionally select "Webcast" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "Title"
    And I wait for AJAX to finish
  Then "Behat Article Test 1" should precede "Behat Article Test 2" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Behat Article Test 3" should precede "Behat Article Test 4" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "BEHAT Test Event Content" should precede "BEHAT Test Webcast Content" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "First New PR" should precede "First TM" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Second PS" should precede "Second SP" for the query "//td[contains(@class, 'views-field views-field-title')]"
  When I click the sort filter "Title"
    And I wait for AJAX to finish
  Then "Behat Article Test 7" should precede "Behat Article Test 5" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Behat Article Test 3" should precede "Behat Article Test 1" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "BEHAT Test Webcast Content" should precede "BEHAT Test Event Content" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "First TM" should precede "First SP" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Second TM" should precede "Second PS" for the query "//td[contains(@class, 'views-field views-field-title')]"

@api @javascript
Scenario: Admin Content View Display Title Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "Article" from "Content type"
    And I additionally select "Event" from "Content type"
    And I additionally select "News" from "Content type"
    And I additionally select "Webcast" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "Display Title"
    And I wait for AJAX to finish
  Then "Awesome Title" should precede "Bad Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Common Title" should precede "First Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First New Press Release" should precede "Good Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "My Webcast" should precede "Sad Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Second Behat Statement" should precede "Wonderful Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Display Title"
    And I wait for AJAX to finish
  Then "Wonderful Title" should precede "Second Behat Statement" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Sad Title" should precede "My Webcast" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Good Title" should precede "First New Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First Behat Statement" should precede "Common Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Bad Title" should precede "Awesome Title" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Admin Content View Content Type Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "Article" from "Content type"
    And I additionally select "Event" from "Content type"
    And I additionally select "News" from "Content type"
    And I additionally select "Webcast" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "Content Type"
    And I wait for AJAX to finish
  Then "Event" should precede "News" for the query "//td[contains(@class, 'views-field views-field-type')]"
    And "News" should precede "Article" for the query "//td[contains(@class, 'views-field views-field-type')]"
    And "Article" should precede "Webcast" for the query "//td[contains(@class, 'views-field views-field-type')]"
  When I click the sort filter "Content Type"
    And I wait for AJAX to finish
  Then "Webcast" should precede "Article" for the query "//td[contains(@class, 'views-field views-field-type')]"
    And "Article" should precede "News" for the query "//td[contains(@class, 'views-field views-field-type')]"
    And "News" should precede "Event" for the query "//td[contains(@class, 'views-field views-field-type')]"

@api @javascript
Scenario: Admin Content View Article Type Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "Article" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "Article Type"
    And I wait for AJAX to finish
  Then "Academic Publications" should precede "Award Claim" for the query "//td[contains(@class, 'views-field views-field-title-1')]"
    And "Data" should precede "Fast Answers" for the query "//td[contains(@class, 'views-field views-field-title-1')]"
    And "Forms" should precede "Other" for the query "//td[contains(@class, 'views-field views-field-title-1')]"
  When I click the sort filter "Article Type"
    And I wait for AJAX to finish
  Then "Other" should precede "Forms" for the query "//td[contains(@class, 'views-field views-field-title-1')]"
    And "Fast Answers" should precede "Data" for the query "//td[contains(@class, 'views-field views-field-title-1')]"
    And "Award Claim" should precede "Academic Publications" for the query "//td[contains(@class, 'views-field views-field-title-1')]"

@api @javascript
Scenario: Admin Content View News Type Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "News" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "News Type"
    And I wait for AJAX to finish
  Then "Press Release" should precede "Statement" for the query "//td[contains(@class, 'views-field views-field-title-2')]"
    And "Speech" should precede "Statement" for the query "//td[contains(@class, 'views-field views-field-title-2')]"
    And "Speech" should precede "Testimony" for the query "//td[contains(@class, 'views-field views-field-title-2')]"
  When I click the sort filter "News Type"
    And I wait for AJAX to finish
  Then "Testimony" should precede "Statement" for the query "//td[contains(@class, 'views-field views-field-title-2')]"
    And "Statement" should precede "Speech" for the query "//td[contains(@class, 'views-field views-field-title-2')]"
    And "Speech" should precede "Press Release" for the query "//td[contains(@class, 'views-field views-field-title-2')]"

@api @javascript
Scenario: Admin Content View Updated Sorting
  Given I am logged in as a user with the "content_creator" role
  When I visit "/admin/content/search"
    And I select "Article" from "Content type"
    And I additionally select "Event" from "Content type"
    And I additionally select "News" from "Content type"
    And I additionally select "Webcast" from "Content type"
    And I press "Filter"
    And I wait for AJAX to finish
    And I click the sort filter "Updated"
    And I wait for AJAX to finish
  Then "Second New PR" should precede "BEHAT Test Webcast Content" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Behat Article Test 6" should precede "Second SP" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Second TM" should precede "First SP" for the query "//td[contains(@class, 'views-field views-field-title')]"
  When I click the sort filter "Updated"
    And I wait for AJAX to finish
  Then "First SP" should precede "Second TM" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "Second SP" should precede "Behat Article Test 6" for the query "//td[contains(@class, 'views-field views-field-title')]"
    And "BEHAT Test Webcast Content" should precede "Second New PR" for the query "//td[contains(@class, 'views-field views-field-title')]"
