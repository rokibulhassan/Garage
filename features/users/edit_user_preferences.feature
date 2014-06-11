@javascript
Feature: Edit user preferences
  In order to get personalized view of the site
  As a user
  I want to change my preferences

  Scenario Outline: text inputs
    Given the following users exists:
      | user | first_name | last_name | email        | city   |
      | john | John       | Doe       | john@doe.com | Ankara |

    And I login as the user "john"

    When I go to the edit user page via menus
    Then I should see "<old_value>" in "<input_name>" field within the content

    When I fill in "<input_name>" with "<new_value>"
    And I trigger element change event
    And I go to the edit user page by a direct link

    Then I should see "<new_value>" in "<input_name>" field within the content

    Examples:
      | input_name | old_value    | new_value   |
      | first_name | John         | Richard       |
      | last_name  | Doe          | Roe           |
      | email      | john@doe.com | rick@roe.com  |
      | city       | Ankara       | London        |

  Scenario Outline: selectors
    Given the following users exists:
      | user | country_code | locale |
      | john | US           | en     |

    And I login as the user "john"

    When I go to the edit user page via menus
    Then I should see "<old_value>" selected in single chosen select "<input_id>"

    When I select "<new_value>" <of> within the content
    And I go to the edit user page by a direct link

    Then I should see "<new_value>" selected in single chosen select "<input_id>"

    Examples:
      | input_id           | old_value     | new_value | of      |
      | #user_country_code | United States | France    | country |
