@javascript
Feature: Show amount of picture comments
  In order to get an quick overview of hot discussed vehicle pictures
  As a user
  I want to see amount of picture comments within a gallery pictures list

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "renault megane" exists with user: user "john"
    And a gallery "yellow" exists with vehicle: approved vehicle "renault megane"
    And a picture exists with title: "megane facelifted", gallery: gallery "yellow"
    And I login as the user "john"

    When I go to the approved vehicle "renault megane"'s my profile
    And I click on "Galleries"
    And I go to the gallery "yellow"'s pictures list
    Then I should see "megane facelifted" image
    And I should not see comments counter within the vehicle gallery

    When I click on "megane facelifted" image
    And I fill in "comment" with "just like woman"
    And I submit a new picture comment
    And I click on "×" within the modal
    Then I should see "megane facelifted" image
    And I should see comments size of "1" within the vehicle gallery