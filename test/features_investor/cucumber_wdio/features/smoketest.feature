Feature: Smokescreen Full Page Screenshots

  @youth-resources @wdio
  Scenario: Take Full Screenshot of youth-resources
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/youth-resources"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @saving-investing-resources-teachers @wdio
  Scenario: Take Full Screenshot of saving-investing-resources-teachers
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/saving-investing-resources-teachers"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @world-investor-week @wdio
  Scenario: Take Full Screenshot of world-investor-week
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/world-investor-week"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @public-service-campaign @wdio
  Scenario: Take Full Screenshot of public-service-campaign
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/public-service-campaign"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @glossary @wdio
  Scenario: Take Full Screenshot of glossary
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basic/glossary"
    Then I take current window screenshot and add text "glossary" to filename

  @about-us @wdio
  Scenario: Take Full Screenshot of about-us
    Given I set my screensize to desktop
      And I hide "#twitter-widget-0"
    Then I take full page screenshot of "/about-us" URL and hide ".flex-video"

  @contact-us @wdio
  Scenario: Take Full Screenshot of contact-us
    Given I set my screensize to desktop
      And I hide "#twitter-widget-0"
    Then I take full page screenshot of "/contact-us" URL

  @follow-us-social-media @wdio
  Scenario: Take Full Screenshot of follow-us-social-media
    Given I set my screensize to desktop
      And I visit "/follow-us-social-media"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @espanol @wdio
  Scenario: Take Full Screenshot of espanol
    Given I set my screensize to desktop
      And I visit "/espanol"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @how-stock-markets-work @wdio
  Scenario: Take Full Screenshot of how-stock-markets-work
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/how-stock-markets-work"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @role-sec @wdio
  Scenario: Take Full Screenshot of role-sec
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/role-sec"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @laws-govern-securities-industry @wdio
  Scenario: Take Full Screenshot of laws-govern-securities-industry
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/role-sec/laws-govern-securities-industry"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @how-avoid-fraud @wdio
  Scenario: Take Full Screenshot of how-avoid-fraud
    Given I set my screensize to desktop
      And I visit "/protect-your-investments/fraud/how-avoid-fraud"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @asset-allocation @wdio
  Scenario: Take Full Screenshot of asset-allocation
    Given I set my screensize to desktop
      And I visit "/research-before-you-invest/research/asset-allocation"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @using-emma-researching-municipal-securities @wdio
  Scenario: Take Full Screenshot of using-emma-researching-municipal-securities
    Given I set my screensize to desktop
      And I visit "/researching-managing-investments/researching-investments/using-emma-researching-municipal-securities"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @assessing-your-risk-tolerance @wdio
  Scenario: Take Full Screenshot of assessing-your-risk-tolerance
    Given I set my screensize to desktop
      And I visit "/research-before-you-invest/research/assessing-your-risk-tolerance"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @what-are-mechanics-voting-either-person-or @wdio
  Scenario: Take Full Screenshot of what-are-mechanics-voting-either-person-or
    Given I set my screensize to desktop
      And I visit "/research-before-you-invest/research/shareholder-voting/what-are-mechanics-voting-either-person-or"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @researching-investments @wdio
  Scenario: Take Full Screenshot of researching-investments
    Given I set my screensize to desktop
      And I visit "/research-before-you-invest/research/researching-investments"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @submit-questions-complaints @wdio
  Scenario: Take Full Screenshot of submit-questions-complaints
    Given I set my screensize to desktop
      And I visit "/protect-your-investments/seek-help/submit-questions-complaints"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @arbitration-mediation-clinics @wdio
  Scenario: Take Full Screenshot of arbitration-mediation-clinics
    Given I set my screensize to desktop
      And I visit "/protect-your-investments/seek-help/arbitration-mediation-clinics"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @403b-plan @wdio
  Scenario: Take Full Screenshot of 403b-plan
    Given I set my screensize to desktop
      And I visit "/additional-resources/general-resources/glossary/403b-plan"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @resources-victims-securities-law-violations @wdio
  Scenario: Take Full Screenshot of Victims Securities
    Given I set my screensize to desktop
      And I visit "/protect-your-investments/fraud/resources-victims-securities-law-violations"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @introduction-investing @wdio
  Scenario: Take Full Screenshot of intro to investing
    Given I set my screensize to desktop
      And I visit "/introduction-investing"
      And I hide "#twitter-widget-0"
      And I hide ".flex-video"
    Then I take full page screenshot

  @research-before-you-invest @wdio
  Scenario: Take Full Screenshot of research-before-you-invest
    Given I set my screensize to desktop
      And I visit "/research-before-you-invest"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @additional-resources @wdio
  Scenario: Take Full Screenshot of additional-resources
    Given I set my screensize to desktop
      And I visit "/additional-resources"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @useful-websites @wdio
  Scenario: Take Full Screenshot of useful-websites
    Given I set my screensize to desktop
      And I visit "/additional-resources/general-resources/useful-websites"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @spotlight-initial-coin-offerings-digital-assets @wdio
  Scenario: Take Full Screenshot of spotlight-initial-coin-offerings-digital-assets
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/spotlight-initial-coin-offerings-digital-assets"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @seniors @wdio
  Scenario: Take Full Screenshot of seniors
    Given I set my screensize to desktop
      And I visit "/seniors"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @military @wdio
  Scenario: Take Full Screenshot of military
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/military"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @native-americans @wdio
  Scenario: Take Full Screenshot of native-americans
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/native-americans"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @directors-take @wdio
  Scenario: Take Full Screenshot of directors-take
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/directors-take"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @librarian-resources-page @wdio
  Scenario: Take Full Screenshot of librarian-resources-page
    Given I set my screensize to desktop
      And I visit "/additional-resources/specialized-resources/librarian-resources-page"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @529-expense-analyzer @wdio
  Scenario: Take Full Screenshot of 529-expense-analyzer
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/529-expense-analyzer"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @mutual-fund-analyzer @wdio
  Scenario: Take Full Screenshot of mutual-fund-analyzer
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/mutual-fund-analyzer"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @retirement-estimator @wdio
  Scenario: Take Full Screenshot of retirement-estimator
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/retirement-estimator"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @ballpark-etimate @wdio
  Scenario: Take Full Screenshot of ballpark-etimate
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/ballpark-etimate"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @rmd-calculator @wdio
  Scenario: Take Full Screenshot of required-minimum-distribution-calculator
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/required-minimum-distribution-calculator"
      And I remove "#twitter-widget-0"
      And I hide ".layout__region--content > div:nth-child(1) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(2) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(3) > div >div >div > img"
    Then I take full page screenshot

  @ci-calculator @wdio
  Scenario: Take Full Screenshot of compound-interest-calculator
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/compound-interest-calculator"
      And I remove "#twitter-widget-0"
      And I hide ".layout__region--content > div:nth-child(1) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(2) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(3) > div >div >div > img"
    Then I take full page screenshot

  @savings-goal-calculator @wdio
  Scenario: Take Full Screenshot of savings-goal-calculator
    Given I set my screensize to desktop
      And I visit "/additional-resources/free-financial-planning-tools/savings-goal-calculator"
      And I remove "#twitter-widget-0"
      And I hide ".layout__region--content > div:nth-child(1) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(2) > div >div >div > img"
      And I hide ".layout__region--content > div:nth-child(3) > div >div >div > img"
    Then I take full page screenshot

  @save-invest @wdio
  Scenario: Take Full Screenshot of save-invest
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/save-invest"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @invest-your-goals @wdio
  Scenario: Take Full Screenshot of invest-your-goals
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/invest-your-goals"
      And I hide ".flex-video"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @investment-products @wdio
  Scenario: Take Full Screenshot of investment-products
    Given I set my screensize to desktop
      And I visit "/introduction-investing/basics/investment-products"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @investment-professionals @wdio
  Scenario: Take Full Screenshot of investment-professionals
    Given I set my screensize to desktop
      And I visit "/investment-professionals"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @free-financial-planning-tools @wdio
  Scenario: Take Full Screenshot of free-financial-planning-tools
    Given I set my screensize to desktop
      And I visit "/financial-tools-calculators"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @protectMainPage @wdio
  Scenario: Element Screenshot of Protect Main Page
    Given I set my screensize to desktop
    When I visit "/protect-your-investments"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @researchingInvestments @wdio
  Scenario: Element Screenshot of Researching Investments
    Given I set my screensize to desktop
    When I visit "/introduction-investing/getting-started/researching-investments"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @fiveQuestions @wdio
  Scenario: Element Screenshot of Five Questions to Ask
    Given I set my screensize to desktop
    When I visit "/introduction-investing/getting-started/five-questions-ask-you-invest"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @investmentProducts @wdio
  Scenario: Element Screenshot of Investment Products
    Given I set my screensize to desktop
    When I visit "/introduction-investing/basics/investment-products"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @usingEdgar @wdio
  Scenario: Element Screenshot of Using Edgar
    Given I set my screensize to desktop
    When I visit "/introduction-investing/getting-started/researching-investments/using-edgar-research-investments"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @researchBeforeYouInvest @wdio
  Scenario: Element Screenshot of Research Before You Invest
    Given I set my screensize to desktop
    When I visit "/introduction-investing/getting-started/understanding-fees"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @avoidInvestmentFraud @wdio
  Scenario: Element Screenshot of Avoid Investment Fraud
    Given I set my screensize to desktop
    When I visit "/protect-your-investments/fraud/how-avoid-fraud/what-you-can-do-avoid-investment-fraud"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @typesOfFraud @wdio
  Scenario: Element Screenshot of Types of Fraud
    Given I set my screensize to desktop
    When I visit "/protect-your-investments/fraud/types-fraud"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @victimResources @wdio
  Scenario: Element Screenshot of Victim Resources
    Given I set my screensize to desktop
    When I visit "/protect-your-investments/fraud/resources-victims-securities-law-violations"
      And I hide "#twitter-widget-0"
    Then I take full page screenshot

  @sitemap @wdio
  Scenario: Take Full Screenshot of XML Sitemap
    Given I set my screensize to desktop
    When I visit "/sitemap.xml"
    Then I take full page screenshot
