@omniauth_test
Feature: Sign in
  In order to access the site
  As a user
  I should be able to sign in

  Scenario: User does not already exist
    Given I do not exist as a user
    When I sign in via google auth
    Then a new user should be created
    And I should see a login success message

  Scenario: User already exists
    Given I already exist as a user
    And I am not logged in
    When I sign in via google auth
    Then I should see a login success message
