Feature: Global Navigation
  As a Site Visitor and Drupal User, the user should be able to navigate easily throughout SEC.gov

  @user_role_display @wdio
  Scenario: User Role Display
    Given I set my screensize to desktop
      And I visit "/user/login"
    # Need manual login within 5 seconds using user: "behat_all_roles" password: "behat" since we do not yet have the auto login
      And I wait for "5" seconds
    When I visit "/user/9995"
      And I hide "#block-secgov-content > article > div"
    Then I take screenshot of element "#user-login-content"

  @footer @wdio
  Scenario: Footer Display
    Given I set my screensize to desktop
    When I visit "/page/behat-landing-page3"
      And I wait for "1" seconds
    Then I take screenshot of element "#page > footer > div.page-footer-top"
      And I take screenshot of element "#page > footer > div.page-footer-cols"

  @parent_leftnav @wdio
  Scenario: Parent Left Nav Display
    Given I set my screensize to desktop
    When I visit "/edgar/filer-information/"
      And I wait for "1" seconds
    Then I take screenshot of element "#main > div > div > div.desktop\:grid-col-3.tablet\:grid-col-4.mobile\:grid-col-12 > ul"

  @sub_leftnav @wdio
  Scenario: Sub Left Nav Display
    Given I set my screensize to desktop
    When I visit "/edgar/filer-information/current-edgar-technical-specifications"
      And I wait for "1" seconds
    Then I take screenshot of element "#main > div > div > div.desktop\:grid-col-3.tablet\:grid-col-4.mobile\:grid-col-12 > ul"