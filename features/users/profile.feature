@javascript
Feature: profile
  In order to improve the information content
  As a user
  I want to have user profile information

  Scenario: view profile information
    Given a user "john" exists with username: "johndoe", last_name: "Doe", first_name: "John", country_code: "BR"

    When I login as the user "john"
    And I go to the user "john"'s profile by a direct link

    Then I should see "John Doe (BR)" within the user information
    And I should see "0 mods - 0 photos" within the user information
    And I should not see "Comparisons" within the navigation bar

  Scenario: I should see side view bar with vehicle silhouettes
    Given the following users exist:
      | user | username |
      | john | johndoe  |
      | jack | jackdoe  |

    And the following easy vehicles exists:
      | easy vehicle   | brand_name | model_name | user        |
      | BMW X5         | BMW        | X5         | user "john" |
      | Audi TT        | Audi       | TT         | user "john" |
      | Renault Megane | Renault    | Megane     | user "jack" |

    When I login as the user "john"
    And I go to the user "john"'s profile by a direct link

    Then I should see "Bmw X5" image within the silhouettes bar
    And I should see "Audi TT" image within the silhouettes bar
    And I should not see "Renault Megane" image within the silhouettes bar

  Scenario: I should see user's comparisons
    Given a user "john" exists with username: "johndoe", last_name: "Doe", last_name: "John", country_code: "BR"
    And a user "jack" exists with username: "jackdoe", last_name: "Doe", first_name: "Jack", country_code: "BR"
    And the following comparison tables exists:
    | label        |  user       |
    | Cool CS      | user "jack" |
    | The best CS  | user "jack" |
    | The worse CS | user "john" |

    When I login as the user "john"
    And I go to the user "jack"'s profile by a direct link
    And I click on "Comparisons" within the navigation bar

    Then I should see "Cool CS" within the comparisons
    And I should see "The best CS" within the comparisons
    And I should not see "The worse CS" within the comparisons

  Scenario: following feature
    Given the following users exists:
      | user | username  | last_name | last_name | country_code |
      | jd   | johndoe   | Doe       | John      | BR           |
      | bj   | blackjack | Black     | Jack      | BR           |

    When I login as the user "jd"
    And I go to the user "bj"'s profile by a direct link
    And I click on "Follow"

    Then I should see "Unfollow" within "#follow"

  Scenario: edit collages
    Given a user "john" exists with username: "johndoe", last_name: "Doe", first_name: "John", country_code: "BR"

    When I login as the user "john"
    And I go to the user "john"'s profile by a direct link
    And I click on "Edit collages"

    Then the "Wall" tab should be active