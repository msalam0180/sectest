Feature: Global UI
  As a Site Visitor, the user should be able to navigate SEC.gov

@ui @api @javascript @wdio
Scenario: View Assigned User Roles
  Given users:
    | uid  | name            | pass  | mail           | roles                                                                                             | status |
    | 9995 | behat_all_roles | behat | test4@test.com | bad_actors, content_creator, content_approver, sitebuilder, division_office_admin, administrator  | 1      |
  Then I take a screenshot on "sec" using "globalnavigation.feature" file with "@user_role_display" tag

@ui @javascript @api @wdio
 Scenario: Adding and Interacting Accordion On SEC Page
    Given I am logged in as a user with the "content_approver" role
      And "landing_page" content:
        | title               | field_display_title       | field_primary_division_office | field_left_nav_override  |
        | Behat Landing Page1 | SEC Behat Accordion Test1 | Credit Ratings                | small-bus-left-nav       |
    When I am on "/admin/content"
      And I click "Edit" in the "Behat Landing Page1" row
      And I wait 2 seconds
      And I press "Source" in the "Left 1 - Box" WYSIWYG Toolbar
      And I type '<div id="accordion-sample"><h3>Acceptance Criteria 1</h3><div><p>To test accordion in body</p></div><h3>Acceptance Criteria 2</h3><div><p>To test accordion in left nav menu</p></div></div>' in css selector "#cke_1_contents > textarea"
      And I publish it
      And I am not logged in
    Then I take a screenshot on "sec" using "sec_styles.feature" file with "@accordion1" tag
      And I take a screenshot on "sec" using "sec_styles.feature" file with "@accordion2" tag

@ui @javascript @api @wdio
 Scenario: Adding and Interacting Tabs On SEC Page
    Given I am logged in as a user with the "content_approver" role
      And "landing_page" content:
        | title               | field_display_title  | field_primary_division_office |
        | Behat Landing Page2 | SEC Behat Tabs Test2 | Agency-Wide                   |
    When I am on "/admin/content"
      And I click "Edit" in the "Behat Landing Page2" row
      And I wait 2 seconds
      And I press "Source" in the "Left 1 - Box" WYSIWYG Toolbar
      And I type '<div id="tabs-corpfin"><ul><li><a href="#tab1">Statutes</a></li><li><a href="#tab2">Rules</a></li><li><a href="#tab3">Forms</a></li><li><a href="#tab4">Special Filers / Transactions</a></li></ul><div id="tab1"><h3>Some Statutes</h3></div><div id="tab2"><h3>Some Rules</h3></div><div id="tab3"><h3>Some Forms</h3></div><div id="tab4"><h3>Some Special Filers / Transactions</h3></div></div>' in css selector "#cke_1_contents > textarea"
      And I publish it
      And I am not logged in
    Then I take a screenshot on "sec" using "sec_styles.feature" file with "@tab1" tag

@ui @javascript @api @wdio
 Scenario: Footer Screenshot
    Given "landing_page" content:
      | title               | field_display_title  | field_primary_division_office |
      | Behat Landing Page3 | SEC Behat Tabs Test3 | Agency-Wide                   |
    Then I take a screenshot on "sec" using "globalnavigation.feature" file with "@footer" tag

@ui @javascript @api @wdio
 Scenario: Capture Left Nav on Parent and Subpage
    Given I am logged in as a user with the "sitebuilder" role
     When I visit "/admin/appearance"
      #switching theme to uswdssec
     And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
     When I am logged in as a user with the "authenticated user" role
    Then I take a screenshot on "sec" using "globalnavigation.feature" file with "@parent_leftnav" tag
      And I take a screenshot on "sec" using "globalnavigation.feature" file with "@sub_leftnav" tag
    When  I am logged in as a user with the "sitebuilder" role
      And I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"