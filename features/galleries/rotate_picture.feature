@javascript
Feature: Rotate picture right and left
  In order to fix orientation of wrongly oriented pictures
  As a user
  I want to rotate pictures right and left

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "renault megane" exists with user: user "john"
    And a gallery "yellow" exists with vehicle: approved vehicle "renault megane"
    And an uploaded picture exists with title: "rotate me", gallery: gallery "yellow"

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s my profile
    And I click on "Galleries"
    And I go to the gallery "yellow"'s pictures list

    When I click on "rotate me" image
    Then I should see an updated "rotate me" image after click on "Rotate right"
    And I should see an updated "rotate me" image after click on "Rotate left"
