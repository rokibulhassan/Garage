@javascript
Feature: Assign vehicle side views
  In order to recognize vehicles by side views
  As a user
  I want to assign vehicle side view

Background: I am on the silhouettes tab of the user vehicle page
  Given a user "john" exists with username: "johndoe"
  And the following models exist:
   | model |
   | bmw   |
   | audi  |
  And the following approved versions exist:
    | approved version | body  | model        |
    | bmw              | sedan | model "bmw"  |
    | bmw2             | sedan | model "bmw"  |
    | audi             | coupe | model "audi" |
  And the following uploaded side views exist:
    | uploaded side view | file_name | version                 |
    | bmw view           | test1.jpg | approved version "bmw"  |
    | bmw2 view          | test2.jpg | approved version "bmw"  |
    | bmw3 view          | test1.jpg | approved version "bmw2" |
    | audi view          | test3.jpg | approved version "audi" |
  And the following vehicles exist:
    | vehicle | user        | side_view             | version                 |
    | bmw x7  | user "john" | side view "bmw view"  | approved version "bmw"  |
    | audi tt | user "john" | side view "audi view" | approved version "audi" |

Scenario:
  Given I login as the user "john"
  When I go to the vehicle "bmw x7"'s profile by a direct link
  Then I should not see side view "bmw2 view"'s image
  And I should see side view "bmw view"'s image

  When I click on "Change" within the vehicle side view
  Then I should see side view "bmw view"'s image
  And I should see side view "bmw2 view"'s image
  And I should see side view "bmw3 view"'s image
  And I should not see side view "audi view"'s image

  When I click on side view "bmw2 view"'s image
  Then I should see side view "bmw2 view"'s image
  And I should not see side view "bmw view"'s image

Scenario: access restriction
  Given a user "bred" exists with username: "bred"
  And I login as the user "bred"
  When I go to the vehicle "bmw x7"'s profile by a direct link
  Then I should not see "Change" within the vehicle side view