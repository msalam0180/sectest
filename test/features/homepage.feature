Feature: Homepage
  As a Content Creator
  I want to be able to create and tag content
  So that visitors to SEC.gov can view dynamic content in the homepage sections

@api
Scenario: View a site alert on the homepage
  Given "sec_alert" content:
    | title            | moderation_state | field_alert_type | body                       |
    | BEHAT Test Alert | published        | Critical         | BEHAT Test Alert body text |
  When I visit "/"
  Then I should see the text "BEHAT Test Alert" in the alerttitle region
  Then I should see the text "BEHAT Test Alert body text" in the alertbody region

  #Does not work Story is not an Article type
  #@api
  #Scenario: View SEC Story content on the homepage
  #Given "secarticle" content:
  #  | field_article_type_secarticle | title               | field_tags  | promote | field_display_title        | body                      | field_description_abstract             | field_primary_division_office | moderation_state | status |
  #  | Story                         | BEHAT Test Story I  | SEC Stories | 1       | BEHAT Test Story Title I@  | BEHAT Test Story Body I   | This is the story description abstract | Agency-wide                   | published        | 1      |
  #  | Story                         | BEHAT Test Story II | SEC Stories | 1       | BEHAT Test Story Title II@ | BEHAT Test Story Body II  | This is the story description abstract | Agency-wide                   | published        | 1      |
  #When I visit "/"
  #Then I should see 2 nodes in the "SEC Stories" block
  #Then I should see the text "BEHAT Test Story Title I@" in the storyleft region
  #Then I should see the text "BEHAT Test Story Title II@" in the storyleft region

@api
Scenario: View We Inform and Protect Investors featured content on the homepage
  Given "landing_page" content:
    | title                                              | field_tags                      | promote | field_display_title                         | body                                        | field_description_abstract                                       | moderation_state | status |
    | BEHAT We Inform and Protect Investors Landing Page | We Inform and Protect Investors | 1       | BEHAT We Inform and Protect Investors Title | BEHAT We Inform and Protect Investors Body  | This is the We Inform and Protect Investors description abstract | published        | 1      |
  When I visit "/"
  Then I should see 1 nodes in the "We Inform and Protect Investors" block
    And I should see the text "BEHAT We Inform and Protect Investors Title" in the informprotectright region

#This one fails, this testing is not fool proof if content is brought down that already has a node in that block.
#  @api
#  Scenario: View We Facilitate Capital Formation featured content on the homepage
#  Given "landing_page" content:
#    | title                                              | field_tags                      | promote | field_display_title                         | body                                        | field_description_abstract                                       | moderation_state | status |
#    | BEHAT We Facilitate Capital Formation Landing Page | We Facilitate Capital Formation | 1       | BEHAT We Facilitate Capital Formation Title | BEHAT We Facilitate Capital Formation Body  | This is the We Facilitate Capital Formation description abstract | published        | 1      |
#  When I visit "/"
#  Then I should see 1 nodes in the "We Facilitate Capital Formation" block
#    And I should see the text "BEHAT We Facilitate Capital Formation Landing Page" in the facilitatecapitalformationleft region

@api
Scenario: View We Provide Data featured content on the homepage
  Given "landing_page" content:
    | title                              | field_tags      | promote | field_display_title         | body                        | field_description_abstract                       | moderation_state | status |
    | BEHAT We Provide Data Landing Page | We Provide Data | 1       | BEHAT We Provide Data Title | BEHAT We Provide Data Body  | This is the We Provide Data description abstract | published        | 1      |
  When I visit "/"
  Then I should see 1 nodes in the "We Provide Data" block
    And I should see the text "BEHAT We Provide Data Title" in the providedataright region

@api
Scenario: View We Regulate Securities Markets featured content on the homepage
  Given "landing_page" content:
    | title                                             | field_tags                     | promote | field_display_title                        | body                                       | field_description_abstract                                      | moderation_state | status |
    | BEHAT We Regulate Securities Markets Landing Page | We Regulate Securities Markets | 1       | BEHAT We Regulate Securities Markets Title | BEHAT We Regulate Securities Markets Body  | This is the We Regulate Securities Markets description abstract | published        | 1      |
  When I visit "/"
  Then I should see 1 nodes in the "We Regulate Securities Markets" block
    And I should see the text "BEHAT We Regulate Securities Markets Title" in the regulatesecuritiesmarketsleft region

@api
Scenario: View We Enforce Federal Securities Laws featured content on the homepage
  Given "landing_page" content:
    | title                                                 | field_tags                         | promote | field_display_title        | body                                          | field_description_abstract                                          | moderation_state | status |
    | BEHAT We Enforce Federal Securities Laws Landing Page | We Enforce Federal Securities Laws | 1       | BEHAT Whistleblower Awards | BEHAT We Enforce Federal Securities Laws Body | This is the We Enforce Federal Securities Laws description abstract | published        | 1      |
  When I visit "/"
  Then I should see 1 nodes in the "We Enforce Federal Securities Laws" block
    And I should see the text "BEHAT Whistleblower Awards" in the enforcefederalsecuritieslawsleft region

@api @javascript
Scenario: Latest Data Sets block no longer prevents from adding a new block to the homepage
  Given I am logged in as a user with the "content_creator" role
  When I visit "/"
  Then I should see the text "Latest Data Sets"
  When I place the "Homepage: Whistleblowing Provisions" block into the "Section 6 Right Content" panelizer region
    And I click the panelizer "Save" link
    And I wait for ajax to finish
    And I reload the page
    And I scroll ".block-region-section-6-right" into view
  Then I should see the text "Homepage: Whistleblowing Provisions"
    And I should see the text "Latest Data Sets"

@api @javascript
Scenario: Latest Data Sets block no longer prevents from replacing block to the homepage
  Given I create "media" of type "video_media":
    | name            | field_display_title | field_remote_video_url                      | field_media_transcript | status | field_promoted_to_front_page |
    | BEHAT Cat Video | Cat on YouTube      | https://www.youtube.com/watch?v=QIobikJiTuU | cat transcript         | 1      | 1                            |
    | BEHAT Dog Video | Dog on Vimeo        | https://vimeo.com/343314163                 | dog transcript         | 1      | 1                            |
    And I am logged in as a user with the "content_creator" role
  When I visit "/"
    And I click the panelizer "Edit" link
    And I wait for ajax to finish
    And I scroll ".featured_video_media-block_2" into view
    And I remove the "Featured Video Media: Homepage" block from the "Section 1 Left Content" panelizer region
    And I wait for ajax to finish
    And I click the panelizer "Save" link
    And I wait for ajax to finish
    And I reload the page
  Then I should not see the text "Featured Video"
  When I place the "Featured Video Media: Homepage" block into the "Section 1 Left Content" panelizer region
    And I click the panelizer "Save" link
    And I wait for ajax to finish
    And I reload the page
  Then I should see the text "Featured Video"

@api @javascript
Scenario: Update Theme to uswdssec and Validate Custom Header
  Given I am logged in as a user with the "sitebuilder" role
  When I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(6) > div > ul > li:nth-child(3) > a"
    And I am logged in as a user with the "authenticated user" role
    And I visit "/"
  Then I should see "An official website of the United States government"
  When I click on the element with css selector "#top > div.dialog-off-canvas-main-canvas > div > section > div > header > div > button"
    And I wait 10 seconds
  Then I should see "Official websites use .gov"
    And I should see "Secure .gov websites use HTTPS"
    And I should see "U.S. Securities and Exchange Commission"
    And I should see the "img" element with the "src" attribute set to "/themes/custom/uswdssec/dist/images/sec-logo.png" in the "header_uswdssec" region
    And I should not see the link "Company Filings"
  # Return the theme back to normal
  When I am logged in as a user with the "sitebuilder" role
    And I visit "/admin/appearance"
    And I click on the element with css selector "#system-themes-page > div.system-themes-list.system-themes-list-installed.clearfix > div:nth-child(5) > div > ul > li:nth-child(3) > a"
  Then I should see the text "Please note that the administration theme is still set to the Adminimal theme; consequently, the theme on this page remains unchanged. All non-administrative sections of the site, however, will show the selected SECGOV theme by default."
