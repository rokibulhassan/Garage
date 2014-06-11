@javascript
Feature: View vehicle modifications
  In order to compare vehicles
  As a user
  I want to view modifications

  Scenario: view change set
    Given a user "john" exists with username: "johndoe"
    And the following easy approved versions exist:
      | easy approved version | brand_name | model_name | name   |
      | audi                  | Audi       | TT         | RS 2.5 |
    And the following vehicles exist:
      | vehicle | user        | version                      |
      | audi tt | user "john" | easy approved version "audi" |

    And the following part modifications exists:
      | part modification | name        | vehicle           | part    | quantity | price |
      | mod 1             | spoiler mod | vehicle "audi tt" | spoiler | 17       | 1383  |
    And the following service modifications exists:
      | service modification | name         | vehicle           | service           | duration | garage      |
      | mod 2                | cleaning mod | vehicle "audi tt" | part_installation | 3        | Bob cleaner |

    And the following modification properties exists:
      | modification property | modification                 | name                 | value |
      | displacement1         | part modification "mod 1"    | displacement         | 151   |
      | consumption_city1     | part modification "mod 1"    | consumption_city     | -13.8 |
      | displacement2         | service modification "mod 2" | displacement         | 70    |
      | consumption_city2     | service modification "mod 2" | consumption_city     | -19.3 |
      | consumption_mixed1    | part modification "mod 1"    | consumption_mixed    | 73    |
      | consumption_mixed2    | service modification "mod 2" | consumption_mixed    | -16   |

    And the change set "Cool CS" exists with name: "Cool CS", vehicle: vehicle "audi tt", modifications:
      | modification                 |
      | part modification "mod 1"    |
      | service modification "mod 2" |

    And I login as the user "john"

    When I go to the vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "Cool CS"
    And I wait for AJAX
    And I should see "cleaning mod" selected in change_set "Cool CS" modifications chosen select
    And I should see "spoiler mod" selected in change_set "Cool CS" modifications chosen select
    And I should see "spoiler" within the modification parts
    And I should see "Bob cleaner" within the modification services
    And I should see "221 mm" in the "Displacement" change set properties
    And I should see "57 mm" in the "Consumption mixed" change set properties
    And I should see "-33.1 mm" in the "Consumption city" change set properties


  Scenario: change set updating
    Given a user "john" exists with username: "johndoe"
    And the following approved vehicles exist:
      | approved vehicle | user        |
      | audi tt          | user "john" |

    And the following modifications exists:
      | modification | name     | vehicle                    |
      | mod 1        | test mod | approved vehicle "audi tt" |

    And the change set exists with name: "Cool CS", vehicle: vehicle "audi tt", modifications:
      | modification         |
      | modification "mod 1" |

    And the following parts exists:
      | label_en |
      | exhaust  |

    And the following vendors exists:
      | name |
      | bill |

    And I login as the user "john"
    When I go to the approved vehicle "audi tt"'s profile by a direct link
    And I click on "Modifications"
    And I click on "Cool CS"
    Then I should not see "exhaust" within the modification parts
    When I click on "All mods"
    And I click on "test mod"
    And I click on "Add a part"
    And I select "exhaust" part from chosen within the modification parts
    And I select "bill" vendor from chosen within the modification parts
    And I fill in "price" with "800" within the modification parts
    And I click on "Cool CS"
    Then I should see "exhaust" within the modification parts
    And I should see "bill" within the modification parts
    And I should see "800" within the modification parts


