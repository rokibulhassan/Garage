@javascript
Feature: View vehicle modifications
  In order to compare vehicles
  As a user
  I want to add modifications

  Background:
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the following vehicles exist:
      | vehicle | user        | version                      |
      | audi tt | user "john" | easy approved version "audi" |

    And I login as the user "john"

  Scenario:
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "Add new modification"
    And I fill in "Modification name" with "My super mod"
    And I click on "Add the modification"

    Then I should see "My super mod"