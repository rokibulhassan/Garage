@javascript
Feature: Edit picture info
  In order to attract attention to my gallery pictures
  As a user
  I want to update picture description and date

  Background: A gallery picture exists
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "vw golf" exists with user: user "john"
    And a gallery "das auto" exists with vehicle: approved vehicle "vw golf"
    And a picture exists with title: "old and boring", gallery: gallery "das auto"

    And I login as the user "john"
    And I go to the approved vehicle "vw golf"'s my profile
    And I click on "Galleries"
    And I go to the gallery "das auto"'s pictures list

    Then I should see "old and boring" image within the content
    And I should not see "new and exciting" image within the content

  Scenario: Edit picture description
    When I click on "old and boring" image
    And I click on "Edit info"
    Then I should see "Edit picture info" within the inner modal

    When I fill in "Description" with "new and exciting" within the inner modal
    And I click on "Update picture" within the inner modal
    And I click on "×" within the modal
    And I go to the approved vehicle "vw golf"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "das auto"'s pictures list
    Then I should not see "old and boring" image within the content
    And I should see "new and exciting" image within the content

  Scenario: Edit picture description in-place
    When I click on "old and boring" image
    And I update picture description in-place with "new and edited in-place"

    Then I should not see "old and boring" image within the modal
    And I should see "new and edited in-place" image within the modal
