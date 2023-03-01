Feature: Investor Sitemap
  As a Content Approver, I want to be able to generate sitemap.xml for the newly created content

@api @javascript @investor
Scenario: Create Content On Investor Sitemap
  Given I am logged in as a user with the "administrator" role
  When I am on "/admin/config/search/simplesitemap"
    And I click on the element with css selector "#edit-regenerate-submit"
    And I wait 7 seconds
    And I visit "/sitemap.xml"
  Then I should not see the link "http://investor.lndo.site/node/999888"
    And I should not see the link "http://investor.lndo.site/investor-behat-article"
    And I should not see the link "http://investor.lndo.site/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-behat-news"
    And I should not see the link "http://investor.lndo.site/investor-behat-publication"
    And I should not see the link "http://investor.lndo.site/introduction-investing/basic/glossary/investor-glossary"
    And I should not see the link "http://investor.lndo.site/investor-gallery"
    And "page" content:
      | title                   | body                                    | status | nid    | moderation_state |
      | Edit Test Page Investor | Behat Display Title http://www.SEC.gov/ | 1      | 999888 | published        |
    And "article" content:
      | title                  | body                                               | nid    | status | moderation_state |
      | Investor Behat Article | Investor Behat Display Title http://www.finra.org/ | 999887 | 1      | published        |
    And "news" content:
      | title               | body                                            | nid    | status | moderation_state |
      | Investor Behat News | Investor Behat news Title http://www.finra.org/ | 999886 |        | published        |
    And "publication" content:
      | title                      | body                             | nid    | status | moderation_state |
      | Investor Behat publication | Investor Behat publication Title | 999885 | 1      | published        |
    And "glossary_term" content:
      | title             | body                          | nid    | status | moderation_state |
      | Investor Glossary | Investor Behat Glossary Title | 999884 | 1      | published        |
    And "gallery" content:
      | title            | body                         | nid    | status | moderation_state |
      | Investor gallery | Investor Behat gallery Title | 999883 | 1      | published        |
  When I am on "/admin/config/search/simplesitemap"
    And I click on the element with css selector "#edit-regenerate-submit"
    And I wait 5 seconds
  # Testing Sitemap for Basic Page Content
    And I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/node/999888"
  When I click "http://investor.lndo.site/node/999888"
  Then I should see the text "Behat Display Title http://www.SEC.gov/"
  # Testing Sitemap for Article Content
  When I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/investor-behat-article"
  When I click "http://investor.lndo.site/investor-behat-article"
  Then I should see the text "Investor Behat Display Title http://www.finra.org/"
  # Testing Sitemap for News Content
  When I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-behat-news"
  When I click "http://investor.lndo.site/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-behat-news"
  Then I should see the text "Investor Behat news Title http://www.finra.org/"
  # Testing Sitemap for Publication Content
  When I visit "/sitemap.xml"
    And I wait 3 seconds
  Then I should see the link "http://investor.lndo.site/investor-behat-publication"
  When I click "http://investor.lndo.site/investor-behat-publication"
  Then I should see the text "Investor Behat publication Title"
  # Testing Sitemap for Glossary Terms Content
  When I visit "/sitemap.xml"
    And I wait 3 seconds
  Then I should see the link "http://investor.lndo.site/introduction-investing/investing-basics/glossary/investor-glossary"
  When I click "http://investor.lndo.site/introduction-investing/investing-basics/glossary/investor-glossary"
  Then I should see the text "Investor Behat Glossary Title"
  # Testing Sitemap for Gallery Content
  When I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/investor-gallery"
  When I click "http://investor.lndo.site/investor-gallery"
  Then I should see the text "Investor Behat gallery Title"

@api @javascript @investor
Scenario: Edit Article And Check Sitemap On Investor
  Given I am logged in as a user with the "administrator" role
    And "article" content:
      | title                  | body                          | nid    | status | moderation_state |
      | Investor Behat Article | Investor http://www.finra.org | 999887 | 1      | published        |
    And I run cron
  When I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/investor-behat-article"
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Article" row
    And I fill in "Title" with "Investor Edit Behat Article"
    And I type "Editing " in the "Body" WYSIWYG editor
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I am on "/admin/config/search/simplesitemap"
    And I click on the element with css selector "#edit-regenerate-submit"
    And I wait 5 seconds
    And I visit "/sitemap.xml"
  Then I should see the link "http://investor.lndo.site/investor-edit-behat-article"
    And I should not see the link "http://investor.lndo.site/investor-behat-article"
  When I click "http://investor.lndo.site/investor-edit-behat-article"
    And I wait 1 seconds
  Then I should see the text "Editing Investor http://www.finra.org"

@api @javascript @investor
Scenario: Delete Content And Check Sitemap On Investor
  Given I am logged in as a user with the "administrator" role
    And "page" content:
      | title                     | body                                    | status | nid    | moderation_state |
      | Delete Test Page Investor | Behat Display Title http://www.SEC.gov/ | 1      | 999885 | published        |
    And I run cron
  When I visit "/sitemap.xml"
    And I wait 3 seconds
  Then I should see the link "http://investor.lndo.site/node/999885"
  When I am on "/admin/content"
    And I click "Edit" in the "Delete Test Page Investor" row
    And I click "edit-delete"
    And I wait 1 seconds
    And I press "edit-submit"
  Then I should see the text "The Basic page Delete Test Page Investor has been deleted."
  When I am on "/admin/config/search/simplesitemap"
    And I click on the element with css selector "#edit-regenerate-submit"
    And I wait 5 seconds
    And I visit "/sitemap.xml"
    And I wait 3 seconds
  Then I should not see the link "http://investor.lndo.site/node/999885"

@api @javascript @investor
Scenario: Unpublish Content And Check Sitemap On Investor
  Given I am logged in as a user with the "administrator" role
  When I am on "/node/add/article"
    And I fill in "Title" with "Investor Behat Test"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article Summary"
    And I type "Investor Behat Display Title" in the "Body" WYSIWYG editor
    And I wait 1 seconds
    And I press the "Save" button
  Then I should see the text "Article Investor Behat Test has been created"
  When I run cron
    And I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should not see the link "http://investor.lndo.site/investor-behat-test"
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Test" row
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
    And I run drush "simple-sitemap:generate"
    And I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should see the link "http://investor.lndo.site/investor-behat-test"
  When I am on "/admin/content"
    And I click "Edit" in the "Investor Behat Test Article" row
    And I select "unpublished" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Article Investor Behat Test has been updated."
  When I run drush "simple-sitemap:generate"
    And I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should not see the link "http://investor.lndo.site/investor-behat-test"

# While testing, noticed that naming of the path for generated sitemaps for taxonomy are not consistent
@api @javascript @investor
Scenario: Generate Taxonomy Terms Sitemap
  Given I am logged in as a user with the "administrator" role
  When I am on "/node/add/glossary_term"
    And I fill in "Title" with "Behat Test Glossary Page Review"
    And I type "Investor Glossary Title" in the "Body" WYSIWYG editor
    And I select the first autocomplete option for "#'s" on the "Glossary Category" field
    And I select "published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Glossary Term Behat Test Glossary Page Review has been created."
  #Indexing Taxonomy as it is not default for Investor
  When I am on "/admin/structure/taxonomy/manage/glossary_term_categories"
    And I click on the element with css selector "#edit-simple-sitemap"
    And I click on the element with css selector "#edit-simple-sitemap-default"
    And I click on the element with css selector "#edit-simple-sitemap-default-index-1"
    And I press the "edit-submit" button
  Then I should see the text "Updated vocabulary Glossary Term Categories."
  When I run cron
    And I visit "/sitemap.xml"
    And I wait 3 seconds
  Then I should see the link "http://investor.lndo.site/glossary-term-categories/s"
  When I click "http://investor.lndo.site/glossary-term-categories/s"
    And I wait 1 seconds
  Then I should see the link "Behat Test Glossary Page Review"
    And I click "Behat Test Glossary Page Review"
    And I should see the text "Investor Glossary Title"
  When I am on "/admin/structure/taxonomy/manage/glossary_term_categories"
    And I click on the element with css selector "#edit-simple-sitemap"
    And I click on the element with css selector "#edit-simple-sitemap-default"
    And I click on the element with css selector "#edit-simple-sitemap-default-index-0"
    And I press the "edit-submit" button
  Then I should see the text "Updated vocabulary Glossary Term Categories."
  When I am on "/admin/config/search/simplesitemap"
    And I click on the element with css selector "#edit-regenerate-submit"
    And I wait 10 seconds
    And I visit "/sitemap.xml"
    And I wait 2 seconds
  Then I should not see the link "http://investor.lndo.site/glossary-term-categories/s"
