@javascript
Feature: vehicles index
  In order to better maintaining
  As an admin
  I want to have vehicles info page

  Scenario: index page
    Given an admin user "john" exists
    And the following easy versions exists:
      | easy version | body      | name         | production_year | production_code | brand_name | model_name | transmission_numbers | transmission_type |
      | bmw          | hatchback | some_version | 2002            | FFSWER0233      | BMW        | X5         |                      |                   |
      | audi         | coupe     | more_version | 2004            | PPSDRR#123      | Audi       | A3         | 4 auto               | WTF               |
    And the following vehicles exist:
      | vehicle | version        |
      | BMW     | version "bmw"  |
      | Audi    | version "audi" |

    And the modification exist with vehicle: vehicle "BMW"

    When I login as the admin user "john" to admin
    And I click on "Vehicles"

    Then I should see "Bmw X5" within the vehicle "BMW" model
    And I should see "hatchback" within the vehicle "BMW" model
    And I should see "some_version" within the vehicle "BMW" model
    And I should see "2002" within the vehicle "BMW" model
    And I should see "FFSWER0233" within the vehicle "BMW" model
    And I should see "unapproved" within the vehicle "BMW" model

    And I should see "identified" within the vehicle "Audi" model