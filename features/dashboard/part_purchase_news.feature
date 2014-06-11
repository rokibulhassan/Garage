@javascript
Feature: part purchase news feature
  In order to watch following users news
  As a user
  I want to see part purchase news on dashboard

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
    And a modification exist with vehicle: vehicle with avatar "daewoo", name: "test mod"
    And a part exist with label: "test part"
    And a vendor exist with name: "test vendor"

    When I login as the user "john"

    Then I should not see "blackjack bought test part from (test vendor)" within "#news"

    When I logout
    And I login as the user "jack"
    And I go to the vehicle with avatar "daewoo"'s modifications by a direct link
    And I click on "test mod"
    And I click on "Add a part"
    And I select "test part" part from chosen within the modification parts
    And I select "test vendor" vendor from chosen within the modification parts

    And I logout
    And I login as the user "john"
    And I wait for AJAX

    Then I should see "blackjack bought test part from (test vendor)" within "#news"