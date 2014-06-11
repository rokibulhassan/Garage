@javascript
Feature: Add and delete bookmarks on/from a vehicle
  In order to get a quick access to other users' vehicle profiles I found interesting
  As a user
  I want to manage bookmarks on other users' vehicles

  Background:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And the following easy approved vehicles exist:
      | easy approved vehicle | brand_name | model_name | user           |
      | renault               | Renault    | Megane     | user "richard" |

  Scenario: Delete a bookmark from a vehicle
    Given the following vehicle bookmarks exist:
      | user         | vehicle                          |
      | user: "john" | easy approved vehicle: "renault" |

    And I login as the user "john"

    When I go to a bookmarked vehicles page
    And I click on "Renault Megane" within the content
    And I wait for AJAX
    Then I should see "Delete bookmark"
    And I should not see "Add bookmark"

    When I click on "Delete bookmark"
    And I wait for AJAX
    Then I should not see "Delete bookmark"
    And I should see "Add bookmark"

    When I go to a bookmarked vehicles page
    Then I should not see "Renault Megane" within the content

  Scenario: Add a bookmark on a vehicle
    Given I login as the user "john"

    When I go to the easy approved vehicle "renault"'s profile by a direct link
    And I click on "Galleries"
    Then I should not see "Delete bookmark"
    And I should see "Add bookmark"

    When I click on "Add bookmark"
    And I wait for AJAX
    Then I should see "Delete bookmark"
    And I should not see "Add bookmark"

    When I go to a bookmarked vehicles page
    Then I should see "Renault Megane" within the content
