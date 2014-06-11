@javascript
Feature:

  Background: I am on the purchases tab
    Given a user "john" exists with username: "johndoe"
    And the following easy versions exist:
      | easy version | brand_name | model_name | name      |
      | audi         | Audi       | TT         | RS 2.5    |
      | bmw          | BMW        | M3         | Cabriolet |
    And the following approved vehicles exist:
      | approved vehicle | user        | version        |
      | audi tt          | user "john" | version "audi" |
      | bmw x7           | user "john" | version "bmw"  |
    And the following vendors exists:
      | vendor | name         |
      | bill   | Bill Stone   |
      | jack   | Country jack |
    And the following parts exists:
      | part    | label_en |
      | spoiler | spoiler  |
      | exhaust | exhaust  |
    And the following part purchases exists:
      | part purchase | vendor        | part           | vehicle                    | price |
      | bills spoiler | vendor "bill" | part "spoiler" | approved vehicle "audi tt" | 137   |
      | jacks exhaust | vendor "jack" | part "exhaust" | approved vehicle "bmw x7"  | 384   |

    And I login as the user "john"

  Scenario:
    When I go to the approved vehicle "audi tt"'s profile by a direct link
    And I click on "Expenses"
    Then I should see "spoiler" within the expenses table
    And I should see "Bill Stone" within the expenses table
    And I should see "137 €" within the expenses table
    And I should not see "Country jack" within the expenses table

