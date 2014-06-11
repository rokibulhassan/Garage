@javascript
Feature: Delete a collage from its gallery
  In order to cleanup my vehicle gallery from boring or bad collages
  A a user
  I want to delete a collage from its gallery

  Scenario:
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

    When I click on "Edit collages" within the content
    Then I should see the following cutout images:
       | picture_title    | scope             |
       | front view pic   | the collages list |
       | rear view pic    | the collages list |
       | in my garage pic | the collages list |

    When I click on "Delete" within the collages list
    And I click on "OK" within the bootbox modal
    Then I should not see the following cutout images:
       | picture_title    | scope             |
       | front view pic   | the collages list |
       | rear view pic    | the collages list |
       | in my garage pic | the collages list |
