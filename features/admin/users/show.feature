@javascript
Feature: user show
  In order to better maintaining
  As an admin
  I want to have detailed user info page

  Scenario: user vehicles
    Given an admin user "john" exists
    And the following users exists:
      | user | first_name | last_name |
      | JD   | John       | Doe       |
      | JB   | Jack       | Black     |

    And the following easy vehicles exist:
      | easy vehicle | user      | brand_name | model_name |
      | X5           | user "JD" | Bmw        | X5         |
      | x6           | user "JD" | Bmw        | X6         |
      | tt           | user "JB" | Audi       | TT         |

    When I login as the admin user "john" to admin
    And I click on "Users"
    And I click on "John Doe" image

    Then I should see "Bmw X5" within the easy vehicle "X5" model
    And I should see "Bmw X6" within the easy vehicle "X6" model
    And I should not see "Audi TT"