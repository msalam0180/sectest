Feature: Investor User Permissions and Workflows
  Investor users can be assigned a role that allows them to visit, use, create content or manage the investor site.
  Anonymous user - Able to view published content without any log in
  Administrator - No restrictions on permissions
  Content Creator - Can create new content and documents, can edit existing content
  Content Approver - Can publish content
  Site Builder - Review logs, edit and rearrange menu items

@api @investor
Scenario Outline: Investor Anonymous Users Access
  Given I am on "<url>"
  Then I should see the text "ACCESS DENIED"
    And I should see the text "You are not authorized to access this page."

  Examples:
    | url                     |
    | /node/add/page          |
    | /node/add/article       |
    | /node/add/publication   |
    | /node/add/news          |
    | /node/add/glossary_term |
    | /node/add/landing       |
    | /node/add/featured      |
    | /node/add/gallery       |
    | /media/add/audio        |
    | /media/add/file         |
    | /media/add/video        |
    | /media/add/image        |

@api @investor
Scenario Outline: Investor Authenticated User Access
  Given I am logged in as a user with the "Authenticated user" role
  When I am on "<url>"
  Then I should see the text "ACCESS DENIED"
    And I should see the text "You are not authorized to access this page."

  Examples:
    | url                     |
    | /node/add/page          |
    | /node/add/news          |
    | /node/add/glossary_term |
    | /node/add/article       |
    | /node/add/publication   |
    | /node/add/landing       |
    | /node/add/featured      |
    | /node/add/gallery       |
    | /media/add/audio        |
    | /media/add/file         |
    | /media/add/video        |
    | /media/add/image        |

@api @investor
Scenario Outline: Investor Content Creator Can access all the content pages
  Given I am logged in as a user with the "Content Creator" role
  When I am on "<url>"
  Then I should see the text "<result>"

  Examples:
    | url                     | result               |
    | /node/add/page          | Create Basic page    |
    | /node/add/article       | Create Article       |
    | /node/add/publication   | Create Publication   |
    | /node/add/news          | Create News          |
    | /node/add/glossary_term | Create Glossary Term |
    | /node/add/landing       | Create Landing Page  |
    | /node/add/featured      | Create Featured      |
    | /node/add/gallery       | Create Gallery       |
    | /media/add/audio        | Add Audio            |
    | /media/add/file         | Add File             |
    | /media/add/video        | Add Video            |
    | /media/add/image        | Add media            |

@api @javascript @investor
Scenario: Investor Content Creator sending content for review
  Given I am logged in as a user with the "Content Creator" role
    And I am on "/node/add/page"
    And I fill in "Title" with "Test_CA_Review"
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  When I am on "/admin/content"
  Then I should see the text "Unpublished" in the "Test_CA_Review" row
  When I am on "/admin/content/moderated/review"
  Then I should see the text "Needs Review" in the "Test_CA_Review" row
  When I am on "/"
    And I fill in "Search Investor.gov" with "Test_CA_Review"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the text "Your Search Yielded No Results"

@api @javascript @investor
Scenario: Investor Content Approver can review and publish content
  Given I am logged in as a user with the "Content Creator" role
    And I am on "/node/add/page"
    And I fill in "Title" with "Page Test Review"
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  When I am logged in as a user with the "Content Approver" role
    And I am on "/admin/content/moderated/review"
  Then I should see the text "Needs Review" in the "Page Test Review" row
  When I click "Edit" in the "Page Test Review" row
    And I fill in "Title" with "Behat Page Test"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
    And I click "Needs Review"
  Then I should not see the link "Behat Page Test"

@api @javascript @investor
Scenario: Investor Moderation Workflow
  Given I am logged in as a user with the "Content Creator" role
    And I am on "/node/add/page"
    And I fill in "Title" with "Behat Test Review"
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  When I am logged in as a user with the "Content Approver" role
    And I am on "/admin/content/moderated/review"
    And I click "Edit" in the "Behat Test Review" row
    And I fill in "Revision log message" with "Please update title and body to something more meaningful."
    And I press "edit-submit"
  Then I should see the text "Basic page Behat Test Review has been updated."
  When I am logged in as a user with the "Content Creator" role
    And I am on "/admin/content/moderated/edit"
    And I click "Edit" in the "Behat Test Review" row
    And I click "Revision"
    And I should see the text "Please update title and body to something more meaningful."
    And I click "Edit"
    And I fill in "Title" with "Behat Page Test Review"
    And I fill in "Revision log message" with "Updated Title and body based on feedback"
    And I type "This is a test and only a test" in the "Body" WYSIWYG editor
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I am logged in as a user with the "Content Approver" role
    And I am on "/admin/content/moderated/review"
    And I click "Edit" in the "Behat Page Test Review" row
    And I click "Revision"
    And I should see the text "Updated Title and body based on feedback"
    And I click "Edit"
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  When I am on "/"
    And I fill in "Search Investor.gov" with "Behat Page Test Review"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Behat Page Test Review" in the maincontent region
    And I should see the text "This is a test and only a test"

@api @investor
Scenario Outline: Investor Sitebuilder Access
  Given I am logged in as a user with the "Site Builder" role
  When I am on "<url>"
  Then I should see the text "<result>"

  Examples:
    | url                       | result                              |
    | /admin/structure/menu     | Each menu has a corresponding block |
    | /admin/structure/taxonomy | Taxonomy                            |

@api @investor
Scenario Outline: Investor Admin Role Access
  Given I am logged in as a user with the "administrator" role
  When I am on "<url>"
  Then I should see the text "<result>"

  Examples:
    | url                       | result                                                                 |
    | /admin/structure/menu     | Each menu has a corresponding block                                    |
    | /admin/people/create      | This web page allows administrators to register new users.             |
    | /admin/reports/dblog      | The Database Logging module logs system events in the Drupal database. |
    | /admin/structure/block    | Block placement is specific to each theme on your site.                |
    | /admin/structure/taxonomy | Taxonomy is for categorizing content.                                  |
    | /admin/reports/status     | Status report                                                          |
    | /admin/config/media       | Media                                                                  |

@api @investor @javascript
Scenario: Sitebuilder Layout Builder Access
  Given "article" content:
    | title           | body      | status | moderation_state |
    | Behat Article-1 | test body | 1      | published        |
    And I run cron
  When I am on "/"
    And I am logged in as a user with the "Site Builder" role
    And I fill in "Search Investor.gov" with "Behat Article-1"
    And I click on the element with css selector "#edit-submit-search-content"
    And I wait 2 seconds
  Then I should see the link "Behat Article-1" in the maincontent region
    And I click "Behat Article-1" in the maincontent region
    And I should see the link "Layout"
