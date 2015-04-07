@omniauth_test
Feature: Sign out
  To end my usage session
  A signed in user
  Should be able to sign out

  Scenario: User signs out
    Given I am logged in
    When I logout
    Then I should see 'Logout Successful.'
    When I visit '/'
    Then I should be redirected to '/login'
