@javascript
Feature: visitor news feature
  In order to watch users news
  As  a user
  I want to see all users news on the dashboard

  Scenario: load more news
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

    And news per page limit is 1

    When I go to the dashboard page by a direct link

    Then I should see "blackjack created new modification"
    And I should not see "dan created new modification"

    When I click on "Load more"

    Then I should see "dan created new modification"

  Scenario: menu items for visitor
    When I go to the dashboard page by a direct link

    Then "all-news" menu item should be enabled
    And "my-news" menu item should be enabled
    And "bookmarks" menu item should be disabled
    And "users-vehicles" menu item should be enabled
    And "my-profile" menu item should be disabled
    And "my-bikes" menu item should be disabled
    And "my-cars" menu item should be disabled
    And "comparisons" menu item should be disabled
    And "imported-content" menu item should be disabled
    And "my-public-albums" menu item should be disabled
    And "my-private-albums" menu item should be disabled

  Scenario: switching between all news/my news
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | blackjack | Black     | Jack      |
      | dan  | dan       | D         | N         |

    And the following followings exists:
      | user        | thing       |
      | user "john" | user "jack" |
      | user "jack" | user "dan"  |

    And the following vehicles exists:
      | vehicle      | user        |
      | jack vehicle | user "jack" |
      | dan vehicle  | user "dan"  |

    And the following modifications exist:
      | vehicle                | name       |
      | vehicle "jack vehicle" | "Jack mod" |
      | vehicle "dan vehicle"  | "Dan mod"  |


    And I login as user "john"

    Then I should see "blackjack created new modification"
    And I should not see "dan created new modification"

    When I go to the dashboard page by a direct link

    Then I should see "blackjack created new modification"
    And I should see "dan created new modification"

  Scenario: my cars
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | jackblack | Black     | Jack      |

    And the following easy vehicles exists:
      | user        | brand_name | model_name | vehicle_type |
      | user "john" | Bmw        | X5         | automobile   |
      | user "john" | Honda      | 750        | motorcycle   |
      | user "jack" | Bmw        | X6         | automobile   |

    And I login as user "john"

    When I go to the my cars page via menus

    Then I should see "Bmw X5"
    And I should not see "Bmw X6"
    And I should not see "Honda 750"

  Scenario: my bikes
    Given the following users exists:
      | user | username  | last_name | last_name |
      | john | johndoe   | Doe       | John      |
      | jack | jackblack | Black     | Jack      |

    And the following easy vehicles exists:
      | user        | brand_name | model_name | vehicle_type |
      | user "john" | Bmw        | X6         | automobile   |
      | user "john" | Honda      | 750        | motorcycle   |
      | user "jack" | Bmw        | X0         | motorcycle   |

    And I login as user "john"

    When I go to the my bikes page via menus

    Then I should see "Honda 750"
    And I should not see "Bmw X6"
    And I should not see "Bmw X0"