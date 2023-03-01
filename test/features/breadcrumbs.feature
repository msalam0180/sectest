Feature: Breadcrumbs
  As a site visitor
  I want to see easy navigation of the site with the use of uswdssec theme breadcrumbs
  So that visitors to SEC.gov can view dynamic breadcrumbs under the global navigation

@api @javascript
Scenario: Confirm Breadcrumbs And Heading for Several Content types
  Given I am logged in as a user with the "sitebuilder" role
    And "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray                  | 2020-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       |
    And "secarticle" content:
    | title                                                                         | field_display_title                                   | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
    | PDF having article type as Announcement and Division as Investment Management | DT Announcement and Division as Investment Management | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Investment Management         | 123-KO               | Auditors       | Securities Act of 1933 |
    And "secarticle" content:
    | title        | field_display_title               | body   | field_publish_date  | status | field_article_type_secarticle | field_primary_division_office |
    | Behat Test 1 | Donald is Leaving the Team Today  | Test 1 | 2020-06-05T17:00:00 | 1      | Announcement                  | Corporation Finance           |
    And "release" content:
    | title               | body         | field_release_type  | field_release_number | field_respondents | moderation_state | field_publish_date |
    | Trading Suspension1 | detail body1 | Trading Suspensions | 34-12345             | Allen             | published        | -10 days           |
    And "landing_page" content:
    | title                                             | field_tags                     | promote | field_display_title                        | body                                       | field_description_abstract                                      | moderation_state | status |
    | BEHAT We Regulate Securities Markets Landing Page | We Regulate Securities Markets | 1       | BEHAT We Regulate Securities Markets Title | BEHAT We Regulate Securities Markets Body  | This is the We Regulate Securities Markets description abstract | published        | 1      |
    And "news" content:
    | field_news_type_news | field_primary_division_office | title     | status | body                     | field_display_title    | field_publish_date  | field_release_number | field_speaker_name_and_title    | field_alternate_title_secarticle                              |
    | Testimony            | Agency-wide                   | First TM  | 1      | This is the first body.  | First Behat Testimony  | 2018-09-11 12:00:00 | 2018-09              | Commissioner Michael S. Piwowar | <u>RSS</u> <em>Testimony Filer Test</em> <strong>0@0</strong> |
  When I visit "/admin/appearance"
    #switching theme to uswdssec
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
    And I am logged in as a user with the "authenticated user" role
    And I visit "/"
  Then I should not see the css selector "#block-uswdssec-breadcrumbs > nav"
  When I visit "/corpfin/announcement/behat-test-1"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the link "Division of Corporation Finance" in the "breadcrumb" region
    And I should see the text "Donald is Leaving the Team Today" in the "breadcrumb" region
    And I should see the heading "Donald is Leaving the Team Today"
    And I should not see the heading "Behat Test 1"
  When I visit "/corpfin/announcement"
  Then I should see "Error 404: Page Not Found"
    And I should not visibly see the link "Home"
  When I visit "/corpfin"
  Then I should see the heading "Division of Corporation Finance"
  When I visit "dera/academic-publications/behat-publication-0"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the link "Economic and Risk Analysis" in the "breadcrumb" region
    And I should see the link "Publications" in the "breadcrumb" region
    And I should see the text "Behat Test 0" in the "breadcrumb" region
    And I should see the heading "Behat Test 0"
    And I should not see the heading "Behat Publication 0"
  When I click on the element with css selector "#block-uswdssec-breadcrumbs > nav > div > ol > li:nth-child(3) > a"
  Then I should see the heading "Publications"
  When I click on the element with css selector "#block-uswdssec-breadcrumbs > nav > div > ol > li:nth-child(2) > a"
  Then I should see the heading "Economic and Risk Analysis"
  When I visit "/investment/announcement/pdf-having-article-type-announcement-and-division-investment-management"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the link "Investment Management" in the "breadcrumb" region
    And I should see the text "DT Announcement and Division as Investment Management" in the "breadcrumb" region
    And I should see the heading "DT Announcement and Division as Investment Management"
    And I should not see the heading "PDF having article type as Announcement and Division as Investment Management"
  When I click on the element with css selector "#block-uswdssec-breadcrumbs > nav > div > ol > li:nth-child(2) > a"
  Then I should see the heading "Division of Investment Management"
  When I visit "/news/testimony/first-tm"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the link "Newsroom" in the "breadcrumb" region
    And I should see the text "First Behat Testimony" in the "breadcrumb" region
    And I should see the heading "First Behat Testimony"
  When I click on the element with css selector "#block-uswdssec-breadcrumbs > nav > div > ol > li:nth-child(2) > a"
  Then I should see the heading "Newsroom"
  When I visit "/litigation/suspensions/trading-suspension1"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the link "Trading Suspensions" in the "breadcrumb" region
    And I should see the text "Trading Suspension1" in the "breadcrumb" region
    And I should see the heading "Trading Suspension1"
  When I click on the element with css selector "#block-uswdssec-breadcrumbs > nav > div > ol > li:nth-child(2) > a"
  Then I should see the heading "Trading Suspensions"
  When I visit "/page/behat-we-regulate-securities-markets-landing-page"
  Then I should see the link "Home" in the "breadcrumb" region
    And I should see the text "BEHAT We Regulate Securities Markets Title" in the "breadcrumb" region
    And I should see the heading "BEHAT We Regulate Securities Markets Title"
    And I should not see the heading "BEHAT We Regulate Securities Markets Landing Page"
  # Return the theme back to normal
  When I am logged in as a user with the "sitebuilder" role
   And I visit "/admin/appearance"
   And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"
  Then I should see the text "Please note that the administration theme is still set to the Adminimal theme; consequently, the theme on this page remains unchanged. All non-administrative sections of the site, however, will show the selected SECGOV theme by default."
