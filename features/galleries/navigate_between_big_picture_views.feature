@javascript
Feature: Navigate between big picture views
  In order to easily change picture in big view mode
  As a user
  I want to navigate to previous/next pictures in this mode

  Background: I am on the galleries tab of the user vehicle page
    Given a user "john" exists with username: "johndoe"
    And an approved vehicle "vw golf" exists with user: user "john"
    And a gallery "das auto" exists with vehicle: approved vehicle "vw golf"
    And the following pictures exist:
      | title     | gallery            |
      | last pic  | gallery "das auto" |
      | mid pic   | gallery "das auto" |
      | first pic | gallery "das auto" |

    And I login as the user "john"
    And I go to the approved vehicle "vw golf"'s my profile
    And I click on "Galleries"
    And I go to the gallery "das auto"'s pictures list

  Scenario: Navigate to next picture
    When I click on "first pic" image
    Then I should not see "mid pic" image within the modal
    And I should see "1/3" within the modal
    When I navigate to the next picture in the modal
    Then I should see "mid pic" image within the modal
    And I should see "2/3" within the modal

  Scenario: Navigate to previous picture
    When I click on "last pic" image
    Then I should not see "mid pic" image within the modal
    And I should see "3/3" within the modal
    When I navigate to the previous picture in the modal
    Then I should see "mid pic" image within the modal
    And I should see "2/3" within the modal

  Scenario: Circular browsing from first picture to last one
    When I click on "first pic" image
    Then I should not see "last pic" image within the modal
    When I navigate to the previous picture in the modal
    Then I should see "last pic" image within the modal

  Scenario: Circular browsing from last picture to first one
    When I click on "last pic" image
    Then I should not see "first pic" image within the modal
    When I navigate to the next picture in the modal
    Then I should see "first pic" image within the modal
