Feature: Create Glossary Term
As an Site builder, I want to be able to create glossary term

@api @investor
Scenario Outline: Glossary Term Access for Investor Roles
  Given I am logged in as a user with the "<role>" role
  When I am on "/node/add/glossary_term"
  Then I should see the text "<result>"

  Examples:
    | role                                            | result                                      |
    | Authenticated user                              | You are not authorized to access this page. |
    | Content Creator                                 | Create Glossary Term                        |
    | Content Approver                                | Create Glossary Term                        |
    | Site Builder                                    | Create Glossary Term                        |
    | Administrator                                   | Create Glossary Term                        |
    | Content Creator, Content Approver, Site Builder | Create Glossary Term                        |

@api @javascript @investor
Scenario: Glossary Term Workflow On Investor
#OSSS-11933 - Created this bug to fix role issue on this ticket. Will review with PO and will be fixed in next release. Currently cc/sb can create draft and send for review only, ca has the ability to create draft, send for review AND publish.
  Given I am logged in as a user with the "Content Creator, Content Approver, Site Builder" role
  When I am on "/node/add/glossary_term"
    And I fill in "Title" with "Behat Test Glossary page Review"
    And I fill in "Glossary Category" with "#'s (5)"
    And I select "Draft" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Glossary Term Behat Test Glossary page Review has been created."
  When I am on "/admin/content/moderated"
    And I should see the text "Draft" in the "Behat Test Glossary page Review" row
    And I click "Edit" in the "Behat Test Glossary page Review" row
    And I type "Updated for Review" in the "Body" WYSIWYG editor
    And I fill in "Revision log message" with "Updated body"
    And I select "Needs Review" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Glossary Term Behat Test Glossary page Review has been updated."
  When I am on "/admin/content/moderated/review"
    And I should see the text "Needs Review" in the "Behat Test Glossary page Review" row
    And I click "Edit" in the "Behat Test Glossary page Review" row
    And I select "Published" from "edit-moderation-state-0-state"
    And I press "edit-submit"
  Then I should see the text "Glossary Term Behat Test Glossary page Review has been updated."
    And I am on "/admin/content"
    And I should see the text "Published" in the "Behat Test Glossary page Review" row

@api @javascript @investor
Scenario: Verify Texts are Showing Bold When Using Strong Tag for Glossary Term
  Given I am logged in as a user with the "Content Approver" role
  When I am on "/node/add/glossary_term"
    And I fill in "Title" with "Behat Test Title"
    And I fill in "Title" with "Testing ticket 13871"
    And I press the "Edit summary" button
    And I fill in "Summary" with "Investor Behat Test Article"
    And I press "Bold" in the "Body" WYSIWYG Toolbar
    And I type "Testing body" in the "Body" WYSIWYG editor
    And I scroll to the bottom
    And I select "Published" from "edit-moderation-state-0-state"
    And I press the "Save" button
  Then I should see the text "Testing ticket 13871"
    And I should see "Testing body" in the "#block-investor-content > article > div.node__content.main > div > p > strong" element
