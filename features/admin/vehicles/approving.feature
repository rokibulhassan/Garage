@javascript
Feature: vehicles approving
  In order to decrease amount of versions, allow user more features
  As an admin
  I want to approve vehicles


  Scenario: approve vehicles
    Given an admin user "john" exists
    And the following easy vehicles exist:
     | easy vehicle | brand_name | model_name |
     | BMW          | BMW        | X5         |

    When I login as the admin user "john" to admin
    And I click on "Vehicles"

    Then I should see "Bmw X5" within the vehicle "BMW" model
    And I should see "unapproved" within the vehicle "BMW" model

    When I click on "Bmw X5" within the vehicle "BMW" model
    And I click on "Approve current version"
    And I click on "Vehicles"

    Then I should not see "unapproved" within the vehicle "BMW" model

  Scenario: assign existing version
    Given an admin user "john" exists
    And the following easy approved vehicles exist:
      | easy approved vehicle | brand_name | model_name |
      | BMW                   | Bmw        | X5.0       |
    And the following easy vehicles exist:
      | easy vehicle | brand_name | model_name |
      | BMW2         | Bmw        | X5B        |

    When I login as the admin user "john" to admin
    And I click on "Vehicles"

    And I should not see "unapproved" within the vehicle "BMW" model
    And I should see "unapproved" within the vehicle "BMW2" model

    When I click on "Bmw X5B" within the vehicle "BMW2" model
    And I select "Bmw X5.0" vehicle version from chosen
    And I click on "Assign version"
    And I click on "Vehicles"

    Then I should not see "unapproved" within the vehicle "BMW2" model
