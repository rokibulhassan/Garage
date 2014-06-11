@javascript
Feature: modification news feature
  In order to watch following users news
  As a user
  I want to see modification news on dashboard

  Scenario: new modification news
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |

    And an approved version "daewoo lanos" exists
    And a vehicle with avatar "daewoo" exists with version: approved version "daewoo lanos", user: user "jack"

    When I login as the user "john"

    Then I should not see "blackjack" within "#news"

    When I logout
    And I login as the user "jack"
    And I go to the vehicle with avatar "daewoo"'s modifications by a direct link
    And I click on "Add new modification"
    And I fill in "name" with "test_mod"
    And I click on "Add the modification"
    And I logout
    And I login as the user "john"

    Then I should see "blackjack created new modification" within "#news"