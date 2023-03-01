Feature: Create Styles on Pages
  As a Content Creator, I want to be able to create basic page and add accordion
  So that visitors to investor.gov can learn about the investor stles

  @inv_accordion1 @wdio
  Scenario: Full Screen Accordion
    Given I set my screensize to desktop
    When I visit "/node/2"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "full_accordion" to filename

  @inv_accordion2 @wdio
  Scenario: Accordion Expand 1
    Given I set my screensize to desktop
    When I visit "/node/2"
      And I wait for "2" seconds
      And I click on "#ui-id-1 > span:nth-child(1)"
      And I wait for "2" seconds
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "expand_accordion1" to filename

  @inv_accordion3 @wdio
  Scenario: Accordion Expand 2
    Given I set my screensize to desktop
    When I visit "/node/2"
      And I wait for "2" seconds
      And I click on "#ui-id-3 > span:nth-child(1)"
      And I wait for "2" seconds
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "expand_accordion2" to filename

  @inv_bullets_glossary @wdio
  Scenario: Bullets Glossary
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/glossary/investor-behat-test-glossary"
      And I wait for "2" seconds
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "arrow_bullets_glossary" to filename

  @inv_accordion_font @wdio
  Scenario: Accordion Font
    Given I set my screensize to desktop
    When I visit "/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/behat-text"
      And I wait for "2" seconds
      And I click on "#ui-id-1 > span:nth-child(1)"
      And I click on "#ui-id-3 > span:nth-child(1)"
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "accordion_font_text" to filename

  @inv_bold_font @wdio
  Scenario: Bold Font
    Given I set my screensize to desktop
    When I visit "/testing-ticket-13871"
      And I wait for "2" seconds
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "bold_font_text" to filename

  @round_bullet_blocks @wdio
  Scenario: Round Bullets On Blocks
    Given I set my screensize to desktop
    When I visit "/protect-your-investments"
      And I wait for "2" seconds
      And I remove "#twitter-widget-0, .site-footer, .site-footer2"
    Then I take full page screenshot and add text "round_bullet_blocks" to filename

  @glossary_relatedcontentstyle @wdio
  Scenario: Glossary Term Related Content
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/glossary/behat-test-glossary-page"
    Then I take screenshot of element "#content-wrapper"

  @glossary_relatedFontandBullets @wdio
  Scenario: Glossary related Font and Bullets
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/glossary/investor-behat-test-glossary"
    Then I take screenshot of element "#content-wrapper"

  @PLargefont @wdio
  Scenario: Paragraph Style P large Font
    Given I set my screensize to desktop
    When I visit "/article-p-large-font"
    Then I take screenshot of element "#content-wrapper"

  @PSmallfont @wdio
  Scenario: Paragraph Style P small Font
    Given I set my screensize to desktop
    When I visit "/article-p-small-font"
    Then I take screenshot of element "#content-wrapper"

  @PSmallestfont @wdio
  Scenario: Paragraph Style P smallest Font
    Given I set my screensize to desktop
    When I visit "/article-p-smallest-font"
    Then I take screenshot of element "#content-wrapper"

  @bullet_height @wdio
  Scenario: Bullet Height Matches Text Height
    Given I set my screensize to desktop
    When I visit "/node/456"
      And I scroll to "#accordion-CRS"
      And I click on "#ui-id-3"
      And I remove "#block-featured-content-block"
    Then I take screenshot of element "#accordion-CRS"
