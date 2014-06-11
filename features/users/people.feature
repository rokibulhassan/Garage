@javascript
Feature: profile
  In order to allow people to manage relationship
  As a user
  I want to have people page

  Scenario: view followings
    Given the following users exists:
      | user | username  | last_name | last_name | country_code |
      | jd   | johndoe   | Doe       | John      | BR           |
      | bj   | blackjack | Black     | Jack      | BR           |

    And the following followings exists:
      | user      | thing     |
      | user "jd" | user "bj" |

    When I login as the user "jd"
    And I go to the my people page by a direct link
    And I wait for AJAX

    Then I should see "blackjack" within "#followings"
    And I should see "blackjack avatar" image

  Scenario: view followings
    Given the following users exists:
      | user | username  | last_name | last_name | country_code |
      | jd   | johndoe   | Doe       | John      | BR           |
      | bj   | blackjack | Black     | Jack      | BR           |

    And the following followings exists:
      | user      | thing     |
      | user "bj" | user "jd" |

    When I login as the user "jd"
    And I go to the my people page by a direct link
    And I click on "Followers"

    Then I should see "blackjack" within "#followers"
    And I should see "blackjack avatar" image
    Then I should not see "johndoe" within "#followers"