@omniauth_test
Feature: Sign out
  To end my usage session
  A signed in user
  Should be able to sign out

  Scenario: User signs out
    Given I am logged in
    When I logout
    Then I should see a logout success message
    When I visit the home page
    Then I should see 'login'
