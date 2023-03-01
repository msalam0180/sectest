Feature: Investor Alerts and Bulletins
  As a visitor to investor.gov, user should be able to view Alerts and Bulletins

@api @investor
Scenario: Investor Alerts and Bulletins Homepage Link
  Given I am on "/"
    And I should see the text "Investor Alerts And Bulletins"
    And the hyperlink "More Alerts and Bulletins" should match the Drupal url "/additional-resources/news-alerts/alerts-bulletins"
  When I click "More Alerts and Bulletins"
  Then I should see the text "INVESTOR ALERTS AND BULLETINS"

@api @investor
Scenario: Investor Alerts Bulletins and PR No Results Search
  Given I am on "/"
    And I click "More Alerts and Bulletins"
  When I fill in "Keyword" with "inbestor"
    And I select "Any" from "News Type"
    And I press "edit-submit-news-alerts"
  Then I should see the text "Your search Yielded No Results"

@api @javascript @investor
Scenario: Search for Alerts
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/news"
    And I fill in "Title" with "Investor Behat Test Alert"
    And I wait 1 seconds
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Alert Stark Summary"
    And I wait 1 seconds
    And I select "Investor Alerts" from "News Type"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
    And I wait 1 seconds
  Then I should see the text "News Investor Behat Test Alert has been created."
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    And I fill in "Keyword" with "Investor Behat Test Alert Stark Summary"
    And I select "Any" from "News Type"
    And I wait for AJAX to finish
    And I press "edit-submit-news-alerts"
  Then I should see the text "Investor Behat Test Alert"

@api @javascript @investor
Scenario: Search for Bulletins
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/news"
    And I fill in "Title" with "Investor Behat Test Bulletin"
    And I wait 1 seconds
    And I type "Investor Behat Display Bulletin Title" in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Bulletins Drago Summary"
    And I wait 1 seconds
    And I select "Investor Bulletins" from "News Type"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "News Investor Behat Test Bulletin has been created."
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    And I wait for AJAX to finish
    And I fill in "Keyword" with "Investor Behat Test Bulletins Drago Summary"
    And I select "Any" from "News Type"
    And I wait for AJAX to finish
    And I press "edit-submit-news-alerts"
  Then I should see the text "Investor Behat Test Bulletin"

@api @javascript @investor
Scenario: Old Press Release Links Redirect to Homepage
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/news"
    And I fill in "Title" with "Investor Behat Test Old Press Release"
    And I press "Link (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I fill in "URL" with "/additional-resources/news-alerts/press-releases/"
    And I click "Save" on the modal "Add Link"
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 5 seconds
    And I press "edit-submit"
    And I wait 2 seconds
  Then I should see the text "1 error has been found: News Type"
 #Press Releases has been deleted from Taxonomy

  @api @javascript @investor
  Scenario: Verification Of Left Navigation Menu
    Given I am logged in as a user with the "Content Approver" role
    When I visit "/node/add/news"
      And I fill in "Title" with "Testing Ticket for Menu Navigation"
      And I wait 1 seconds
      And I type "Left Menu" in the "Body" WYSIWYG editor
      And I wait 2 seconds
      And I press the "Edit summary" button
      And I fill in "Summary" with "Default Menu Should Display On The Left Side"
      And I wait 1 seconds
      And I select "Investor Alerts" from "News Type"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press "edit-submit"
    Then I should see the text "Testing Ticket for Menu Navigation"
      And I should see the text "Left Menu"
      And I should see the link "Testing Ticket for Menu Navigation"
      And I should see the text "News Testing Ticket for Menu Navigation has been created."
      And I should see the link "Investor Alerts & Bulletins" in the "left_nav_menu" region
      And I should see the link "Publications and Research" in the "left_nav_menu" region
      And I should see the link "Useful Websites" in the "left_nav_menu" region
    When I click "Edit"
      And I select "Investor Bulletins" from "News Type"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press "edit-submit"
    Then I should see the text "Testing Ticket for Menu Navigation"
      And I should see the text "Left Menu"
      And I should see the link "Testing Ticket for Menu Navigation"
      And I should see the text "News Testing Ticket for Menu Navigation has been updated."
      And I should see the link "Investor Alerts & Bulletins" in the "left_nav_menu" region
      And I should see the link "Publications and Research" in the "left_nav_menu" region
      And I should see the link "Useful Websites" in the "left_nav_menu" region

@api @javascript @investor
Scenario: Verify Texts are Showing Bold When Using Strong Tag for News
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/news"
    And I fill in "Title" with "Testing ticket 13871"
    And I wait 1 seconds
    And I press "Bold" in the "Body" WYSIWYG Toolbar
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press the "Edit summary" button
    And I fill in "Summary" with "Verification of strong tag and font weight"
    And I wait 1 seconds
    And I select "Investor Alerts" from "News Type"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Testing ticket 13871"
    And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div > div > div.block.block-layout-builder.block-field-blocknodenewsbody.block-title- > div > p > strong" element

@api @javascript @investor
Scenario Outline: Add Custom Hero Block To News Using Layout Builder
  Given I create "media" of type "image":
    | name  | field_media_image | field_media_image_alt | mid    | moderation_state |
    | Lion  | behat-lion.jpg    | lion on top of cliff  | 122226 | publication      |
    And "news" content:
      | title            | body            | field_news_type | status | moderation_state | nid    | field_date          |
      | Behat News Alert | test news alert | Investor Alerts | 1      | published        | 825033 | 2021-02-14T13:00:00 |
  When I am logged in as a user with the "<role>" role
    And I am on "/node/825033"
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click "Hero"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Test Hero Title"
    And I fill in "Hero Heading" with "Behat Test Hero Heading"
    And I fill in "Use existing media" with "Lion"
    And I press "Add block"
    And I wait for ajax to finish
    And I scroll to the top
    And I select "<status_change>" from "Change to"
    And I press "Save layout"
  Then I should see the text "<block_saved>"

   Examples:
    | role             | status_change | block_saved                         |
    | Content Creator  | Draft         | Behat Test Hero Heading             |
    | Content Approver | Published     | Behat Test Hero Heading             |
    | Site Builder     | Draft         | The layout override has been saved. |
    | Administrator    | Published     | Behat Test Hero Heading             |

@api @javascript @investor
Scenario: Add New Section And Hero Block To News
  Given I create "media" of type "image":
    | name  | field_media_image | field_media_image_alt | mid    | moderation_state |
    | Lion  | behat-lion.jpg    | lion on top of cliff  | 122226 | publication      |
    And "news" content:
      | title            | body            | field_news_type | status | moderation_state | nid    | field_date          |
      | Behat News Alert | test news alert | Investor Alerts | 1      | published        | 825033 | 2021-02-14T13:00:00 |
  When I am logged in as a user with the "Content Creator" role
    And I am on "/node/825033"
    And I click "Layout"
    And I click "Add section"
    And I wait for ajax to finish
    And I click "One column"
    And I wait for ajax to finish
    And I click "Add section"
    And I wait for ajax to finish
    And I click "Two column"
    And I wait for ajax to finish
    And I press "Add section"
    And I wait for ajax to finish
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click "Hero"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Test Hero Title"
    And I fill in "Hero Heading" with "Behat Test Hero Heading"
    And I fill in "Use existing media" with "Lion"
    And I press "Add block"
    And I wait for ajax to finish
  Then I should see the text "Behat Test Hero Heading"

@api @javascript @investor
Scenario: Discard Changes For News In Layouts
  Given "news" content:
    | title            | body            | field_news_type    | status | moderation_state | nid    | field_date          |
    | Behat News Alert | test news alert | Investor Bulletins | 1      | published        | 825033 | 2021-02-14T13:00:00 |
  When I am logged in as a user with the "Content Creator" role
    And I am on "/node/825033"
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click "Basic block"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Test Basic Block Title"
    And I press "Add block"
    And I wait for ajax to finish
    And I should see the text "Behat Test Basic Block Title"
    And I scroll to the top
    And I press "Discard changes"
    And I wait 1 seconds
    And I press "Confirm"
    And I wait 1 seconds
  Then I should see the text "The changes to the layout have been discarded."
    And I should not see the text "Behat Test Basic Block Title"

@api @javascript @investor
Scenario: Revert Changes For News In Layouts
  Given "news" content:
    | title            | body            | field_news_type    | status | moderation_state | nid    | field_date          |
    | Behat News Alert | test news alert | Investor Bulletins | 1      | published        | 825033 | 2021-02-14T13:00:00 |
  When I am logged in as a user with the "Content Creator" role
    And I am on "/node/825033"
    And I click "Layout"
    And I click "Add block"
    And I wait for ajax to finish
    And I click "Create custom block"
    And I wait for ajax to finish
    And I click "Content Block"
    And I wait for ajax to finish
    And I fill in "Title" with "Behat Test Content Block Title"
    And I press "Add block"
    And I wait for ajax to finish
    And I should see the text "Behat Test Content Block Title"
    And I scroll to the top
    And I press "Revert to defaults"
    And I wait 1 seconds
    And I press "Revert"
    And I wait 1 seconds
  Then I should see the text "The layout has been reverted back to defaults."
    And I should not see the text "Behat Test Content Block Title"

@api @javascript @investor
Scenario: Search for alerts by year
  Given "news" content:
    | title         | body            | field_news_type    | field_news_category   | status | moderation_state | nid    | field_date          |
    | Blue Test A   | test news alert | Investor Alerts    | Corporation Finance   | 1      | published        | 825033 | 2012-01-14T13:00:00 |
    | Blue Test B   | test news alert | Investor Alerts    | Trading and Markets   | 1      | published        | 825034 | 2013-01-14T13:00:00 |
    | Red Test A    | test news alert | Investor Alerts    | Investment Management | 1      | published        | 825035 | 2012-01-14T13:00:00 |
    | Red Test B    | test news alert | Investor Alerts    | Enforcement           | 1      | published        | 825036 | 2015-01-14T13:00:00 |
    | Yellow Test A | test news alert | Investor Bulletins | Corporation Finance   | 1      | published        | 825037 | 2012-01-14T13:00:00 |
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    And I wait for AJAX to finish
    And I select "2012" from "Year"
    And I fill in "Keyword" with "Test A"
    And I select "Investor Alerts" from "News Type"
    And I wait for AJAX to finish
    And I press "edit-submit-news-alerts"
  Then I should see the text "Blue Test A"
    And I should not see the text "Blue Test B"
    And I should see the text "Red Test A"
    And I should not see the text "Red Test B"
    And I should not see the text "Yellow Test A"

@api @javascript @investor
Scenario: Search for bulletins by year
  Given "news" content:
    | title         | body            | field_news_type    | field_news_category   | status | moderation_state | nid    | field_date          |
    | Blue Test A   | test news alert | Investor Bulletins | Corporation Finance   | 1      | published        | 825033 | 2012-01-14T13:00:00 |
    | Blue Test B   | test news alert | Investor Bulletins | Trading and Markets   | 1      | published        | 825034 | 2013-01-14T13:00:00 |
    | Red Test A    | test news alert | Investor Bulletins | Investment Management | 1      | published        | 825035 | 2012-01-14T13:00:00 |
    | Red Test B    | test news alert | Investor Bulletins | Enforcement           | 1      | published        | 825036 | 2015-01-14T13:00:00 |
    | Yellow Test A | test news alert | Investor Alerts    | Corporation Finance   | 1      | published        | 825037 | 2012-01-14T13:00:00 |
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    And I wait for AJAX to finish
    And I select "2012" from "Year"
    And I fill in "Keyword" with "Test A"
    And I select "Investor Bulletins" from "News Type"
    And I wait for AJAX to finish
    And I press "edit-submit-news-alerts"
  Then I should see the text "Blue Test A"
    And I should not see the text "Blue Test B"
    And I should see the text "Red Test A"
    And I should not see the text "Red Test B"
    And I should not see the text "Yellow Test A"

@api @javascript @investor
Scenario Outline: Filter alerts by tag
  Given "news" content:
    | title                         | body            | field_news_type    | field_news_category   | status | moderation_state | nid    | field_date          |
    | Behat Corporation Finance 1   | test news alert | Investor Alerts    | Corporation Finance   | 1      | published        | 825033 | 2012-01-14T13:00:00 |
    | Behat Corporation Finance 2   | test news alert | Investor Bulletins | Corporation Finance   | 1      | published        | 825034 | 2012-01-14T13:00:00 |
    | Behat Trading and Markets 1   | test news alert | Investor Alerts    | Trading and Markets   | 1      | published        | 825035 | 2012-01-14T13:00:00 |
    | Behat Trading and Markets 2   | test news alert | Investor Bulletins | Trading and Markets   | 1      | published        | 825036 | 2012-01-14T13:00:00 |
    | Behat Investment Management 1 | test news alert | Investor Alerts    | Investment Management | 1      | published        | 825037 | 2012-01-14T13:00:00 |
    | Behat Investment Management 2 | test news alert | Investor Bulletins | Investment Management | 1      | published        | 825038 | 2012-01-14T13:00:00 |
    | Behat Enforcement 1           | test news alert | Investor Alerts    | Enforcement           | 1      | published        | 825039 | 2012-01-14T13:00:00 |
    | Behat Enforcement 2           | test news alert | Investor Bulletins | Enforcement           | 1      | published        | 825040 | 2012-01-14T13:00:00 |
  When I visit "<filter>"
    And I select "2012" from "Year"
    And I fill in "Keyword" with "<keyword>"
    And I select "Investor Bulletin" from "News Type"
    And I wait for AJAX to finish
    And I press "edit-submit-news-alerts"
  Then I should see the text "<title> 2"
    And I should not see the text "<title> 1"

  Examples:
    | keyword               | title                       | filter                                                                                                  |
    | Corporation Finance   | Behat Corporation Finance   | /introduction-investing/general-resources/news-alerts/alerts-bulletins/category/corporation%20finance   |
    | Trading and Markets   | Behat Trading and Markets   | /introduction-investing/general-resources/news-alerts/alerts-bulletins/category/trading%20and%20markets |
    | Investment Management | Behat Investment Management | /introduction-investing/general-resources/news-alerts/alerts-bulletins/category/investment%20management |
    | Enforcement           | Behat Enforcement           | /introduction-investing/general-resources/news-alerts/alerts-bulletins/category/enforcement             |

@api @javascript @investor
Scenario Outline: Filter by taxonomy then view all
  Given "news" content:
    | title        | body            | field_news_type | field_news_category   | status | moderation_state | nid    | field_date          |
    | BehatCorpFin | test news alert | Investor Alerts | Corporation Finance   | 1      | published        | 825033 | 2012-01-14T13:00:00 |
    | BehatTrade   | test news alert | Investor Alerts | Trading and Markets   | 1      | published        | 825034 | 2012-01-14T13:00:00 |
    | BehatInvest  | test news alert | Investor Alerts | Investment Management | 1      | published        | 825035 | 2012-01-14T13:00:00 |
    | BehatEnforce | test news alert | Investor Alerts | Enforcement           | 1      | published        | 825036 | 2012-01-14T13:00:00 |
    And I am on "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
  When I click "<taxonomy>"
  Then I should see the text "<title1>"
    And I should not see the text "<title2>"
    And I should not see the text "<title3>"
    And I should not see the text "<title4>"
  When I click "View All"
  Then I should see the text "<title1>"
    And I should see the text "<title2>"
    And I should see the text "<title3>"
    And I should see the text "<title4>"

  Examples:
    | taxonomy              | title1       | title2       | title3       | title4       |
    | Corporation Finance   | BehatCorpFin | BehatTrade   | BehatInvest  | BehatEnforce |
    | Trading and Markets   | BehatTrade   | BehatInvest  | BehatEnforce | BehatCorpFin |
    | Investment Management | BehatInvest  | BehatEnforce | BehatCorpFin | BehatTrade   |
    | Enforcement           | BehatEnforce | BehatCorpFin | BehatTrade   | BehatInvest  |

@api @javascript @investor
Scenario Outline: Filter alerts with multiple taxonomies
  Given "news" content:
    | title               | body                 | field_news_type    | status | moderation_state | nid    | field_date          | field_news_category                      |
    | Behat News Bulletin | test news bulletin 1 | Investor Bulletins | 1      | published        | 825033 | 2025-02-18T13:00:00 | Corporation Finance, Trading and Markets |
    | Behat News Alert    | test news alert 3    | Investor Alerts    | 1      | published        | 825035 | 2025-02-16T13:00:00 | Investment Management, Enforcement       |
    And I am on "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
  When I click "<taxonomy>"
  Then I should see the text "<title1>"
    And I should not see the text "<title2>"

    Examples:
      | taxonomy              | title1              | title2              |
      | Corporation Finance   | Behat News Bulletin | Behat News Alert    |
      | Trading and Markets   | Behat News Bulletin | Behat News Alert    |
      | Investment Management | Behat News Alert    | Behat News Bulletin |
      | Enforcement           | Behat News Alert    | Behat News Bulletin |

@api @javascript @investor
Scenario: Filter page results by X
  Given "news" content:
    | title                  | body               | field_news_type    | status | moderation_state | nid    | field_date          |
    | Behat News Bulletin  A | test news bulletin | Investor Bulletins | 1      | published        | 825034 | 2016-01-14T13:00:00 |
    | Behat News Bulletin  B | test news bulletin | Investor Bulletins | 1      | published        | 825035 | 2016-02-14T13:00:00 |
    | Behat News Bulletin  C | test news bulletin | Investor Bulletins | 1      | published        | 825036 | 2016-03-14T13:00:00 |
    | Behat News Bulletin  D | test news bulletin | Investor Bulletins | 1      | published        | 825037 | 2016-04-14T13:00:00 |
    | Behat News Bulletin  E | test news bulletin | Investor Bulletins | 1      | published        | 825038 | 2016-05-14T13:00:00 |
    | Behat News Bulletin  F | test news bulletin | Investor Bulletins | 1      | published        | 825039 | 2016-06-14T13:00:00 |
    | Behat News Bulletin  G | test news bulletin | Investor Bulletins | 1      | published        | 825040 | 2016-07-14T13:00:00 |
    | Behat News Bulletin  H | test news bulletin | Investor Bulletins | 1      | published        | 825041 | 2016-08-14T13:00:00 |
    | Behat News Bulletin  I | test news bulletin | Investor Bulletins | 1      | published        | 825042 | 2016-09-14T13:00:00 |
    | Behat News Bulletin  J | test news bulletin | Investor Bulletins | 1      | published        | 825043 | 2016-10-14T13:00:00 |
    | Behat News Bulletin  K | test news bulletin | Investor Bulletins | 1      | published        | 825044 | 2016-11-14T13:00:00 |
    | Behat News Bulletin  L | test news bulletin | Investor Bulletins | 1      | published        | 825045 | 2016-12-14T13:00:00 |
    | Behat News Bulletin  M | test news bulletin | Investor Bulletins | 1      | published        | 825046 | 2017-01-14T13:00:00 |
    | Behat News Bulletin  N | test news bulletin | Investor Bulletins | 1      | published        | 825047 | 2017-02-14T13:00:00 |
    | Behat News Bulletin  O | test news bulletin | Investor Bulletins | 1      | published        | 825048 | 2017-03-14T13:00:00 |
    | Behat News Bulletin  P | test news bulletin | Investor Bulletins | 1      | published        | 825049 | 2017-04-14T13:00:00 |
    | Behat News Bulletin  Q | test news bulletin | Investor Bulletins | 1      | published        | 825050 | 2017-05-14T13:00:00 |
    | Behat News Bulletin  R | test news bulletin | Investor Bulletins | 1      | published        | 825051 | 2017-06-14T13:00:00 |
    | Behat News Bulletin  S | test news bulletin | Investor Bulletins | 1      | published        | 825052 | 2017-07-14T13:00:00 |
    | Behat News Bulletin  T | test news bulletin | Investor Bulletins | 1      | published        | 825053 | 2017-07-14T13:00:00 |
    | Behat News Bulletin  U | test news bulletin | Investor Bulletins | 1      | published        | 825054 | 2017-08-14T13:00:00 |
    | Behat News Bulletin  V | test news bulletin | Investor Bulletins | 1      | published        | 825055 | 2017-09-14T13:00:00 |
    | Behat News Bulletin  W | test news bulletin | Investor Bulletins | 1      | published        | 825056 | 2017-10-14T13:00:00 |
    | Behat News Bulletin  X | test news bulletin | Investor Bulletins | 1      | published        | 825057 | 2017-11-14T13:00:00 |
    | Behat News Bulletin  Y | test news bulletin | Investor Bulletins | 1      | published        | 825058 | 2017-12-14T13:00:00 |
    | Behat News Bulletin  Z | test news bulletin | Investor Bulletins | 1      | published        | 825059 | 2018-01-14T13:00:00 |
  When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins"
    And I wait for AJAX to finish
  Then I should see the text "Behat News Bulletin Z"
    And I should see the text "Behat News Bulletin Y"
    And I should see the text "Behat News Bulletin X"
    And I should see the text "Behat News Bulletin W"
    And I should see the text "Behat News Bulletin V"
    And I should see the text "Behat News Bulletin U"
    And I should see the text "Behat News Bulletin T"
    And I should see the text "Behat News Bulletin J"
    And I should see the text "Behat News Bulletin R"
    And I should see the text "Behat News Bulletin Q"
    And I should see the text "Behat News Bulletin P"
    And I should see the text "Behat News Bulletin O"
    And I should see the text "Behat News Bulletin N"
    And I should see the text "Behat News Bulletin M"
    And I should see the text "Behat News Bulletin L"
    And I should see the text "Behat News Bulletin K"
    And I should see the text "Behat News Bulletin J"
    And I should see the text "Behat News Bulletin I"
    And I should see the text "Behat News Bulletin H"
    And I should see the text "Behat News Bulletin G"
    And I should see the text "Behat News Bulletin F"
    And I should see the text "Behat News Bulletin E"
    And I should see the text "Behat News Bulletin D"
    And I should see the text "Behat News Bulletin C"
    And I should see the text "Behat News Bulletin B"
    And I should Not see the text "Behat News Bulletin A"
  When I click "Next ››"
  Then I should see the text "Behat News Bulletin A"

@api @investor
Scenario: Homepage News Alerts and Bulletins List Block
  Given "news" content:
    | title                 | body                 | field_news_type    | status | moderation_state | nid    | field_date          | field_news_category                                             |
    | Behat News Bulletin 1 | test news bulletin 1 | Investor Bulletins | 1      | published        | 825033 | 2025-02-18T13:00:00 | Corporation Finance, Trading and Markets, Investment Management |
    | Behat News Bulletin 2 | test news bulletin 2 | Investor Bulletins | 1      | published        | 825034 | 2025-02-17T13:00:00 | Trading and Markets, Investment Management, Enforcement         |
    | Behat News Alert 3    | test news alert 3    | Investor Alerts    | 1      | published        | 825035 | 2025-02-16T13:00:00 | Investment Management, Enforcement                              |
    | Behat News Alert 4    | test news alert 4    | Investor Alerts    | 1      | published        | 825036 | 2025-02-14T13:00:00 | Corporation Finance, Trading and Markets, Enforcement           |
  When I am on the homepage
  Then I should see the link "Behat News Bulletin 1"
    And I should see the link "Behat News Bulletin 2"
    And I should see the link "Behat News Alert 3"
    And I should not see "Behat News Alert 4"
  When I click "More Alerts and Bulletins"
  Then I should see the text "View Alerts Related To"
