Feature: IAPD Search
  As a site visitor, I can look up publicly disclosed information about an investment advisor's background, registration status, and past disciplinary or enforcement actions.

@api @javascript @investor
Scenario: IAPD Firm Search
  Given I am on "/"
  When I click on the element with css selector "#searchType" then click on "Firm" in the iframe selector "#sec-root>iframe"
    And I fill in input "searchBy" with the value "TD Ameri" in the iframe selector "#sec-root>iframe"
    And I wait 7 seconds
    And I wait for ajax to finish
  Then I should see the text "TD AMERITRADE, INC." with css selector ".listcontainer" in the iframe selector "#sec-root>iframe"

@api @javascript @investor
Scenario: IAPD Name Search
  Given I am on "/"
  When I click on the element with css selector "#searchType" then click on "Individual" in the iframe selector "#sec-root>iframe"
    And I fill in input "searchBy" with the value "munster" in the iframe selector "#sec-root>iframe"
    And I wait 7 seconds
    And I wait for ajax to finish
  Then I should see the text "EUGENE MUNSTER" with css selector ".listcontainer" in the iframe selector "#sec-root>iframe"

@api @javascript @investor
Scenario: IAPD Individual CRD# Search
  Given I am on "/"
  When I click on the element with css selector "#searchType" then click on "Individual" in the iframe selector "#sec-root>iframe"
    And I fill in input "searchBy" with the value "2798223" in the iframe selector "#sec-root>iframe"
    And I wait 7 seconds
    And I wait for ajax to finish
  Then I should see the text "CHARLES EUGENE MUNSTER" with css selector ".listcontainer" in the iframe selector "#sec-root>iframe"

@api @javascript @investor
Scenario: IAPD Firm CRD# Search
  Given I am on "/"
  When I click on the element with css selector "#searchType" then click on "Firm" in the iframe selector "#sec-root>iframe"
    And I fill in input "searchBy" with the value "5393" in the iframe selector "#sec-root>iframe"
    And I wait 7 seconds
    And I wait for ajax to finish
  Then I should see the text "CHARLES SCHWAB & CO., INC." with css selector ".listcontainer" in the iframe selector "#sec-root>iframe"
