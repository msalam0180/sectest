Feature: Investor Landing Page
  As a Site Visitor, the user should be able to navigate to investor.gov home page and will be able to access Utility menu, Header

  @official_gov_banner @wdio
  Scenario: Element Screenshot of Government Banner
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element ".usa-banner__header"
      And I click on ".usa-banner__button-text"
      And I take screenshot of element ".usa-accordion"

  @header @wdio
  Scenario: Element Screenshot of Header
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element "#page > div.site-header"

  @global_menu @wdio
  Scenario: Element Screenshot of Global Navigation
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element "#investor-global-navigation"

  @global_navigation_hover_1 @wdio
  Scenario: Window Screenshot of Global Navigation With Hover On Introduction to Investment
    Given I set my screensize to desktop
    When I visit "/"
      And I remove ".main-content"
      And I remove "#twitter-widget-0"
      And I hover on "#investor-main-menu > li.menu-item-intro.menu-item.menu-item--expanded.menu-item-first.menu-index-1.is-expanded.menu__item"
    Then I take current window screenshot and add text "global_nav 1" to filename

  @global_navigation_hover_2 @wdio
  Scenario: Window Screenshot of Global Navigation With Hover On Financial Tools & Calculators
    Given I set my screensize to desktop
    When I visit "/"
      And I remove ".main-content"
      And I remove "#twitter-widget-0"
      And I hover on "#investor-main-menu.menu li.menu-item-research.menu-item.menu-item--expanded.menu-index-2.is-expanded.menu__item"
    Then I take current window screenshot and add text "global_nav 2" to filename

  @global_navigation_hover_3 @wdio
  Scenario: Window Screenshot of Global Navigation With Hover On Protect Your Investments
    Given I set my screensize to desktop
    When I visit "/"
      And I remove ".main-content"
      And I remove "#twitter-widget-0"
      And I hover on "#investor-main-menu.menu li.menu-item-protect.menu-item.menu-item--expanded.menu-index-3.is-expanded.menu__item"
    Then I take current window screenshot and add text "global_nav 3" to filename

  @global_navigation_hover_4 @wdio
  Scenario: Window Screenshot of Global Navigation With Hover On Additional Resources
    Given I set my screensize to desktop
    When I visit "/"
      And I remove ".main-content"
      And I remove "#twitter-widget-0"
      And I hover on "#investor-main-menu.menu li.menu-item-resources.menu-item.menu-item--expanded.menu-item-last.menu-index-4.is-expanded.menu__item"
    Then I take current window screenshot and add text "global_nav 4" to filename

  @RMD_results @wdio
  Scenario: Element Screenshot of REQUIRED MINIMUM DISTRIBUTION CALCULATOR Results
    Given I set my screensize to desktop
    When I visit "/financial-tools-calculators/calculators/required-minimum-distribution-calculator"
      And I type "1" in "#edit-account-balance"
      And I click on "#edit-age"
      And I click on "#edit-age > option:nth-child(2)"
      And I scroll to "#results_container"
    Then I take current window screenshot and add text "RMD_result" to filename

  @footer @wdio
  Scenario: Element Screenshot of Footer
    Given I set my screensize to desktop
    When I visit "/"
      And I scroll to "#page > div.site-footer"
      And I hide "#twitter-widget-0"
    Then I take screenshot of element ".site-footer"
      And I take screenshot of element ".site-footer2"

  @breadcrumb @wdio
  Scenario: Element Screenshot of Breadcrumb Menu
    Given I set my screensize to desktop
    When I visit "/introduction-investing/getting-started/investing-your-own/online-investing"
    Then I take screenshot of element "#page > div.region.region-breadcrumb"

  @breadcrumb_mobile @wdio
  Scenario: Mobile Screenshot of Breadcrumb Menu
    Given I set my screensize to mobile
    When I visit "/protect-your-investments/fraud/types-fraud/ponzi-scheme"
    Then I take screenshot of element "#page > div.region.region-breadcrumb"

  @hero_dark @wdio
  Scenario: Full Screen Hero Page Dark Theme
    Given I set my screensize to desktop
    When I visit "/Behat-Landing-Page"
       And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Dark" to filename

  @hero_light @wdio
  Scenario: Full Screen Hero Page Light Theme
    Given I set my screensize to desktop
    When I visit "/Behat-Landing-Page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Light" to filename

  @hero_title_dark @wdio
  Scenario: Full Screen Hero Page with Title
    Given I set my screensize to desktop
    When I visit "/Behat-Landing-Page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Title_dark" to filename

  @hero_title_light @wdio
  Scenario: Full Screen Hero Page with Title
    Given I set my screensize to desktop
    When I visit "/Behat-Landing-Page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Title_light" to filename

  @create_landing_page @wdio
  Scenario: Full Screenshot of Landing Page
    Given I set my screensize to desktop
    When I visit "/Investor-Behat-Test-Landing"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Create_Landing_Page" to filename

  @landing_page_no_title @wdio
  Scenario: Full Screenshot of Hidden Title Landing Page
    Given I set my screensize to desktop
    When I visit "/Investor-Behat-Test-Landing"
     And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "landing_page_no_title" to filename

  @create_button @wdio
  Scenario: Full Screenshot of Button for Landing Page
    Given I set my screensize to desktop
    When I visit "/Behat-Landing-Page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "create_Button" to filename

  @landingpage_rc @wdio
  Scenario: Full Screen Landing Page Related Content
    Given I set my screensize to desktop
    When I visit "/investor-behat-related-content-lp"
    Then I take screenshot of element "#main-wrapper"

  @image_text_landing_page @wdio
  Scenario: Full Screen Landing Page Image and Text
    Given I set my screensize to desktop
    When I visit "/behat-landing-page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Image_text" to filename

  @text_image_landing_page @wdio
  Scenario: Full Screen Landing Page Image and Text
    Given I set my screensize to desktop
    When I visit "/behat-landing-page"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Text_Image" to filename

  @edgar_search_block_landing_page @wdio
  Scenario: Full Screen Edgar Search Block
    Given I set my screensize to desktop
    When I visit "/node/825034"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "Edgar_Search_Block" to filename
