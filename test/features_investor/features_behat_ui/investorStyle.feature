Feature: Create Styles on Pages
  As a Content Creator, I want to be able to create basic page and add accordion
  So that visitors to investor.gov can learn about the investor styles

  @ui @javascript @api @wdio
  Scenario: Adding Accordion On Investor Page
    Given I am logged in as a user with the "administrator" role
      And I create "media" of type "image":
      | name        | field_media_image      | field_media_image_alt | mid   | moderation_state |
      | Black Bunny | behat-black_rabbit.jpg | bunny                 | 12227 | publication      |
      And "page" content:
      | title                         | status | nid |
      | Investor Behat Test Accordion | 1      | 2   |
    When I am on "/admin/content"
      And I click "Edit" in the "Investor Behat Test Accordion" row
      And I wait 2 seconds
      And I press the "Edit summary" button
      And I fill in "Summary" with "Accordion Test"
      And I select "Full HTML" from "edit-body-0-format--2"
      And I scroll "#edit-body-wrapper" into view
      And I wait 2 seconds
      And I press "Source" in the "Body" WYSIWYG Toolbar
      And I wait 2 seconds
      And I type '<p>&nbsp;</p> <div id="accordion-ST"> <p><strong>Testing Accordion on Local Env</strong></p> <div> <p>Things to follow for testing Accordion:</p> <ul><li>deploy new code;</li><li>Manually check on the environment;</li></ul></div> <p><strong>Any Automated Tests?</strong></p><div><p>&nbsp;</p><ul><li>behat</li><li>wdio</li></ul></div></div>' in css selector ".cke_source"
      And I wait 2 seconds
      And I select "Published" from "edit-moderation-state-0-state"
      And I wait 1 seconds
      And I press the "edit-submit" button
      And I wait for ajax to finish
      And I am on "/admin/content"
      And I wait 2 seconds
      And I click "Edit" in the "Investor Behat Test Accordion" row
      And I scroll "#edit-body-wrapper" into view
      And I wait 2 seconds
      And I press "Embed" in the "Body" WYSIWYG Toolbar
      And I select the first autocomplete option for "Black Bunny" on the "Name" field on a modal
      And I wait 1 seconds
      And I click "Next" on the modal "Select media item to embed"
      And I wait for ajax to finish
      And I click "Embed" on the modal "Embed media item"
      And I wait 2 seconds
      And I press the "edit-submit" button
      And I wait 1 seconds
      And I click "Investor Behat Test Accordion"
      And I wait 1 seconds
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_accordion1" tag
      And I wait 2 seconds
    When I click on the element with css selector "#ui-id-1 > span:nth-child(1)"
      And I wait 2 seconds
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_accordion2" tag
      And I wait 2 seconds
      And I click on the element with css selector "#ui-id-3 > span:nth-child(1)"
      And I wait 2 seconds
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_accordion3" tag

  @ui @javascript @api @wdio
  Scenario: Adding Bullets To The Glossary Term for WDIO
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/glossary_term"
      And I fill in "Title" with "Investor Behat Test Glossary"
      And I wait 2 seconds
      And I press "Source" in the "Body" WYSIWYG Toolbar
      And I wait 2 seconds
      And I type "<p>You can obtain all of these documents by:</p><ul><li>visiting the fund’s website;</li><li>calling or writing the fund (all funds have toll-free telephone numbers)</li><li>contacting a broker that sells the fund’s shares; or</li><li>accessing the <a href='https://www.sec.gov/edgar.shtml'>SEC’s EDGAR database</a>.</li></ul>" in css selector ".cke_source"
      And I wait 2 seconds
      And I uncheck "Show Featured Content"
      And I select "Published" from "edit-moderation-state-0-state"
      And I wait 1 seconds
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_bullets_glossary" tag

  @ui @javascript @api @wdio
  Scenario: Checking Accordion Text Size and Styling for WDIO
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
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_accordion_font" tag

  @api @javascript @ui @wdio
  Scenario: Verify Texts are Showing Bold When Using Strong for WDIO
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "Testing ticket 13871"
      And I press the "Edit summary" button
      And I fill in "Summary" with "Investor Behat Test Article"
      And I press "Bold" in the "Body" WYSIWYG Toolbar
      And I type "Testing body" in the "Body" WYSIWYG editor
      And I select "Published" from "edit-moderation-state-0-state"
      And I wait 1 seconds
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "styles.feature" file with "@inv_bold_font" tag

  @ui @javascript @api @wdio
  Scenario: Checking for round Bullets in Content Blocks
    Given I am on "/protect-your-investments"
    Then I take a screenshot on "investor" using "styles.feature" file with "@round_bullet_blocks" tag

  @ui @javascript @api @wdio
  Scenario: Create Glossary Term with Related Content WDIO
    Given I create "media" of type "image":
      | name             | field_media_image   | mid     |
      | BEHAT Image Test | behat-gold-pig.png  | 8272109 |
      And I create "media" of type "video":
      | name               | field_video_origin | field_video                                 | mid     | field_caption  |
      | BEHAT Rabbit Video | upload             |                                             | 8272108 | Rabbit caption |
      | BEHAT Dog Image    | youtubevimeo       | https://www.youtube.com/watch?v=xf9BpXOtMcc | 412313  | Dog caption    |
    When I am logged in as a user with the "Content Approver" role
      And I am on "/node/add/glossary_term"
      And I fill in "Title" with "Behat Test Glossary page"
      And I fill in "Glossary Category" with "#'s (5)"
      And I fill in "Alternate Name" with "Behat Test"
      And I press "Add Link"
      And I wait for ajax to finish
      And I fill in "URL" with "/files/behat-image-test" in the "new_link" region
      And I fill in "Link text" with "related name1" in the "new_link" region
      And I type "BEHAT Related content Message one" in the "Description" WYSIWYG editor number "0"
      And I press "Add Link"
      And I wait for ajax to finish
      And I fill in "URL" with "/media/412313" in the "new_link" region
      And I fill in "Link text" with "related name2" in the "new_link" region
      And I type "BEHAT Related content Message Two" in the "Description" WYSIWYG editor number "1"
      And I press "Add Link"
      And I wait for ajax to finish
      And I fill in "URL" with "/files/behat-rabbit-video" in the "new_link" region
      And I fill in "Link text" with "related name3" in the "new_link" region
      And I type "BEHAT Related content Message Three" in the "Description" WYSIWYG editor number "2"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press "edit-submit"
    Then I take a screenshot on "investor" using "styles.feature" file with "@glossary_relatedcontentstyle" tag

  @ui @javascript @api @wdio
  Scenario: Update Bullet and Font Style To The Glossary Term
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/glossary_term"
      And I fill in "Title" with "Investor Behat Test Glossary"
      And I press "Source" in the "Body" WYSIWYG Toolbar
      And I type "<p>A&nbsp;broker&nbsp;is a</p><ul><li>firm or individual</li><li>that engages in the business of buying and selling securities – stocks, bonds, mutual funds, exchange-traded funds (ETFs), and certain other investment products – on behalf of its customer (as broker), for its own account (dealer), or both.</li></ul><h3>Selecting a broker</h3><p>Brokers are required to act in your best interest when making a recommendation and not put their interest ahead of yours.&nbsp; &nbsp;</p><p>Before selecting a broker, you should consider:</p><ul><li>what services and products you need,</li><li>what services and products the broker can provide,</li><li>any limitations on what services and products the broker can provide,</li><li>how much you will pay for services and transactions,</li>" in css selector ".cke_source"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "styles.feature" file with "@glossary_relatedFontandBullets" tag

  @ui @javascript @api @wdio
  Scenario Outline: WDIO Paragraph Styles in WSYIWYG
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/node/add/article"
      And I fill in "Title" with "<title>"
      And I type "Investor Behat Text Size and Style Check" in the "Body" WYSIWYG editor
      And I choose style "<style>" within WYSIWYG selector "edit-body-0-value"
      And I select "Published" from "edit-moderation-state-0-state"
      And I press the "edit-submit" button
    Then I take a screenshot on "investor" using "styles.feature" file with "<tagname>" tag

    Examples:
      | style           | tagname        | title                        |
      | P Large font    | @PLargefont    | Article with P large font    |
      | P Small font    | @PSmallfont    | Article with P small font    |
      | P Smallest font | @PSmallestfont | Article with P smallest font |

  @ui @javascript @api @wdio
  Scenario: Verify Bullet Height Matches Text Height in Accordions in Custom Blocks
    Given I am logged in as a user with the "administrator" role
      And "page" content:
      | title              | body                                    | status | moderation_state | nid |
      | Test Page Investor | Behat Display Title http://www.SEC.gov/ | 1      | published        | 456 |
    When I visit "/block/add/feature_block"
      And I fill in "Block description" with "Accordion Bullets Test"
      And I fill in "Heading" with "Accordion BEHAT Example"
      And I select "Gray" from "Color scheme"
      And I select "3x" from "Width factor"
      And I press "Add Text"
      And I wait for ajax to finish
      And I select "Full HTML" from "Text format"
      And I press "Source" in the "Text" WYSIWYG Toolbar
      And I wait 2 seconds
      And I type '<div id="accordion-CRS"><p><strong>Behat Accordion 1</strong></p><div><ul><li>Fake number at 1-212-555-2368</li><li><a href="https://www.investor.gov/">Behat linked item 2</a></li></ul><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Your content here]<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Your content second line]</p></div><p><strong>Behat Accordion 2</strong></p><div><ul><li><a href="https://www.sec.gov/">Behat linked item 1</a>&nbsp;&nbsp;<br /><a href="https://www.sec.gov" target="_blank"><img alt="view of cat" src="/sites/investorgov/files/2023-02/behat-cat_0.png" /></a></li><li>The domestic house cat is theorized to have originated in Egypt</li><li>Cat fact 2</li><li>Cat fact 3</li><img alt="view of cat" src="/sites/investorgov/files/2023-02/behat-cat_1.png" /></ul></div></div>' in css selector ".cke_source"
      And I press "Save"
    Then I should see "Feature Block Accordion Bullets Test has been created."
    When I visit "/node/456/layout"
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div.layout-builder__region.js-layout-builder-region.layout__region.layout__region--second > div.layout-builder__add-block > a"
      And I wait for ajax to finish
      And I fill in "Filter by block name" with "Accordion"
      And I click "Accordion Bullets Test" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I press the "Add block" button
      And I wait for ajax to finish
      And I scroll to the top
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat Accordion 1"
      And I should see the text "Behat Accordion 2"
    Then I take a screenshot on "investor" using "styles.feature" file with "@bullet_height" tag
