Feature: Screenshots of Search Page

  @error @wdio
  Scenario: Element Screenshot Of Search Page Error
    Given I set my screensize to desktop
    When I visit "/search"
    Then I take screenshot of element "#block-investor-content"

  @blank_search @wdio
  Scenario: Full Screen Featured Info
    Given I set my screensize to desktop
    When I visit "/HelloWorld1"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @auto_complete @wdio
  Scenario: Element Screenshot Of Auto-Search
    Given I set my screensize to desktop
    When I visit "/"
      And I type "investor wdio tes" in "#edit-keys"
      And I wait for "3" seconds
    Then I take screenshot of element ".site-header"

  @glossary_search @wdio
  Scenario: Current Screen Glossary-Search
    Given I set my screensize to desktop
    When I visit "/introduction-investing/investing-basics/glossary"
      And I type "Test Glossary 1" in "#glossary-filter"
      And I hide "#twitter-widget-0"
    Then I take current window screenshot and add text "Glossary" to filename
