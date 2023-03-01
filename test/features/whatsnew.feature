@whatsnew
Feature: What's New dynamic list view blocks
  As a content creator/approver
  I want to be able to add What's New blocks to articles and landing pages
  So that I can list recent content tagged with specific taxonomy terms

@api @javascript
Scenario: View what's new block on a landing page
  Given I am logged in as a user with the "content_approver" role
    And "whats_new" terms:
      | name      |
      | pupperino |
    And "secarticle" content:
      | field_article_type_secarticle | title                        | field_display_title                    | field_tags | moderation_state | status | field_primary_division_office | field_publish_date |
      | Other                         | (Behat) Bork bork am doggo 1 | (Behat) Bork bork am doggo (Display) 1 | pupperino  | published        | 1      | Agency-Wide                   | 1525464832         |
      | Other                         | (Behat) Bork bork am doggo 2 | (Behat) Bork bork am doggo (Display) 2 | pupperino  | published        | 1      | Agency-Wide                   | 1525464833         |
      | Other                         | (Behat) Bork bork am doggo 3 | (Behat) Bork bork am doggo (Display) 3 | pupperino  | published        | 1      | Agency-Wide                   | 1525464834         |
      | Other                         | (Behat) Bork bork am doggo 4 | (Behat) Bork bork am doggo (Display) 4 | pupperino  | published        | 1      | Agency-Wide                   | 1525464835         |
    And "landing_page" content:
      | title                      | field_display_title | field_left_1_box                                                      | field_left_nav_override | moderation_state | status |
      | (Behat) Doggo Landing Page | (Behat) Doggo       | Doggo ipsum borkf super chub heck adorable doggo, big ol long woofer. | About                   | published        | 1      |
  When I visit "/page/behat-doggo-landing-page" for term "pupperino" from taxonomy "whats_new"
    And I place the "What's New - 3 items" block into the "Sidebar Content" panelizer region
    And I click the panelizer "Save" link
    And I wait 2 seconds
    And I reload the page
  Then I should see the heading "(Behat) Doggo"
    And I should see the "Whats New: Three Item List" block in the panelsecond region
    And I should see the link "(Behat) Bork bork am doggo (Display) 4" before I see the link "(Behat) Bork bork am doggo (Display) 3" in the "Whats New" view
    And I should see the link "(Behat) Bork bork am doggo (Display) 3" before I see the link "(Behat) Bork bork am doggo (Display) 2" in the "Whats New" view
    And I should not see the link "(Behat) Bork bork am doggo (Display) 1" in the panelsecond region

  @api @javascript
  Scenario Outline: Verify the What's New Block On Landing Page
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
        | title                | field_display_title | field_left_1_box | moderation_state | status |
        | (Behat) Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
      And "secarticle" content:
        | title             | field_display_title | body       | field_article_type_secarticle | field_article_sub_type_secart | field_primary_division_office | status | field_tags | field_publish_date  |
        | BEHAT URL pattern | BEHAT URL pattern 1 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-01 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 2 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-02 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 3 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-03 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 4 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-04 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 5 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-05 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 6 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-06 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 7 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-07 12:00:00 |
    When I visit "/page/behat-landing-page"
      And I place the "<block>" block into the "Sidebar Content" panelizer region
      And I click the panelizer "Save" link
      And I click the panelizer "Edit" link
      And I wait for ajax to finish
      And I scroll to the bottom
      And I click on the element with css selector "<settingIcon>"
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-settings-views-label-checkbo']"
      And I fill in "Title" with "<list view header>"
      And I click on the element with css selector "input[value='Update']"
      And I wait for ajax to finish
      And I click the panelizer "Save" link
    Then I should see the text "<list view header>"
      And I should see the link "BEHAT URL pattern 7" before I see the link "BEHAT URL pattern 6" in the "Whats New" view
      And I should see the link "BEHAT URL pattern 6" before I see the link "BEHAT URL pattern 5" in the "Whats New" view
    When I click "View more"
    Then I should be on "<tid>"
      And I should see the text "Jan. 7, 2032" in the "BEHAT URL pattern 7" row
      And I should see the text "Jan. 6, 2032" in the "BEHAT URL pattern 6" row
      And I should see the text "Jan. 5, 2032" in the "BEHAT URL pattern 5" row
      And I should see the text "Jan. 4, 2032" in the "BEHAT URL pattern 4" row
      And I should see the text "Jan. 3, 2032" in the "BEHAT URL pattern 3" row
      And I should see the text "Jan. 2, 2032" in the "BEHAT URL pattern 2" row
      And I should see the text "Jan. 1, 2032" in the "BEHAT URL pattern 1" row
      And "BEHAT URL pattern 7" should precede "BEHAT URL pattern 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 6" should precede "BEHAT URL pattern 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 5" should precede "BEHAT URL pattern 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 4" should precede "BEHAT URL pattern 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 3" should precede "BEHAT URL pattern 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 2" should precede "BEHAT URL pattern 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

    Examples:
      | Division     | Type                  | tag             | block                       | tid                  | list view header                                       | settingIcon                                                                                                                 |
      | Acquisitions | Academic Publications | BRO             | What's New - 3 items - BRO  | /whats-new?tid=33881 | News and Events from the Boston Regional Office        | div.whats_new-block_2 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | ARO             | What's New - 3 items - ARO  | /whats-new?tid=33876 | News and Events from the Atlanta Regional Office       | div.whats_new-block_1 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | OASB What's New | What's New - 3 items - OASB | /whats-new?tid=35221 | OASB News                                              | div.whats_new-block_10 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure |
      | Acquisitions | Academic Publications | OCA What's New  | What's New - 3 items - OCA  | /whats-new?tid=34916 | Office of the Chief Accountant                         | div.whats_new-block_11 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure |
      | Acquisitions | Academic Publications | PLRO            | What's New - 3 items - PLRO | /whats-new?tid=33871 | News and Events from the Philadelphia Regional Office  | div.whats_new-block_12 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure |
      | Acquisitions | Academic Publications | SFRO            | What's New - 3 items - SFRO | /whats-new?tid=33921 | News and Events from the San Francisco Regional Office | div.whats_new-block_13 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure |
      | Acquisitions | Academic Publications | SLRO            | What's New - 3 items - SLRO | /whats-new?tid=33916 | News and Events from the Salt Lake Regional Office     | div.whats_new-block_14 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure |
      | Acquisitions | Academic Publications | CHRO            | What's New - 3 items - CHRO | /whats-new?tid=33886 | News and Events from the Chicago Regional Office       | div.whats_new-block_3 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | DRO             | What's New - 3 items - DRO  | /whats-new?tid=33891 | News and Events from the Denver Regional Office        | div.whats_new-block_4 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | FWRO            | What's New - 3 items - FWRO | /whats-new?tid=33896 | News and Events from the Fort Worth Regional Office    | div.whats_new-block_5 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | IM What's New   | What's New - 3 items - IM   | /whats-new?tid=34141 | Investment Management                                  | div.whats_new-block_6 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | LARO            | What's New - 3 items - LARO | /whats-new?tid=33901 | News and Events from the Los Angeles Regional Office   | div.whats_new-block_7 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | MIRO            | What's New - 3 items - MIRO | /whats-new?tid=33906 | News and Events from the Miami Regional Office         | div.whats_new-block_8 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |
      | Acquisitions | Academic Publications | NYRO            | What's New - 3 items - NYRO | /whats-new?tid=33911 | News and Events from the New York Regional Office      | div.whats_new-block_9 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure  |

  @api @javascript
  Scenario Outline: Verify the What's New List On Landing Page
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
        | title                     | field_display_title | field_left_1_box | moderation_state | status |
        | List View on Landing Page | Behat Landing Page  | Give me the keys | published        | 1      |
      And "secarticle" content:
        | title             | field_display_title | body       | field_article_type_secarticle | field_article_sub_type_secart | field_primary_division_office | status | field_tags | field_publish_date  |
        | BEHAT URL pattern | BEHAT URL pattern 1 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-01 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 2 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-02 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 3 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-03 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 4 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-04 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 5 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-05 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 6 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-06 12:00:00 |
        | BEHAT URL pattern | BEHAT URL pattern 7 | Memorandum | <Type>                        | <SubType>                     | <Division>                    | 1      | <tag>      | 2032-01-07 12:00:00 |
    When I visit "/page/list-view-landing-page"
      And I place the "<listView>" block into the "Top Content" panelizer region
      And I click the panelizer "Save" link
      And I click the panelizer "Edit" link
      And I wait for ajax to finish
      And I click on the element with css selector "<settingIcon>"
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-settings-views-label-checkbo']"
      And I fill in "Title" with "<list view header>"
      And I click on the element with css selector "input[value='Update']"
      And I wait for ajax to finish
      And I click the panelizer "Save" link
    Then I should see the text "<list view header>"
      And I should see the text "Jan. 7, 2032" in the "BEHAT URL pattern 7" row
      And I should see the text "Jan. 6, 2032" in the "BEHAT URL pattern 6" row
      And I should see the text "Jan. 5, 2032" in the "BEHAT URL pattern 5" row
      And I should see the text "Jan. 4, 2032" in the "BEHAT URL pattern 4" row
      And I should see the text "Jan. 3, 2032" in the "BEHAT URL pattern 3" row
      And I should see the text "Jan. 2, 2032" in the "BEHAT URL pattern 2" row
      And I should see the text "Jan. 1, 2032" in the "BEHAT URL pattern 1" row
      And "BEHAT URL pattern 7" should precede "BEHAT URL pattern 6" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 6" should precede "BEHAT URL pattern 5" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 5" should precede "BEHAT URL pattern 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 4" should precede "BEHAT URL pattern 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 3" should precede "BEHAT URL pattern 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "BEHAT URL pattern 2" should precede "BEHAT URL pattern 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

    Examples:
      | Division     | Type                  | tag             | listView                 | tid                  | list view header                                       | settingIcon                                                                                                                              |
      | Acquisitions | Academic Publications | BRO             | What's New - List - BRO  | /whats-new?tid=33881 | News and Events from the Boston Regional Office        | div.whats_new-block_16 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | ARO             | What's New - List - ARO  | /whats-new?tid=33876 | News and Events from the Atlanta Regional Office       | div.whats_new-block_15 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | OASB What's New | What's New - List - OASB | /whats-new?tid=35221 | OASB News                                              | div.whats_new-block_24 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | OCA What's New  | What's New - List - OCA  | /whats-new?tid=34916 | Office of the Chief Accountant                         | div.whats_new-block_25 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | PLRO            | What's New - List - PLRO | /whats-new?tid=33871 | News and Events from the Philadelphia Regional Office  | div.whats_new-block_26 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | SFRO            | What's New - List - SFRO | /whats-new?tid=33921 | News and Events from the San Francisco Regional Office | div.whats_new-block_27 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | SLRO            | What's New - List - SLRO | /whats-new?tid=33916 | News and Events from the Salt Lake Regional Office     | div.whats_new-block_28 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | CHRO            | What's New - List - CHRO | /whats-new?tid=33886 | News and Events from the Chicago Regional Office       | div.whats_new-block_17 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | DRO             | What's New - List - DRO  | /whats-new?tid=33891 | News and Events from the Denver Regional Office        | div.whats_new-block_18 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | FWRO            | What's New - List - FWRO | /whats-new?tid=33896 | News and Events from the Fort Worth Regional Office    | div.whats_new-block_19 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | IM What's New   | What's New - List - IM   | /whats-new?tid=34141 | Investment Management                                  | div.whats_new-block_20 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | LARO            | What's New - List - LARO | /whats-new?tid=33901 | News and Events from the Los Angeles Regional Office   | div.whats_new-block_21 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | MIRO            | What's New - List - MIRO | /whats-new?tid=33906 | News and Events from the Miami Regional Office         | div.whats_new-block_22 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |
      | Acquisitions | Academic Publications | NYRO            | What's New - List - NYRO | /whats-new?tid=33911 | News and Events from the New York Regional Office      | div.whats_new-block_23 > div.ipe-actions-block.ipe-actions > ul.ipe-action-list > li > a > span.ipe-icon.ipe-icon-configure:nth-child(1) |

  @api @javascript
  Scenario Outline: Verify Support For Link Nodes On What's New Block For Regional Office Landing Pages
    Given "link" content:
      | title        | field_url                            | status | moderation_state | field_publish_date  | field_tags |
      | <tag> Link 1 | SEC Link - https://www.sec.gov       | 1      | published        | 2032-12-11 12:00:00 | <tag>      |
      | <tag> Link 2 | Google Link - https://www.google.com | 1      | published        | 2032-03-11 16:00:00 | <tag>      |
      And "secarticle" content:
        | title           | field_display_title | body       | status | field_tags | field_publish_date  |
        | <tag> Article 1 | <tag> article 1     | Memorandum | 1      | <tag>      | 2032-11-06 12:00:00 |
      And "news" content:
        | field_news_type_news | moderation_state | title        | status | body                    | field_display_title | field_publish_date  | field_tags |
        | Press Release        | published        | <tag> News 1 | 1      | This is the first body. | <tag> news 1        | 2032-09-11 12:00:00 | <tag>      |
    When I visit "/regional-office/<reg_ofc>"
    Then I should see the text "Regional Office"
      And I should see the link "SEC Link" before I see the link "<tag> article 1" in the "Whats New" view
      And I should see the link "<tag> article 1" before I see the link "<tag> news 1" in the "Whats New" view
    When I click "View more"
      And I wait 1 seconds
    Then I should be on "<tid>"
      And I should see the text "<list_view_header>"
      And I should see the text "Dec. 11, 2032" in the "SEC Link" row
      And I should see the text "Nov. 6, 2032" in the "<tag> article 1" row
      And I should see the text "Sept. 11, 2032" in the "<tag> news 1" row
      And I should see the text "March 11, 2032" in the "Google Link" row
      And "SEC Link" should precede "<tag> article 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "<tag> article 1" should precede "<tag> news 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
      And "<tag> news 1" should precede "Google Link" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

    Examples:
      | reg_ofc       | tag  | tid                  | list_view_header                                       |
      | san-francisco | SFRO | /whats-new?tid=33921 | News and Events from the San Francisco Regional Office |
      | fort-worth    | FWRO | /whats-new?tid=33896 | News and Events from the Fort Worth Regional Office    |
      | miami         | MIRO | /whats-new?tid=33906 | News and Events from the Miami Regional Office         |
      | new-york      | NYRO | /whats-new?tid=33911 | News and Events from the New York Regional Office      |
      | philadelphia  | PLRO | /whats-new?tid=33871 | News and Events from the Philadelphia Regional Office  |
      # The below regional offices will be using the same setup as above in the future therefore commenting these lines out for now
      # | boston        | BRO  | /whats-new?tid=33881 | News and Events from the Boston Regional Office        |
      # | atlanta       | ARO  | /whats-new?tid=33876 | News and Events from the Atlanta Regional Office       |
      # | chicago       | CHRO | /whats-new?tid=33886 | News and Events from the Chicago Regional Office       |
      # | denver        | DRO  | /whats-new?tid=33891 | News and Events from the Denver Regional Office        |
      # | los-angeles   | LARO | /whats-new?tid=33901 | News and Events from the Los Angeles Regional Office   |
      # | salt-lake     | SLRO | /whats-new?tid=33916 | News and Events from the Salt Lake Regional Office     |
