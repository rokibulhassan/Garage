@javascript
Feature: Filter vehicles by a freeform text query
  In order to improve convenience of browsing other users' vehicles
  As a guest
  I want to narrow search results by a text query

  Scenario Outline: I am on the vehicles search page
    Given the following models exist:
      | model      | name            |
      | en         | EN model !FIND! |
      | fr         | model !FIND!    |
      | version_en | EN version      |
      | version_fr | FR version      |
      | other      | FAIL model      |
    And the following approved versions exist:
      | approved version  | label_en       | label_fr       | model               |
      | en                | version !FIND! | none given     | model: "version_en" |
      | fr                | none given     | version !FIND! | model: "version_fr" |
      | model_en          | none given     | none given     | model: "en"         |
      | model_fr          | none given     | none given     | model: "fr"         |
      | other             | FAIL version   | FAIL version   | model: "other"      |
    And the following vehicles exist:
      | version                      |
      | approved_version: "en"       |
      | approved_version: "fr"       |
      | approved_version: "model_en" |
      | approved_version: "model_fr" |
      | approved_version: "other"    |

    And I am a guest with English language preferred

    When I go to a users' vehicles search page
    And I click on "[recherche personnalisée]"

    And I fill in "query" with "<attribute> !find" within the vehicles search form
    And I click on "Chercher" within the vehicles search form
    Then I should see "<attribute>" within the content
    And I should not see "FAIL model" within the content

    Examples:
      | attribute |
      | EN model  |
      | version   |