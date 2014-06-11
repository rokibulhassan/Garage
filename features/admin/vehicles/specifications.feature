@javascript
Feature: Manage specifications of vehicle versions
  In order to manage vehicle versions
  As an admin
  I want to edit vehicle version properties

  Scenario: updating vehicle specs
    Given an admin user "john" exists

    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name |
      | bmw x5                | Bmw        | X5         |
    And the following version properties exist:
      | version                         | name      | value | unit_type |
      | easy approved version: "bmw x5" | top_speed | 210   | speed     |
    And the following vehicles exist:
      | vehicle | version                    |
      | bmw     | easy approved version: "bmw x5" |

    When I login as the admin user "john" to admin
    And I click on "Vehicles"
    And I click on "Bmw X5"

    Then I should see "210.0" in "version_property[value]" field within "#version_property_top_speed"

    When I fill in "version_property[value]" with "120" within "#version_property_top_speed"
    And I click on "Update"
    Then I should see "120.0" in "version_property[value]" field within "#version_property_top_speed"