@javascript
Feature: user index
  In order to make clean up
  As an admin
  I want to delete brands

  Scenario: delete brand without associations
    Given an admin user "john" exists
    And the brand "looser" exist with name: "Brand which doesn't have any model"

    When I login as the admin user "john" to admin
    And I click on "Brands"
    And I click on "All"

    Then I should see "Brand Which Doesn't Have Any Model" within the brand "looser" model

    When I click on "Delete" within the brand "looser" model

    Then I should see "Brand was successfully destroyed."
    And I should not see "Brand Which Doesn't Have Any Model"

  Scenario: do not delete brand with associated model
    Given an admin user "john" exists
    And the brand "winner" exist with name: "Brand which has a model"
    And the model exist with name: "test", brand: brand "winner"

    When I login as the admin user "john" to admin
    And I click on "Brands"
    And I click on "All"

    Then I should see "Brand Which Has A Model" within the brand "winner" model

    When I click on "Delete" within the brand "winner" model
    And I click on "Brands"
    And I click on "All"

    And I should see "Brand Which Has A Model"
