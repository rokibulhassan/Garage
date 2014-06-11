@javascript
Feature: Set privacy settings on vehicle galleries
  In order to limit access to my vehicle galleries
  As a user
  I want to set privacy settings on vehicle galleries

  Scenario: Set "Private" status on vehicle gallery
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "john's celica" exist with user: user "john"
    And a gallery "john's private" exists with title: "Do not tresspass", vehicle: vehicle "john's celica"
    And a picture exists with title: "you tresspassed...", gallery: gallery "john's private"

    And I login as the user "richard"

    When I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    Then I should see "Do not tresspass" within the content

    When I logout
    And I login as the user "john"
    And I go to the vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "john's private"'s pictures list
    And I check "Private" within the content
    And I click on "Galleries" within the breadcrumb
    Then I should see "Do not tresspass" within the content

    When I logout
    And I login as the user "richard"
    And I go to the vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    Then I should not see "Do not tresspass" within the content

    When I logout
    And I login as the user "john"
    And I go to the vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "john's private"'s pictures list
    Then the "Private" checkbox should be checked within the content
