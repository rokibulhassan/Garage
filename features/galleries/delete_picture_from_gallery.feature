@javascript
Feature: Delete a picture from its gallery
  In order to cleanup my vehicle gallery from boring pictures
  As a user
  I want to delete a picture from its gallery

  Scenario: Delete a picture from its gallery
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "peugeot 3008" exists with user: user "john"
    And a gallery "crossover" exists with vehicle: approved vehicle "peugeot 3008"
    And a picture exists with title: "car of the year 2010", gallery: gallery "crossover"

    And I login as the user "john"
    And I go to the approved vehicle "peugeot 3008"'s my profile
    And I click on "Galleries"
    And I go to the gallery "crossover"'s pictures list

    Then I should see "car of the year 2010" image within the content

    When I click on "car of the year 2010" image
    And I click on "Delete" within the modal
    And I click on "OK" within the bootbox modal
    And I go to the approved vehicle "peugeot 3008"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "crossover"'s pictures list
    Then I should not see "car of the year 2010" image within the content
