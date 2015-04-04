@omniauth_test
Feature: Sign in
  In order to access the site
  As a user
  I should be able to sign in

  Scenario: User does not already exist
    Given I do not exist as a user
    When I sign in via google auth
    Then a new user should be created
    And I should be signed in
