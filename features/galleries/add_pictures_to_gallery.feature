@javascript
Feature: Add pictures to gallery
  In order to share my vehicle photos with others
  As a user
  I want to add pictures to gallery for my vehicle

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "renault megane" exists with user: user "john"
    And a gallery "yellow megane" exists with vehicle: approved vehicle "renault megane"

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s my profile
    And I click on "Galleries"
    And I go to the gallery "yellow megane"'s pictures list

    Then I should see 0 picture thumbnails within the vehicle gallery
    And I should see 0 real pictures within the vehicle gallery
    And I should see "Add pictures" within the vehicle gallery

    When I upload a file using "picture[image]" input within the vehicle gallery
    Then I should see 1 picture thumbnail within the vehicle gallery
    And I should see 1 real picture within the vehicle gallery
    And I should see "Add pictures" within the vehicle gallery
