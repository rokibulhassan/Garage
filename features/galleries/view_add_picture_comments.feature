@javascript
Feature: View and add picture comments
  In order to know other users' opinions on vehicle pictures
  As a user
  I want to view and add picture comments

  Background:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And a approved vehicle "renault megane" exists with user: user "richard"
    And a gallery "yellow" exists with vehicle: vehicle "renault megane"
    And the following pictures exist:
      | picture | title       | gallery                   |
      | hot     | hot discuss | gallery: "yellow" |
      | boring  | boring one  | gallery: "yellow" |
    And the following comments exist:
      | body        | user            | picture           |
      | hot look    | user: "richard" | picture: "hot"    |
      | warm feel   | user: "john"    | picture: "hot"    |
      | dullish...  | user: "john"    | picture: "boring" |

    And I login as the user "john"
    And I go to the approved vehicle "renault megane"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "yellow"'s pictures list

  Scenario: View picture comments list
    When I click on "hot discuss" image
    Then I should see "hot look" within the picture comments list
    And I should see "warm feel" within the picture comments list
    And I should not see "dullish..." within the picture comments list

  Scenario: Add new picture comment
    When I click on "hot discuss" image
    Then I should not see "really exciting!" within the picture comments list

    When I fill in "comment" with "really exciting!"
    And I submit a new picture comment
    Then I should see "really exciting!" within the picture comments list
