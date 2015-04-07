Feature: Home page
  In order to manage my corp activities
  As a user
  I want a general overview of site tracked information

  Scenario: User is not logged in
    Given I am not logged in
    When I visit '/'
    Then I should be redirected to '/login'

  Scenario: User has no API Keys
    Given I have no api keys
    When I visit '/'
    Then I should be redirected to '/api_keys'

