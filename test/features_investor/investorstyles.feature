Feature: Add and change styles
  As content creator to the Investor.gov
  I want to be able to add styling to my content

@api @javascript @investor
Scenario: Adding Accordion Styling
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/media/add/image"
    And I fill in "Name" with "Gold Pig"
    And attach the file "behat-gold-pig.png" to "Image"
    And I wait 5 seconds
    And I fill in "Alternative text" with "goldy"
    And I wait for ajax to finish
    And I press the "Save" button
    And I am on "/node/add/page"
    And I fill in "Title" with "Investor Behat Test Accordion"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Accordion Test"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I wait 2 seconds
    And I type '<p>&nbsp;</p> <div id="accordion-ST"> <p><strong>Testing accordion on cloud environment</strong></p> <div> <p>Things to follow for testing accordion styling:</p> <ul><li>Deploy new code;</li><li>Manually check on cloud environment;</li></ul></div> <p><strong>Any Automated Tests?</strong></p><div><p>&nbsp;</p><ul><li>behat</li><li>wdio</li></ul></div></div>' in css selector ".cke_source"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
    And I wait 1 seconds
  Then I should see the text "Testing accordion on cloud environment"
    And I should see the text "Any Automated Tests?"
  When I click on the element with css selector "#ui-id-1 > span:nth-child(1)"
    And I wait 2 seconds
  Then I should see the text "Deploy new code;"
    And I should see the text "Manually check on cloud environment;"
  When I click on the element with css selector "#ui-id-3 > span:nth-child(1)"
    And I wait 2 seconds
  Then I should see the text "behat"
    And I should see the text "wdio"
  When I am on "/admin/content"
    And I wait 2 seconds
    And I click "Edit" in the "Investor Behat Test Accordion" row
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I press "Embed" in the "Body" WYSIWYG Toolbar
    And I select the first autocomplete option for "Gold Pig" on the "Name" field on a modal
    And I wait 1 seconds
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I click "Embed" on the modal "Embed media item"
    And I wait 2 seconds
    And I press the "edit-submit" button
    And I wait 1 seconds
  Then I should see the text "Basic page Investor Behat Test Accordion has been updated."
  When I click "Investor Behat Test Accordion"
    And I wait 2 seconds
  Then I should see the "img" element with the "alt" attribute set to "goldy" in the "accordion_img" region
    And I should see the text "Any Automated Tests?"
  When I click on the element with css selector "#ui-id-1 > span:nth-child(1)"
    And I wait 2 seconds
  Then I should see the text "Deploy new code;"
    And I should see the text "Manually check on cloud environment;"
  When I click on the element with css selector "#ui-id-3 > span:nth-child(1)"
    And I wait 2 seconds
  Then I should see the text "behat"
    And I should see the text "wdio"

@api @javascript @investor
Scenario: Adding Bullet Points To The Article
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I wait 2 seconds
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I wait 2 seconds
    And I type "<ul><li>test 1</li><li>test 2</li><li>test 3</li></ul><p>Hello</p><ol><li>John<ol><li>Doe</li></ol></li><li>Mike<ol><li>Ruby</li></ol></li><li>Chris<ol><li>Freeman</li></ol></li></ol>" in css selector ".cke_source"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "test 1" in the "bulletedListFirst" region
    And I should see the text "test 2" in the "bulletedListSecond" region
    And I should see the text "test 3" in the "bulletedListThird" region
    And I should see the text "John" in the "numberedListFirst" region
    And I should see the text "Doe" in the "numberedListFirstSub" region
    And I should see the text "Mike" in the "numberedListSecond" region
    And I should see the text "Ruby" in the "numberedListSecondSub" region
    And I should see the text "Chris" in the "numberedListThird" region
    And I should see the text "Freeman" in the "numberedListThirdSub" region

@api @javascript @investor
Scenario: Adding Bullet Points To The Glossary Term
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/glossary_term"
    And I fill in "Title" with "Investor Behat Test Glossary"
    And I wait 2 seconds
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I wait 2 seconds
    And I type "<p>You can obtain all of these documents by:</p><ul><li>visiting the fund’s website;</li><li>calling or writing the fund (all funds have toll-free telephone numbers)</li><li>contacting a broker that sells the fund’s shares; or</li><li>accessing the <a href='https://www.sec.gov/edgar.shtml'>SEC’s EDGAR database</a>.</li></ul>" in css selector ".cke_source"
    And I wait 2 seconds
    And I select "Published" from "edit-moderation-state-0-state"
    And I wait 1 seconds
    And I press the "edit-submit" button
  Then I should see the text "visiting the fund’s website;" in the "bulletedListFirst" region
    And I should see the text "calling or writing the fund (all funds have toll-free telephone numbers)" in the "bulletedListSecond" region
    And I should see the text "contacting a broker that sells the fund’s shares; or" in the "bulletedListThird" region
    And I should see the text "accessing the SEC’s EDGAR database." in the "bulletedListForth" region

@api @javascript @investor
Scenario: Accordion Text Size and Styling
  Given I am logged in as a user with the "Content Approver" role
  When I visit "/node/add/news"
    And I fill in "Title" with "Behat Text Size and Style Check"
    And I wait 1 seconds
    And I type "Investor Behat Text Size and Style Check" in the "Body" WYSIWYG editor
    And I wait 2 seconds
    And I press the "Edit summary" button
    And I fill in "Summary" with "Behat Test Alert Summary"
    And I select "Full HTML" from "edit-body-0-format--2"
    And I wait 2 seconds
    And I press "Source" in the "Body" WYSIWYG Toolbar
    And I type '<div id="accordion-sample"><p>Section 1 - regular text style</p><div>[Your regular content here]</div></div><div id="accordion-sample"><p>Section 2 - regular text style</p><div>[Your regular content here]</div></div>' in css selector ".cke_source"
    And I select "Investor Alerts" from "News Type"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "Save"
  Then I should see the text "Behat Text Size and Style Check"
  When I click on the element with css selector "#ui-id-1 > span:nth-child(1)"
  Then I should see the text "[Your regular content here]"
  When I click on the element with css selector "#ui-id-3 > span:nth-child(1)"
  Then I should see the text "[Your regular content here]"
    And I should see the "h1" element with the "class" attribute set to "page-title" in the "contentbanner" region

@api @javascript @investor
Scenario Outline: Paragraph Styles Font Size in WSYIWYG
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test Article"
    And I type "Investor Behat Text Size and Style Check" in the "Body" WYSIWYG editor
    And I choose style "<style>" within WYSIWYG selector "edit-body-0-value"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "edit-submit" button
  Then I should see the "P" element with the "class" attribute set to "<result>" in the "article_content" region

    Examples:
      | style           | result       |
      | P Large font    | text--cke-lg |
      | P Small font    | text--cke-sm |
      | P Smallest font | text--cke-xs |
