@javascript
Feature: delete model
  In order to make clean up
  As an admin
  I want to delete models

  Scenario: delete model without associations
    Given an admin user "john" exists
    And the model "X5" exist with name: "X5"

    When I login as the admin user "john" to admin
    And I click on "Models"

    Then I should see "X5" within the model "X5" model

    When I click on "Delete" within the model "X5" model

    Then I should see "Model was successfully destroyed."
    And I should not see "X5"

  Scenario: do not delete model with associated vehicles
    Given an admin user "john" exists
    And the easy model "X5" exist with name: "X5", brand_name: "Bmw"
    And the version exist with model: easy model "X5"

    When I login as the admin user "john" to admin
    And I click on "Models"

    Then I should see "X5" within the model "X5" model

    When I click on "Delete" within the model "X5" model
    And I click on "Models"

    Then I should see "X5" within the model "X5" model