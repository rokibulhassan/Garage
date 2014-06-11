@javascript
Feature: visitor news feature
  In order to watch users news
  As  a user
  I want to see all users news on the dashboard

  Scenario: new gallery news
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |
      | dan  | dan       | D         | N         |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |
      | user "john" | user "dan"  |
      | user "dan"  | user "jack" |

    And the following vehicles exists:
      | vehicle      | user        |
      | jack vehicle | user "jack" |
      | dan vehicle  | user "dan"  |

    And the following modifications exist:
      | vehicle                | name       |
      | vehicle "jack vehicle" | "Jack mod" |
      | vehicle "dan vehicle"  | "Dan mod"  |

    When I go to the dashboard page by a direct link

    Then I should see "dan created new modification"
    And I should see "blackjack created new modification"