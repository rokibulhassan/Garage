@javascript
Feature: Delete a collage from its user profile
  In order to cleanup my profile from boring or bad collages
  As a user
  I want to delete a collage from its user profile

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And a vehicle "bmw x7" exists with user: user "john"
    And a gallery "2012" exist with vehicle: vehicle "bmw x7"
    And the following pictures exist:
      | picture | title            | gallery        |
      | front   | front view pic   | gallery "2012" |
      | rear    | rear view pic    | gallery "2012" |
      | garage  | in my garage pic | gallery "2012" |
    And a profile collage "3-in-1" exists with profile: user "john"
    And the following cutouts exist:
      | collage                  | picture          | row | col |
      | profile collage "3-in-1" | picture "front"  | 1   | 2   |
      | profile collage "3-in-1" | picture "rear"   | 2   | 2   |
      | profile collage "3-in-1" | picture "garage" | 1   | 1   |

    And I login as the user "john"
    And I go to view my profile by a direct link

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
