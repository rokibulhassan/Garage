@javascript
Feature: Add gallery to vehicle
  In order to share my vehicle photos with others
  As a user
  I want to add galleries to my vehicle's profile

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "renault megane" exists with user: user "john"

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s my profile
    And I click on "Galleries"

    Then I should not see "New photos" within the vehicle's gallery tab
    And I should see 0 picture thumbnails within the vehicle's gallery tab
    And I should see "Add gallery" within the vehicle's gallery tab

    When I upload a file using "pictures" input within the vehicle's gallery tab
    When I fill in "title" with "New photos"
    And I submit a new gallery title
    Then I should see "New photos" within the vehicle gallery
    And I should see 1 picture thumbnail within the vehicle gallery
    And I should see 1 real picture within the vehicle gallery
    And I should see "Add pictures" within the vehicle gallery

    When I click on "Galleries" within the breadcrumb
    Then I should see "New photos" within the vehicle's gallery tab
    And I should see 1 picture thumbnail within the vehicle's gallery tab
    And I should see 1 real picture within the vehicle's gallery tab
