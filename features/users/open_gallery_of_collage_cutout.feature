@javascript
Feature: Open galleries of collage cutout
  In order to view galleries of pictures visible within collages
  As a user
  I want to open galleries of pictures which were picked to create a collage

  Background: I'm on the "Mosaic" tab of the user profile show page
    Given a user "john" exists with username: "johndoe"
    And a vehicle "bmw x7" exists with user: user "john"
    And the following galleries exist:
      | gallery | title          | vehicle          |
      | 2011    | prev year pics | vehicle "bmw x7" |
      | 2012    | this year pics | vehicle "bmw x7" |
    And the following pictures exist:
      | picture | title          | gallery        |
      | front   | front view pic | gallery "2011" |
      | rear    | rear view pic  | gallery "2011" |
      | crashed | crashed pic    | gallery "2012" |
    And a profile collage "3-in-1" exists with profile: user "john"
    And the following cutouts exist:
      | collage                  | picture           | row | col |
      | profile collage "3-in-1" | picture "front"   | 1   | 2   |
      | profile collage "3-in-1" | picture "rear"    | 2   | 2   |
      | profile collage "3-in-1" | picture "crashed" | 1   | 1   |

    And I login as the user "john"
    And I go to the user "john"'s profile by a direct link

  Scenario Outline:
    When I click on "<picture_title> cutout" image
    Then I should see "<picture_title>" image within the vehicle gallery
    And I should see "Galleries ><gallery_title>" within the breadcrumb
    And I go to the user "john"'s profile by a direct link

  Examples:
      | picture_title    | gallery_title  |
      | front view pic   | prev year pics |
      | rear view pic    | prev year pics |
      | crashed pic      | this year pics |
