@javascript
Feature: Blur picture areas
  In order to hide personal info (license plates etc.) on gallery pictures
  As a user
  I want to blur selected areas of a picture

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "renault megane" exists with user: user "john"
    And a gallery "yellow" exists with vehicle: approved vehicle "renault megane"
    And an uploaded picture exists with title: "blur me", gallery: gallery "yellow"

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s my profile
    And I click on "Galleries"
    And I go to the gallery "yellow"'s pictures list

    When I click on "blur me" image
    Then I should see an updated "blur me" image after click on "Blur area"
