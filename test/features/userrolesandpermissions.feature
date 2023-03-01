Feature: User Roles and Permissions
  As an Anonymous user I should only be able to view content
  As a Content creator I want to be able to create content
  As a Content Approver I should be able to create and publish Content
  As an Admin I should have all user permissions and access

  Background:
    Given "division_office" terms:
      | name              |
      | behat             |
      | office of justice |

@api
Scenario: As an Admin I should be able to view IDD admin page
  Given I am logged in as a user with the "administrator" role
  When I visit "/admin/content/idd"
  Then the response status code should be 200

@api
Scenario: Individual Defendant role should have access to view IDD admin page
  Given I am logged in as a user with the "bad_actors" role
    And "ba" content:
      | title         | field_first_name | field_last_name | field_age_in_document | field_state_idd  | field_basis_for_state | field_action_name_in_document                         | field_date_filed | field_court      | field_civ_action_no_ap_file_no | body        |
      | Donna Clooney | Donna            | Clooney         | 33                    | Alabama          | State/Residence       | SEC v. Mary Jane LLC. et al., 2017 CV 12345 (D. Mass) | 2011/2/4         | N. D. Ala.       | Test234                        | So original |
  When I visit "/admin/content/idd"
  Then the response status code should be 200

@api
Scenario: Content Creator role should not have access to view IDD admin page
  Given I am logged in as a user with the "content_creator" role
  When I am on "/admin/content/idd"
  Then I should get a "403" HTTP response

@api
Scenario Outline: Content Creator and Content Approver role users should not be able to create IDD records
  Given I am logged in as a user with the "<role>" role
  When I am on "/node/add"
  Then I should not see the link "Individual Defendant"
  When I am on "/node/add/ba"
  Then I should get a "403" HTTP response

  Examples:
    | role                  |
    | content_creator       |
    | content_approver      |

@api
Scenario Outline: IDD record creation capability limited to users with Administrator and Bad Actor roles
  Given I am logged in as a user with the "<role>" role
    And I am on "/node/add/ba"
  Then the response status code should be 200

  Examples:
    | role          |
    | bad_actors    |
    | administrator |

@api
Scenario Outline: Access Media Creation And Media List Page Based On Role
  Given I am logged in as a user with the "<role>" role
  When I am on "/media/add/static_file"
  Then the response status code should be 200
    And I should <check_url_alias_sf> the text "URL alias"
    And I should see the text 'This media file is accessible to the public via the full path even if left "unpublished." You must delete the file to ensure it is inaccessible.'
  When I am on "/media/add/image_media"
  Then the response status code should <status_code> 200
    And I should <check_url_alias_img> the text "URL alias"
    And I should <check_help_text> the text 'This media file is accessible to the public via the full path even if left "unpublished." You must delete the file to ensure it is inaccessible.'
  When I am on "/media/add/video_media"
  Then the response status code should <status_code> 200
    And I should <check_url_alias_vdo> the text "URL alias"
  When I am on "/media/add"
  Then the response status code should be 200
    And I should <check_create_media_image> the link "Image"
    And I should see the link "Static File"
    And I should <check_create_media_video> the link "Video"
    And I should not see the link "Audio"
  When I am on "/admin/content/media"
  Then I should see the link "Add media"
    And I should see the text "Published status"
    And I should see the text "Media name"
    And I should see the text "Type"
    And I should see the text "Language"
    And I should see the text "File Path"
    And I should see the button "Filter"

  Examples:
    | role                  | check_url_alias_sf | check_create_media_image | check_create_media_video | status_code | check_help_text | check_url_alias_img | check_url_alias_vdo |
    | administrator         | see                | see                      | see                      | be          | see             | see                 | see                 |
    | sitebuilder           | see                | see                      | see                      | be          | see             | see                 | see                 |
    | content_approver      | not see            | see                      | see                      | be          | see             | not see             | not see             |
    | content_creator       | not see            | see                      | see                      | be          | see             | not see             | not see             |
    | bad_actors            | see                | not see                  | not see                  | not be      | not see         | not see             | not see             |
    | division_office_admin | see                | see                      | see                      | be          | see             | see                 | see                 |

@api
Scenario Outline: Ability To Edit URL Alias And Publish For Image And Video Media
  Given I am logged in as a user with the "<Role>" role
  When I am on "/media/add/image_media"
  Then I should <Ability1> the text "URL alias"
    And I should <Ability2> an "#edit-status-value" element
  When I am on "/media/add/video_media"
  Then I should <Ability1> the text "URL alias"
    And I should <Ability2> an "#edit-status-value" element

    Examples:
    | Role                  | Ability1 | Ability2 |
    | administrator         | see      | see      |
    | sitebuilder           | see      | see      |
    | content_approver      | not see  | see      |
    | content_creator       | not see  | not see  |
    | division_office_admin | see      | see      |

@api
Scenario Outline: Access To Create Static File, Image And Video Content Types
  Given I am logged in as a user with the "<Role>" role
  When I am on "/node/add/image"
  Then the response status code should be <status_code>
  When I am on "/node/add/file"
  Then the response status code should be <status_code>
  When I am on "/node/add/video"
  Then the response status code should be <status_code>

  Examples:
  | Role                  | status_code |
  | administrator         | 200         |
  | sitebuilder           | 200         |
  | content_approver      | 403         |
  | content_creator       | 403         |
  | bad_actors            | 403         |
  | division_office_admin | 403         |

@api
Scenario Outline: Access To Create Person Content
  Given I am logged in as a user with the "<Role>" role
  When I am on "/node/add/secperson"
  Then the response status code should be <status_code>

  Examples:
  | Role                  | status_code |
  | administrator         | 200         |
  | sitebuilder           | 200         |
  | content_approver      | 403         |
  | content_creator       | 403         |
  | bad_actors            | 403         |
  | division_office_admin | 200         |

@api
Scenario Outline: Access To Delete Static File, Image And Video Content Types
  Given "file" content:
    | title                         | field_display_title           | field_primary_division_office | status |
    | BEHAT Simple Static File Test | behat simple static file test | Credit Ratings                | 1      |
    And "image" content:
      | title             | field_primary_division_office | status |
      | BEHAT Image File  | behat                         | 1      |
    And "video" content:
      | title                   | field_display_title     | field_video                                | body         | field_transcript     | status |
      | BEHAT Simple Video Test | behat simple video test | http://www.youtube.com/watch?v=xf9BpXOtMcc | man from SEC | man walking in video | 1      |
  When I am logged in as a user with the "<Role>" role
  When I am on "/image/behat-image-file/delete"
  Then the response status code should be <status_code>
  When I am on "/file/behat-simple-static-file-test/delete"
  Then the response status code should be <status_code>
  When I am on "/news/sec-videos/behat-simple-video-test/delete"
  Then the response status code should be <status_code>

    Examples:
    | Role                  | status_code |
    | administrator         | 200         |
    | sitebuilder           | 200         |
    | content_approver      | 403         |
    | content_creator       | 403         |
    | bad_actors            | 403         |
    | division_office_admin | 403         |

@api
Scenario Outline: Verify Roles Access To Users Report Page
  Given I am logged in as a user with the "<role>" role
  When I am on "/admin/reports/users"
  Then the response status code should be <status_code>
    And I should see the heading "<result>"

  Examples:
    | role                  | result               | status_code |
    | administrator         | Users                | 200         |
    | sitebuilder           | Users                | 200         |
    | content_approver      | Error 403: Forbidden | 403         |
    | content_creator       | Error 403: Forbidden | 403         |
    | bad_actors            | Error 403: Forbidden | 403         |
    | division_office_admin | Error 403: Forbidden | 403         |

@api
Scenario: Users Report Dashboard
  Given users:
    | name              | mail            | roles                             | status |
    | behat ca          | catest@test.com | content_approver, content_creator | 1      |
    | behat user1       | user1@test.com  | content_approver, bad_actors      | 1      |
    | behat user2       | user2@test.com  | content_creator                   | 1      |
    | behat user3       | user3@test.com  | sitebuilder                       | 0      |
    | baduser4@test.com | user4@test.com  | bad_actors                        | 0      |
    And I am logged in as "behat ca"
    And I am logged in as a user with the "sitebuilder" role
  When I am on "/admin/reports/users"
    # Check that sitebuilder should not see what admin can additional see (status and last access)
  Then I should not see the link "Last access"
    And I should not see the link "Status" in the "user_report" region
    And I should see the link "behat ca"
    And I should see the link "behat user1"
    And I should see the link "behat user2"
    # Check that site builder should not see a link for blocked users
    But I should not see the link "behat user3"
    And I should not see the link "baduser4@test.com"
    But I should see the text "behat user3"
    And I should see the text "baduser4@test.com"
    # Check search for users
  When I fill in "Username contains" with "user"
    And I press "Filter"
  Then I should see the link "behat user1"
    And I should see the link "behat user2"
    And I should see the text "behat user3"
    And I should see the text "baduser4@test.com"
    But I should not see the text "behat ca"
  When I press "Reset"
    # Check filter for specific role
    And I select "Individual Defendants" from "Role"
    And I press "Filter"
  Then I should see the text "baduser4@test.com"
    And I should see the link "behat user1"
    But I should not see the link "behat ca"
    And I should not see the link "behat user2"
    And I should not see the text "behat user3"
  When I press "Reset"
    # Check filter for specific status
    And I select "Blocked" from "Status"
    And I press "Filter"
  Then I should see the text "behat user3"
    And I should see the text "baduser4@test.com"
    But I should not see the link "behat user1"
    And I should not see the link "behat user2"
  When I am logged in as "behat user2"
    And I am logged in as a user with the "administrator" role
    And I am on "/admin/reports/users"
    # Check that admin can see status and last access information
  Then I should see the link "Last access" in the "user_report" region
    And I should see the link "Status" in the "user_report" region
  When I fill in "Username contains" with "behat"
    And I press "Filter"
    # Check that admin should see a link for blocked users
  Then I should see the link "behat ca"
    And I should see the link "behat user1"
    And I should see the link "behat user2"
    And I should see the link "behat user3"
    But I should not see the link "baduser4@test.com"
  When I press "Reset"
    # Check for last accessed information
  Then I should see the text "never" in the "behat user1" row
    And I should see the text "never" in the "behat user3" row
    And I should see the text "never" in the "baduser4@test.com" row
    But I should not see the text "never" in the "behat ca" row
    And I should not see the text "never" in the "behat user2" row
    # Check for status information
    And I should see the text "Blocked" in the "behat user3" row
    And I should see the text "Blocked" in the "baduser4@test.com" row
    And I should see the text "Active" in the "behat ca" row
    And I should see the text "Active" in the "behat user1" row
    And I should see the text "Active" in the "behat user2" row
    # Check for role(s) information
    And I should see the text "Content Creator" in the "behat ca" row
    And I should see the text "Content Approver" in the "behat ca" row
    And I should see the text "Sitebuilder" in the "behat user3" row
    # Check for order of last accessed information
  When I click "Last access"
  Then "behat user2" should precede "behat ca" for the query "//td[contains(@class, 'views-field views-field-name')]"
