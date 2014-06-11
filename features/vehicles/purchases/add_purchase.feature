@javascript
Feature:

  Background:
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name     |
      | audi                  | Audi       | TT         | RS 2.5    |
    And the following vehicles exist:
      | vehicle | user        | version                      |
      | audi tt | user "john" | easy approved version "audi" |
    And the following vendors exists:
      | vendor | name         |
      | bill   | Bill Stone   |
    And the following parts exists:
      | part    | label_en |
      | spoiler | spoiler  |
    And I login as the user "john"

  Scenario: add new purchase
    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Expenses"
    Then I should not see "Bill Stone" within the expenses table
    When I click on "Add purchase"
    And I select "Bill Stone" vendor from chosen
    And I select "spoiler" part from chosen
    And I click on "Add the part purchase"
    Then I should see "spoiler" within the expenses table
    And I should see "Bill Stone" within the expenses table