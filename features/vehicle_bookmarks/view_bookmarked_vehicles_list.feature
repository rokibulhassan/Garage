@javascript
Feature: View bookmarked vehicles list
  In order to get a quick access to other users' vehicle profiles I found interesting
  As a user
  I want to view a list of my bookmarked vehicles

  Scenario: View bookmarked vehicles list
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And the following easy vehicles exist:
      | easy vehicle | brand_name | model_name | user           |
      | ford         | Ford       | Focus      | user "richard" |
      | audi         | Audi       | TT         | user "richard" |
      | bmw          | BMW        | X7         | user "richard" |
    And the following vehicle bookmarks exist:
      | user         | vehicle              |
      | user: "john" | easy vehicle: "ford" |
      | user: "john" | easy vehicle: "bmw"  |

    And I login as the user "john"

    When I go to a bookmarked vehicles page

    Then I should see "Ford Focus" within the content
    And I should see "Bmw X7" within the content
    And I should not see "Audi TT" within the content
