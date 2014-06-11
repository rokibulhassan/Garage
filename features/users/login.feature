@javascript
Feature: User login
  In order to be recognized as a specific visitor of the site
  I want to be able to login as a registered user

  Scenario: User is greeted upon login
    Given a user "john" exists with username: "johndoe"
    When I login as the user "john"
    Then I should see "johndoe" within the navbar
