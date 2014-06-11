@javascript
Feature: Delete vehicle modifications
  In order to clean modifiations tab
  As a user
  I want to remove modifications

  Background:
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    And the following approved vehicles exist:
      | approved vehicle | user        |
      | audi tt          | user "john" |
    And the following modifications exists:
      | modification | name        | vehicle                    |
      | spoiler mod  | spoiler mod | approved vehicle "audi tt" |

  Scenario: deleting the mod
    Given I login as the user "john"

    When I go to the approved vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "spoiler mod"
    And I click on "Delete" within the modifications
    And I go to the approved vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    Then I should not see "spoiler mod" within the modifications

  Scenario: unable to delete mod which attached to change set
    Given the change set exists with name: "Cool CS", vehicle: approved vehicle "audi tt", modifications:
      | modification               |
      | modification "spoiler mod" |

    And I login as the user "john"

    When I go to the approved vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "spoiler mod"

    Then I should not see "Delete" within the modifications