Feature: Global Items
  As a user, I want to see global things so I can know where I am

  @api @javascript
  Scenario: Verify Addthis For SEC
    Given "secarticle" content:
      | field_article_type_secarticle | moderation_state | title                | field_display_title  | status | body        | field_primary_division_office |
      | Other                         | published        | Verify addthis icons | Verify addthis icons | 1      | Verify body | Agency-Wide                   |
    When I visit "/verify-addthis-icons"
    Then I should see the "a" element with the "title" attribute set to "Print Page" in the "addthis_region" region
      And I should see the "a" element with the "class" attribute set to "addthis_button_print at300b" in the "addthis_region" region
      And I should see the "a" element with the "title" attribute set to "Share on Facebook" in the "addthis_region" region
      And I should see the "a" element with the "class" attribute set to "addthis_button_facebook at300b" in the "addthis_region" region
      And I should see the "a" element with the "title" attribute set to "Email Page" in the "addthis_region" region
      And I should see the "a" element with the "class" attribute set to "addthis_button_mailto at300b" in the "addthis_region" region
      And I should see the "a" element with the "title" attribute set to "Tweet Page" in the "addthis_region" region
      And I should see the "a" element with the "class" attribute set to "addthis_button_twitter at300b" in the "addthis_region" region
      And I should see the "a" element with the "title" attribute set to "More Sharing Options" in the "addthis_region" region
      And I should see the "a" element with the "class" attribute set to "addthis_button_compact at300m" in the "addthis_region" region
    When I click on the element with css selector "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small > a.addthis_button_compact.at300m"
      And I wait 1 seconds
    Then I should see the link "Pinterest"
      And I should see the link "Gmail"
      And I should see the link "LinkedIn"
      And I should see the link "Tumblr"
      And I should see the link "Messenger"
      And I should see the link "More... (177)"
    When I click "More... (177)"
    Then the link should open in a new tab
      And I wait 1 seconds
      And I should see the text "TOP SERVICES"
      And I close the current tab
    When I visit "/verify-addthis-icons"
      And I wait 1 seconds
      And I click on the element with css selector "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small > a.addthis_button_compact.at300m"
      And I click "More Sharing Options"
      And I click "Powered by AddThis"
    Then the link should open in a new tab
      And I wait 1 seconds
      And I should see the link "Why AddThis?"
      And I close the current tab

  @api @javascript
  Scenario Outline: Check Addthis Buttons For SEC
    Given "secarticle" content:
      | field_article_type_secarticle | moderation_state | title                | field_display_title  | status | body        | field_primary_division_office |
      | Other                         | published        | Verify addthis icons | Verify addthis icons | 1      | Verify body | Agency-Wide                   |
    When I am on "/verify-addthis-icons"
      And I wait 1 seconds
    Then I click on the element with css selector "<button>"
      And I switch to the new window
      And I wait 2 seconds
      And I should see the text "<text>"
      And I close the current window

    Examples:
      | button       | text                                                         |
      | .fa-facebook | Log in to use your Facebook account with Shared via AddThis. |
      | .fa-twitter  | Want to log in first?                                        |

  @api @javascript
  Scenario Outline: Check Environment Indicator
    Given I am logged in as a user with the "<role>" role
    When I visit "/"
    Then I should see the text "LOCAL LNDO" in the "env_indicator" region
      And I should see the "div" element with the "style" attribute set to "cursor: pointer; background-color: #f9c642; color: #212121" in the "env_indicator" region
    When I click on the element with css selector "#environment-indicator"
    Then I should see the link "Open on Prod" in the "env_indicator" region
      And I should see the link "Open on Train" in the "env_indicator" region
    When I visit "/admin/content/search"
    Then I should see the text "LOCAL LNDO" in the "env_indicator" region
      And I should see the "div" element with the "style" attribute set to "cursor: pointer; background-color: #f9c642; color: #212121" in the "env_indicator" region
      And the hyperlink "Open on Prod" should match the Drupal url "https://dcm.sec.gov/admin/content/search"
      And the hyperlink "Open on Train" should match the Drupal url "https://dcmtrain.sec.gov/admin/content/search"

    Examples:
      | role                  |
      | Administrator         |
      | Sitebuilder           |
      | Content Creator       |
      | Content Approver      |
      | Individual Defendants |
      | Division/Office Admin |

  @api
  Scenario: Authenticated User Environment Indicator
    Given I am logged in as a user with the "Authenticated user" role
    When I visit "/"
    Then I should not see the text "LOCAL LNDO"

  @api @javascript
  Scenario: Block User After 3 Failed Login Attempts
    Given users:
      | uid   | name       | mail           | roles           | created    | changed    | access     | status |
      | 10000 | behat_user | test1@test.com | content_creator | 1594686355 | 1594686356 | 1594686357 | 1      |
    When I visit "/user/login"
      And I fill in "Username" with "behat_user"
      And I fill in "Password" with "applejuice"
      And I press the "Log in" button
    Then I should see text matching "Login to the SEC CMS"
    When I fill in "Username" with "behat_user"
      And I fill in "Password" with "applejuice"
      And I press the "Log in" button
    Then I should see text matching "Login to the SEC CMS"
    When I fill in "Username" with "behat_user"
      And I fill in "Password" with "applejuice"
      And I press the "Log in" button
    Then I should see the css selector "li:contains('The user behat_user has been blocked due to failed login attempts.')"
    When I am logged in as a user with the "Administrator" role
      And I visit "/admin/people"
      And I fill in "behat_user" for "Name or email contains"
      And I wait for ajax to finish
      And I press "Filter"
      And I wait 3 seconds
    Then I should see the text "Blocked" in the "behat_user" row

  @api @javascript
  Scenario: 30-Day Lockout
    Given users:
      | uid   | name       | mail           | roles           | created    | changed    | access     | status |
      | 10000 | behat_user | test1@test.com | content_creator | 1559404403 | 1559404413 | 1591628003 | 1      |
    When I am logged in as a user with the "Administrator" role
      And I am on "/admin/people"
      And I fill in "behat_user" for "Name or email contains"
      And I press the "Filter" button
      And I wait for ajax to finish
    Then I should see the text "Active" in the "behat_user" row
    When I run drush "eval" '"disable_inactive_user(30);"'
      And I run drush "cr"
      And I reload the page
    Then I should see the text "Blocked" in the "behat_user" row
    When I visit "/admin/reports/dblog"
      And I select "disable_inactive_user" from "Type"
      And I press "Filter"
      And I wait for ajax to finish
      And I click "Following inactive user accounts has been blocked: 10000"
    Then I should see the text "Following inactive user accounts has been blocked: 10000"

  @api @javascript
  Scenario: Add Accounts And Add/Remove Roles Then View Role Logs
    Given users:
      | uid  | name           | mail            | roles                         | status |
      | 9990 | behat creator  | behat1@test.com | content_creator               | 1      |
      | 9991 | behat approver | behat2@test.com | content_approver, sitebuilder | 1      |
      | 9992 | behat_admin    | behat3@test.com | administrator                 | 1      |
    When I am logged in as "behat_admin"
      And I am on "/admin/people"
      And I fill in "behat creator" for "Name or email contains"
      And I press the "Filter" button
      And I wait for ajax to finish
      And I click "Edit" in the "behat creator" row
      And I check the box "Division/Office Admin"
      And I press "Save"
      And I fill in "behat approver" for "Name or email contains"
      And I press the "Filter" button
      And I wait for ajax to finish
      And I click "Edit" in the "behat approver" row
      And I uncheck the box "Sitebuilder"
      And I press "Save"
      And I visit "/admin/reports/dblog"
      And I select "system" from "Type"
      And I additionally select "user" from "Type"
      And I press "Filter"
      And I wait for ajax to finish
    Then I should see the text "New user: behat creator created with active status."
      And I should see the text "New user: behat_admin created with roles"
      And I should see the text "Roles for user behat creator (UID 9990) changed from"
      And I should see the text "Roles for user behat approver (UID 9991) changed from"
      And I click "Roles for user behat approver (UID 9991) changed from […"
    Then I should see the text "Roles for user behat approver (UID 9991) changed from [authenticated, content_approver, sitebuilder] to [authenticated, content_approver]."
    When I move backward one page
      And I click "Roles for user behat creator (UID 9990) changed from […"
    Then I should see the text "Roles for user behat creator (UID 9990) changed from [authenticated, content_creator] to [authenticated, content_creator, division_office_admin]."

  @api @javascript
  Scenario: Cancel Account And View Role Logs
    Given users:
      | uid  | name              | mail           | roles                 | status |
      | 9993 | behat sitebuilder | test1@test.com | sitebuilder           | 1      |
      | 9994 | behat doa         | test2@test.com | Division/Office Admin | 1      |
      | 9992 | behat_admin       | test3@test.com | administrator         | 1      |
    When I am logged in as "behat_admin"
      And I am on "/admin/people"
      And I fill in "behat doa" for "Name or email contains"
      And I press the "Filter" button
      And I wait for ajax to finish
      And I click "Edit" in the "behat doa" row
      And I scroll to the bottom
      And I click "Cancel account"
      And I press "Confirm"
      And I wait for ajax to finish
    Then I should see the text "Blocked" in the "behat doa" row
    When I visit "/admin/reports/dblog"
      And I select "system" from "Type"
      And I additionally select "user" from "Type"
      And I press "Filter"
      And I wait for ajax to finish
    Then I should see the text "Blocked user: behat doa <test2@test.com>." in the "behat_admin" row
    When I click "Status for user behat doa (UID 9994) changed from…"
    Then I should see the text "Status for user behat doa (UID 9994) changed from active to blocked."
    When I move backward one page
      And I click "Blocked user: behat doa <test2@test.com>."
    Then I should see the text "Blocked user: behat doa <test2@test.com>."

  @api @javascript
  Scenario Outline: Change <container> Tag To A Proper HTML Element On SEC Pages
    Given I am viewing an "<content>" content:
      | title                         | <title>           |
      | field_display_title           | <dtitle>          |
      | body                          | This is the body. |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_article_type_secarticle | <article_type>    |
    Then I should not see the html element "container" on the page
      But I should see the "div" element with the "class" attribute set to "page-container" in the "container" region

    Examples:
     | content            | title                        | dtitle                 | article_type |
     | secarticle         | BEHAT SEC Article            | SEC Article            | Other        |
     | page               | BEHAT SEC Basic Page         |                        |              |
     | data_distribution  | BEHAT SEC Data Distribution  | SEC Data Distribution  |              |
     | data_visualization | BEHAT SEC Data Visualization | SEC Data Visualization |              |
     | event              | BEHAT SEC Event              | SEC Event              |              |
     | govdelivery_form   | BEHAT SEC Gov Delivery Form  | SEC Gov Delivery Form  |              |
     | sec_hero           | BEHAT SEC Hero               | SEC Hero               |              |
     | ba                 | BEHAT SEC IDD                |                        |              |
     | landing_page       | BEHAT SEC Landing Page       | SEC Landing Page       |              |
     | news               | BEHAT SEC News               | SEC News               |              |
     | secperson          | BEHAT SEC Person             |                        |              |
     | sec_alert          | BEHAT SEC Alert              |                        |              |
     | webcast            | BEHAT SEC Webcast            | SEC Webcast            |              |

  @api
  Scenario: No <container> Tag On SEC Homepage
    Given I am on "/"
    Then I should not see the html element "container" on the page
      But I should see the "div" element with the "class" attribute set to "page-container" in the "container" region

  @api @javascript
  Scenario Outline: Verify Email Share Icon Does Not Result In Maintenance Message
    Given I am viewing an "<content>" content:
      | title                         | <title>           |
      | field_display_title           | <dtitle>          |
      | body                          | This is the body. |
      | moderation_state              | published         |
      | status                        | 1                 |
      | field_news_type_news          | <news_type>       |
      | field_article_type_secarticle | <article_type>    |
    When I click "Email" in the "addthis_region" region
    Then I should not see the text "Email a Friend Planned Maintenance"

    Examples:
      | content      | title                  | dtitle           | news_type     | article_type |
      | secarticle   | BEHAT SEC Article      | SEC Article      |               | Other        |
      | event        | BEHAT SEC Event        | SEC Event        |               |              |
      | news         | BEHAT SEC News         | SEC News         | Press Release |              |
      | landing_page | BEHAT SEC Landing Page | SEC Landing Page |               |              |
      | secperson    | BEHAT SEC Person       |                  |               |              |

@api
Scenario: Validate Left Nav Values
  Given I am logged in as a user with the "sitebuilder" role
    When I visit "/admin/appearance"
    #switching theme to uswdssec
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
    And I am logged in as a user with the "authenticated user" role
    And I visit "/edgar/filer-information/"
  Then I should see the css selector ".is-active-trail"
  # Return the theme back to normal
  When I am logged in as a user with the "sitebuilder" role
   And I visit "/admin/appearance"
   And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"
