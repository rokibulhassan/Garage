@javascript
Feature: Open pictures of collage cutout
  In order to view full versions of pictures visible within collages
  As a user
  I want to open original pictures which were picked to create a collage

  Background: I'm on the gallery show page viewed as collages list
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "bmw x7" exists with user: user "john"
    And a gallery "2012" exists with vehicle: approved vehicle "bmw x7"
    And the following pictures exist:
      | picture | title            | gallery        |
      | front   | front view pic   | gallery "2012" |
      | rear    | rear view pic    | gallery "2012" |
      | garage  | in my garage pic | gallery "2012" |
    And a collage "3-in-1" exists with gallery: gallery "2012"
    And the following cutouts exist:
      | collage          | picture          | row | col |
      | collage "3-in-1" | picture "front"  | 1   | 2   |
      | collage "3-in-1" | picture "rear"   | 2   | 2   |
      | collage "3-in-1" | picture "garage" | 1   | 1   |

    And I login as the user "john"
    And I go to the approved vehicle "bmw x7"'s my profile
    And I click on "Galleries"
    And I go to the gallery "2012"'s pictures list
    And I check "Collages list" within the content

  Scenario Outline:
    When I click on "<picture_title> cutout" image
    Then I should see "<picture_title>" image within the modal
    And I click on "×" within the modal

  Examples:
      | picture_title    |
      | front view pic   |
      | rear view pic    |
      | in my garage pic |


