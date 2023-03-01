Feature: Homepage UI
  As a Site Visitor, the user should be able to navigate SEC.gov homepage

  @ui @api @javascript @wdio
  Scenario: Select uswdssec Theme and Capture Partial Screenshots of Government Banner, Header
  Given I am logged in as a user with the "sitebuilder" role
  When I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
  Then I take a screenshot on "sec" using "homepage.feature" file with "@disable_banner" tag
    And I take a screenshot on "sec" using "homepage.feature" file with "@enable_banner" tag
    And I take a screenshot on "sec" using "homepage.feature" file with "@header_uswdssec" tag
  # Return the theme back to normal
  When I am logged in as a user with the "sitebuilder" role
    And I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"
  Then I should see the text "Please note that the administration theme is still set to the Adminimal theme; consequently, the theme on this page remains unchanged. All non-administrative sections of the site, however, will show the selected SECGOV theme by default."

  @ui @api @javascript @wdio
  Scenario: Breadcrumbs and Header for uswdssec Theme
  Given I am logged in as a user with the "sitebuilder" role
    And "landing_page" content:
    | title                                             | field_tags                     | promote | field_display_title                        | body                                       | field_description_abstract                                      | moderation_state | status |
    | BEHAT We Regulate Securities Markets Landing Page | We Regulate Securities Markets | 1       | BEHAT We Regulate Securities Markets Title | BEHAT We Regulate Securities Markets Body  | This is the We Regulate Securities Markets description abstract | published        | 1      |
  When I visit "/admin/appearance"
      #switching theme to uswdssec
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
  Then I take a screenshot on "sec" using "sec_styles.feature" file with "@breadcrumbs" tag
    And I take a screenshot on "sec" using "sec_styles.feature" file with "@uswds_page_title" tag
    # Return the theme back to normal
  When I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"
  Then I should see the text "Please note that the administration theme is still set to the Adminimal theme; consequently, the theme on this page remains unchanged. All non-administrative sections of the site, however, will show the selected SECGOV theme by default."
