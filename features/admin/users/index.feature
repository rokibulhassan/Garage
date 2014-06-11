@javascript
Feature: user index
  In order to better maintaining
  As an admin
  I want to have users info page

  Scenario Outline: user vehicles quantity numbers
    Given an admin user "john" exists
    And the following users exists:
      | user | first_name | last_name |
      | JD   | John       | Doe       |
      | JB   | Jack       | Black     |

    And the following <kind> vehicles exist:
      | <kind> vehicle | user      | brand_name | model_name |
      | X5             | user "JD" | Bmw        | X5         |
      | x6             | user "JD" | Bmw        | X6         |
      | tt             | user "JB" | Audi       | TT         |

    When I login as the admin user "john" to admin
    And I click on "Users"

    Then I should see "<label>" within the vehicle quantities within the user "JD" model

    When I click on "2" within the vehicle quantities within the user "JD" model

    Then I should see "Bmw X5" within the vehicle "X5" model
    And I should see "Bmw X6" within the vehicle "X6" model
    And I should not see "Audi TT"

  Examples:
    | kind          | label |
    | easy          | 0 (2) |
    | easy approved | 2 (0) |
