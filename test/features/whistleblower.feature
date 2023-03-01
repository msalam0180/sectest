Feature: Whistleblower List Pages
  As a visitor to SEC.gov
  I want to be able to view and sort through the information on Whistleblower List Pages
  So that I can quickly navigate to the most important information on the SEC.gov

Background:

  Given "secarticle" content:
    | title           | field_display_title | body                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_release_number | field_article_type_secarticle | field_primary_division_office |
    | Whistleblower 1 | Whistleblower 1     | Apple http://www.apple.com homepage         | fruits                         | 2019-12-05T17:00:00 | 2019-06-18T17:01:00 | 1      | 2019-100             | Award Claim                   | Whistleblower                 |
    | Whistleblower 2 | Whistleblower 2     | Amazon http://www.amazon.com homepage       | everything                     | 2019-10-26T17:00:00 | 2019-06-18T17:01:00 | 1      | 2019-200             | Award Claim                   | Whistleblower                 |
    | Whistleblower 3 | Whistleblower 3     | Boeing http://www.boeing.com homepage       | planes                         | 2014-09-19T17:00:00 | 2019-06-18T17:01:00 | 1      | 2014-300             | Award Claim                   | Whistleblower                 |
    | Whistleblower 4 | Whistleblower 4     | Google http://www.google.com homepage       | ads                            | 2016-02-20T17:00:00 | 2019-06-18T17:01:00 | 1      | 2016-400             | Award Claim                   | Whistleblower                 |
    | Whistleblower 5 | Whistleblower 5     | IBM http://www.ibm.com homepage             | consulting                     | 2015-03-01T17:00:00 | 2019-06-18T17:01:00 | 1      | 2015-500             | Award Claim                   | Whistleblower                 |
    | Whistleblower 6 | Whistleblower 6     | Microsoft http://www.microsoft.com homepage | software                       | 2018-04-17T17:00:00 | 2019-06-18T17:01:00 | 1      | 2018-600             | Award Claim                   | Whistleblower                 |
    | Whistleblower 7 | Whistleblower 7     | Tesla http://www.tesla.com homepage         | cars                           | 2017-06-30T17:00:00 | 2019-06-18T17:01:00 | 1      | 2017-700             | Award Claim                   | Whistleblower                 |
    | Whistleblower 8 | Whistleblower 8     | Twitter http://www.twitter.com homepage     | tweets                         | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 0      | 2019-800             | Award Claim                   | Whistleblower                 |

@api @javascript
Scenario: Default Sorting On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  # Check for item counter
  Then I should see the text "1 to 7 of 7 items"
  # Default sorting (by descending Notice No. and negative test to make sure unpublished content doesn't show up)
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    But I should not see the text "Twitter http://www.twitter.com homepage"

@api @javascript
Scenario: Year Filtering On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  When I select "2014" from "edit-year"
  Then I should see the text "1 to 1 of 1 items"
    And I should see the text "2014-300" in the "Boeing http://www.boeing.com homepage" row
    And I should see the text "09/19/2014" in the "Boeing http://www.boeing.com homepage" row
    But I should not see the text "Apple http://www.apple.com homepage"
  When I select "2018" from "edit-year"
  Then I should see the text "2018-600" in the "Microsoft http://www.microsoft.com homepage" row
    And I should see the text "04/17/2018" in the "Microsoft http://www.microsoft.com homepage" row
    But I should not see the text "Amazon http://www.amazon.com homepage"
  When I select "2019" from "edit-year"
  Then I should see the text "1 to 2 of 2 items"
    And I should see the text "2019-100" in the "Apple http://www.apple.com homepage" row
    And I should see the text "2019-200" in the "Amazon http://www.amazon.com homepage" row
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    But I should not see the text "Twitter http://www.twitter.com homepage"
  When I select "-View All-" from "edit-year"
    And I wait for AJAX to Finish
  Then "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    But I should not see the text "Twitter http://www.twitter.com homepage"

@api @javascript
Scenario: Notice No. Sorting On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  # Test sorting of Notice No. in ascending order
  When I click the sort filter "Notice No."
  Then "Boeing http://www.boeing.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
  # Test sorting of Notice No. in descending order
  When I click the sort filter "Notice No."
  Then "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"

@api @javascript
Scenario: Action Sorting On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  # Test sorting of Action in ascending order
  When I click the sort filter "Action"
  Then "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Boeing http://www.boeing.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
  # Test sorting of Action in descending order
  When I click the sort filter "Action"
  Then "Boeing http://www.boeing.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"

@api @javascript
Scenario: Notice Date Sorting On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  # Test sorting of Notice Date in ascending order
  When I click the sort filter "Notice Date"
  Then "Boeing http://www.boeing.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    # Test sorting of Notice Date in descending order
  When I click the sort filter "Notice Date"
  Then "Apple http://www.apple.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Amazon http://www.amazon.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"

@api @javascript
Scenario: Claim Due Date Sorting On Whistleblower Covered Actions List Page
  Given I am on "/whistleblower/nocas"
  # Test sorting of Claim Due Date in ascending order
  When I click the sort filter "Claim Due Date"
  Then "Boeing http://www.boeing.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
# Test sorting of Claim Due Date in descending order
  When I click the sort filter "Claim Due Date"
  Then "Apple http://www.apple.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Amazon http://www.amazon.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"

@api @javascript
Scenario: Whistleblower List Page Notice No. Sorting
  Given I am on "/whistleblower/nocas"
  Then I should see the text "1 to 7 of 7 items"
    And "Amazon http://www.amazon.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Boeing http://www.boeing.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
  When I click the sort filter "Notice No."
  Then I should see the text "1 to 7 of 7 items"
    And "Boeing http://www.boeing.com homepage" should precede "IBM http://www.ibm.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "IBM http://www.ibm.com homepage" should precede "Google http://www.google.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Google http://www.google.com homepage" should precede "Tesla http://www.tesla.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Tesla http://www.tesla.com homepage" should precede "Microsoft http://www.microsoft.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Microsoft http://www.microsoft.com homepage" should precede "Apple http://www.apple.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"
    And "Apple http://www.apple.com homepage" should precede "Amazon http://www.amazon.com homepage" for the query "//td[contains(@class, 'views-field views-field-body')]"

@api @javascript
Scenario: View the Whistleblower Final Orders List Page
  Given "secarticle" content:
      | title                     | field_display_title              | body                                        | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_release_number | field_article_type_secarticle | field_primary_division_office | field_tags   | field_file_upload |
      | Whistleblower Fin Order 1 | Dinner Orders (pdf)              | Apple http://www.apple.com homepage         | fruits                         | 2019-12-05T17:00:00 | 2019-06-18T17:01:00 | 1      | 2019-100             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 2 | Lunch Orders (pdf)               | Amazon http://www.amazon.com homepage       | everything                     | 2019-10-26T17:00:00 | 2019-06-18T17:01:00 | 1      | 2019-200             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 3 | Breakfast Orders (docx)          | Boeing http://www.boeing.com homepage       | planes                         | 2015-03-19T17:00:00 | 2019-06-18T17:01:00 | 1      | 2014-300             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 4 | Brunch Orders (xls)              | Google http://www.google.com homepage       | ads                            | 2016-02-20T17:00:00 | 2019-06-18T17:01:00 | 1      | 2016-400             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 5 | Midnight Snack Orders (doc)      | IBM http://www.ibm.com homepage             | consulting                     | 2015-03-01T17:00:00 | 2019-06-18T17:01:00 | 1      | 2015-500             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 6 | Afternoon Tea Time Orders (xlsx) | Microsoft http://www.microsoft.com homepage | software                       | 2018-04-17T17:00:00 | 2019-06-18T17:01:00 | 1      | 2018-600             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 7 | Early Dinner Orders (txt)        | Tesla http://www.tesla.com homepage         | cars                           | 2017-06-30T17:00:00 | 2019-06-18T17:01:00 | 1      | 2017-700             | Award Claim                   | Whistleblower                 | final orders |                   |
      | Whistleblower Fin Order 8 | No Order                         | Twitter http://www.twitter.com homepage     | tweets                         | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 0      | 2019-800             | Award Claim                   | Whistleblower                 | final orders |                   |
    And I create "media" of type "static_file":
      | name            | field_media_file           | status |
      | Behat final pdf | behat-file-final_order.pdf | 1      |
      | Behat cat pdf   | behat-file-cat.pdf         | 1      |
      | Behat im docx   | behat-file-im.docx         | 1      |
      | Behat xls       | behat-file.xls             | 1      |
      | Behat xlsx      | behat-file.xlsx            | 1      |
      | Behat im txt    | behat-file-im.txt          | 1      |
      | Behat im ppt    | behat-file-im.ppt          | 1      |
  When I am logged in as a user with the "content_approver" role
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-1/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat final pdf" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-2/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat cat pdf" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-3/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat im docx" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-4/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat xls" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-5/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat xlsx" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-6/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat im txt" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-7/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat im ppt" on the "Use existing media" field
    And I wait for ajax to finish
    And I publish it
    And I visit "/whistleblower/award-claim/whistleblower-fin-order-8/edit"
    And I wait 1 seconds
    And I select the first autocomplete option for "Behat im ppt" on the "Use existing media" field
    And I wait for ajax to finish
    And I press "Save and Create New Draft"
  When I am not logged in
    And I am on "/whistleblower/final-orders"
  Then I should see the text "1 to 7 of 7 items"
    And I should see the link "Dinner Orders (pdf)"
    And I should see the text "Dec. 5, 2019" in the "Dinner Orders (pdf)" row
    And I should see the link "Lunch Orders (pdf)"
    And I should see the text "Oct. 26, 2019" in the "Lunch Orders (pdf)" row
    And I should see the link "Afternoon Tea Time Orders (xlsx)"
    And I should see the text "April 17, 2018" in the "Afternoon Tea Time Orders (xlsx)" row
    And I should see the link "Early Dinner Orders (txt)"
    And I should see the text "June 30, 2017" in the "Early Dinner Orders (txt)" row
    And I should see the link "Brunch Orders (xls)"
    And I should see the text "Feb. 20, 2016" in the "Brunch Orders (xls)" row
    And I should see the link "Midnight Snack Orders (doc)"
    And I should see the text "March 1, 2015" in the "Midnight Snack Orders (doc)" row
    And I should see the link "Breakfast Orders (docx)"
    And I should see the text "March 19, 2015" in the "Breakfast Orders (docx)" row
    But I should not see the link "No Order"
  # Test sorting of Date in ascending order
  When I click the sort filter "Date"
  Then "Midnight Snack Orders (doc)" should precede "Breakfast Orders (docx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Breakfast Orders (docx)" should precede "Brunch Orders (xls)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Brunch Orders (xls)" should precede "Early Dinner Orders (txt)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Early Dinner Orders (txt)" should precede "Afternoon Tea Time Orders (xlsx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Afternoon Tea Time Orders (xlsx)" should precede "Lunch Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Lunch Orders (pdf)" should precede "Dinner Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
  # Test sorting of Date in descending order
  When I click the sort filter "Date"
  Then "Dinner Orders (pdf)" should precede "Lunch Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Lunch Orders (pdf)" should precede "Afternoon Tea Time Orders (xlsx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Afternoon Tea Time Orders (xlsx)" should precede "Early Dinner Orders (txt)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Early Dinner Orders (txt)" should precede "Brunch Orders (xls)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Brunch Orders (xls)" should precede "Breakfast Orders (docx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Breakfast Orders (docx)" should precede "Midnight Snack Orders (doc)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
  # Test sorting of Orders in ascending order
  When I click the sort filter "Orders"
  Then "Afternoon Tea Time Orders (xlsx)" should precede "Breakfast Orders (docx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Breakfast Orders (docx)" should precede "Brunch Orders (xls)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Brunch Orders (xls)" should precede "Dinner Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Dinner Orders (pdf)" should precede "Early Dinner Orders (txt)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Early Dinner Orders (txt)" should precede "Lunch Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Lunch Orders (pdf)" should precede "Midnight Snack Orders (doc)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
  # Test sorting of Orders in descending order
  When I click the sort filter "Orders"
  Then "Midnight Snack Orders (doc)" should precede "Lunch Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Lunch Orders (pdf)" should precede "Early Dinner Orders (txt)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Early Dinner Orders (txt)" should precede "Dinner Orders (pdf)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Dinner Orders (pdf)" should precede "Brunch Orders (xls)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Brunch Orders (xls)" should precede "Breakfast Orders (docx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
    And "Breakfast Orders (docx)" should precede "Afternoon Tea Time Orders (xlsx)" for the query "//td[contains(@class, 'views-field-field-media-file')]"
  # Test Year and Month filters
  When I select "2017" from "edit-year"
  Then I should see the text "1 to 1 of 1 items"
    And I should see the text "June 30, 2017" in the "Early Dinner Orders (txt)" row
    But I should not see the link "Brunch Orders (xls)"
  When I select "2015" from "edit-year"
  Then I should see the text "1 to 2 of 2 items"
    And I should see the text "March 19, 2015" in the "Breakfast Orders (docx)" row
    And I should see the text "March 1, 2015" in the "Midnight Snack Orders (doc)" row
    But I should not see the link "Afternoon Tea Time Orders (xlsx)"
  When I select "2019" from "edit-year"
  Then I should see the text "1 to 2 of 2 items"
    And I should see the text "Dec. 5, 2019" in the "Dinner Orders (pdf)" row
    And I should see the text "Oct. 26, 2019" in the "Lunch Orders (pdf)" row
    But I should not see the link "Afternoon Tea Time Orders (xlsx)"
  When I select "October" from "edit-month"
  Then I should see the text "1 to 1 of 1 items"
    And I should see the text "Oct. 26, 2019" in the "Lunch Orders (pdf)" row
    But I should not see the link "Dinner Orders (pdf)"

@api @javascript
Scenario: View Whistleblower PR and Public Statement List Page
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "news" content:
    | field_news_type_news  | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          | field_media_file_upload |
    | Press Release         | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |                         |
    | Press Release         | Agency-wide                   | draft            | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |                         |
    | Press Release         | Agency-wide                   | draft            | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower award |                         |
    | Press Release         | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |                         |
    | Press Release         | Agency-wide                   | published        | Fifth WB PR  | 1      |                          | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower       | Behat File              |
    | Press Release         | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2018-03-11 12:00:00 | 2018-6               | Whistleblower       |                         |
    | Press Release         | Agency-wide                   | published        | Seventh WB PR| 1      | This is the seventh body.| Seventh WB Press Release| 2018-04-11 12:00:00 | 2018-4               | whistleblower award | Behat File              |
    | Press Release         | Agency-wide                   | published        | Eighth WB PR | 1      | This is the eighth body. | Eighth WB Press Release | 2018-06-11 12:00:00 | 2018-6               | whistleblower award |                         |
    | Press Release         | Agency-wide                   | published        | Ninth WB PR  | 1      | This is the ninth body.  | Ninth WB Press Release  | 2018-07-11 12:00:00 | 2018-4               | whistleblower award |                         |
    | Statement             | Agency-wide                   | published        | tenth WB PR  | 1      |                          | First WB Pub Statement  | 2018-01-11 12:00:00 | 2018-4               | whistleblower award | Behat File              |
    | Statement             | Agency-wide                   | published        | eleven WB PR | 1      | This is the eleven body. | Second WB Pub Statment  | 2018-01-12 12:00:00 | 2018-6               | whistleblower award |                         |
  When I am on "/whistleblower/pressreleases"
  Then I should see the heading "Office of the Whistleblower"
    And I should see the text "Press Releases and Statements"
    #list view should display link to press release with display title as text
    And I should see the link "First WB Press Release"
    And I should see the link "First WB Pub Statement (PDF)"
    And I should see the link "Second WB Pub Statment"
    #list view should not display draft items
    And I should not see the link "Second WB Press Release"
    And I should not see the link "Third WB Press Release"
    And I should see the link "Fourth WB Press Release"
    And I should see the link "Fifth WB Press Release (PDF)"
    #list view should display date
    And I should see the date "2018-09-11 12:00:00" in the "First WB Press Release" row
    And I should see the date "2018-05-11 12:00:00" in the "Fourth WB Press Release" row
    And I should see the date "2018-02-11 12:00:00" in the "Fifth WB Press Release (PDF)" row
    #list view should display release number
    And I should see the text "2018-12" in the "First WB Press Release" row
    And I should see the text "2018-6" in the "Fourth WB Press Release" row
    And I should see the text "2018-4" in the "Fifth WB Press Release (PDF)" row
    #dates should be grouped by month and display under a month banner
    And I should see "First WB Press Release" under the "2018-09-11 12:00:00" month banner
    And I should see "Fourth WB Press Release" under the "2018-05-11 12:00:00" month banner
    And I should see "Fifth WB Press Release (PDF)" under the "2018-02-11 12:00:00" month banner
    #default sorting is by date: newest to oldest
    And "First WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "Fifth WB Press Release (PDF)" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    #test show items per page and pagination
  When I select "5" from "edit-items-per-page"
  Then I should see the text "1 to 5 of 9 items"
    And I should see the link "Next"
    And I should see the link "Last"
    And I click "Last"
    And I should see the text "6 to 9 of 9 items"

@api @javascript
Scenario: Whistleblower PR List Page Title Sorting
  Given "news" content:
    | field_news_type_news  | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          |
    | Press Release         | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |
    | Press Release         | Agency-wide                   | draft            | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |
    | Press Release         | Agency-wide                   | published        | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower       |
    | Press Release         | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |
    | Press Release         | Agency-wide                   | published        | Fifth WB PR  | 1      | This is the fifth body.  | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower award |
    | Press Release         | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2018-03-11 12:00:00 | 2017-4               | whistleblower award |
  When I am on "/whistleblower/pressreleases"
  # Test sort of Title in ascending order
    And I click the sort filter "Title"
  Then "Fifth WB Press Release" should precede "First WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "Sixth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Sixth WB Press Release" should precede "Third WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  # Test sort of Title in descending order
  When I click the sort filter "Title"
  Then "Third WB Press Release" should precede "Sixth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Sixth WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "First WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First WB Press Release" should precede "Fifth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Whistleblower PR List Page Release Number Sorting
  Given "news" content:
    | field_news_type_news | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          |
    | Press Release        | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |
    | Press Release        | Agency-wide                   | published        | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |
    | Press Release        | Agency-wide                   | published        | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower       |
    | Press Release        | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |
    | Press Release        | Agency-wide                   | published        | Fifth WB PR  | 1      | This is the fifth body.  | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower award |
    | Press Release        | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2018-03-11 12:00:00 | 2017-1               | whistleblower award |
  When I am on "/whistleblower/pressreleases"
    And I click the sort filter "Release No."
  Then "Third WB Press Release" should precede "First WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "Third WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fifth WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Sixth WB Press Release" should precede "Fifth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Release No."
  Then "Fifth WB Press Release" should precede "Sixth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "Fifth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Third WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "First WB Press Release" should precede "Third WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Whistleblower PR List Page Year Filter
  Given "news" content:
    | field_news_type_news | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          |
    | Press Release        | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |
    | Press Release        | Agency-wide                   | draft            | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |
    | Press Release        | Agency-wide                   | draft            | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower       |
    | Press Release        | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |
    | Press Release        | Agency-wide                   | published        | Fifth WB PR  | 1      | This is the fifth body.  | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower award |
    | Press Release        | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2017-02-11 12:00:00 | 2017-4               | whistleblower award |
  When I am on "/whistleblower/pressreleases"
    And I select "2018" from "Year"
  Then I should see the text "1 to 3 of 3 items"
    And I should see the link "First WB Press Release"
    And I should not see the link "Second WB Press Release"
    And I should not see the link "Third WB Press Release"
    And I should see the link "Fourth WB Press Release"
    And I should see the link "Fifth WB Press Release"
    And I should not see the link "Sixth WB Press Release"

@api @javascript
Scenario: Whistleblower PR List Page Month Filter
  Given "news" content:
    | field_news_type_news  | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          |
    | Press Release         | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |
    | Press Release         | Agency-wide                   | draft            | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |
    | Press Release         | Agency-wide                   | draft            | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower       |
    | Press Release         | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |
    | Press Release         | Agency-wide                   | published        | Fifth WB PR  | 1      | This is the fifth body.  | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower award |
    | Press Release         | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2017-02-11 12:00:00 | 2017-4               | whistleblower award |
  When I am on "/whistleblower/pressreleases"
    And I select "2018" from "Year"
    And I select "September" from "Month"
  Then I should see the text "1 to 1 of 1 items"
    And I should see the link "First WB Press Release"
    And I should not see the link "Second WB Press Release"
    And I should not see the link "Third WB Press Release"
    And I should not see the link "Fourth WB Press Release"
    And I should not see the link "Fifth WB Press Release"
    And I should not see the link "Sixth WB Press Release"

@api @javascript
Scenario: Whistleblower PR List Page Date Sorting
  Given "news" content:
    | field_news_type_news          | field_primary_division_office | moderation_state | title        | status | body                     | field_display_title     | field_publish_date  | field_release_number | field_tags          |
    | Press Release                 | Agency-wide                   | published        | First WB PR  | 1      | This is the first body.  | First WB Press Release  | 2018-09-11 12:00:00 | 2018-12              | Whistleblower       |
    | Press Release                 | Agency-wide                   | draft            | Second WB PR | 0      | This is the second body. | Second WB Press Release | 2018-07-11 12:00:00 | 2018-10              | Whistleblower       |
    | Press Release                 | Agency-wide                   | draft            | Third WB PR  | 1      | This is the third body.  | Third WB Press Release  | 2018-06-11 12:00:00 | 2018-8               | whistleblower       |
    | Press Release                 | Agency-wide                   | published        | Fourth WB PR | 1      | This is the fourth body. | Fourth WB Press Release | 2018-05-11 12:00:00 | 2018-6               | whistleblower       |
    | Press Release                 | Agency-wide                   | published        | Fifth WB PR  | 1      | This is the fifth body.  | Fifth WB Press Release  | 2018-02-11 12:00:00 | 2018-4               | whistleblower award |
    | Press Release                 | Agency-wide                   | published        | Sixth WB PR  | 1      | This is the sixth body.  | Sixth WB Press Release  | 2017-02-11 12:00:00 | 2017-4               | whistleblower award |
  When I am on "/whistleblower/pressreleases"
  # Test sort of Date in ascending order
    And I click the sort filter "Date"
  Then "Fifth WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "First WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  # Test sort of Date in descending order
  When I click the sort filter "Date"
  Then "First WB Press Release" should precede "Fourth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Fourth WB Press Release" should precede "Fifth WB Press Release" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api
Scenario: Validate Display Title On Whistleblower Final Orders of The Commission
  Given I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | BehatFile1 | behat-file_fanswer.pdf | 1      |
    And "news" content:
      | field_news_type_news | field_primary_division_office | moderation_state | title       | status | field_display_title    | field_publish_date  | field_release_number | field_tags   | field_media_file_upload |
      | Press Release        | Agency-wide                   | published        | First WB PR | 1      | First WB Press Release | 2018-09-11 12:00:00 | 2018-12              | final orders | BehatFile1              |
  When I am on "/news/press-release/first-wb-pr"
  Then I should see the heading "Press Release"
    And I should see the heading "First WB Press Release"
    And I should see "BehatFile1"
    And I should see "pdf"
  When I am on "/whistleblower/final-orders"
  Then I should see the link "First WB Press Release"
  When I click "First WB Press Release"
  Then I should be on "/files/behat-file_fanswer.pdf"
