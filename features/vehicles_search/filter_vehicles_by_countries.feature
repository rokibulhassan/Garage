@javascript
Feature: Filter vehicles by countries
  In order to improve convenience of browsing other users' vehicles
  As a guest
  I want to narrow search results by countries

  Background: I am on the vehicles search page
    Given the following users exist:
      | user    | country_code |
      | english | GB           |
      | french  | FR           |
      | italian | IT           |
    And the following easy approved vehicles exist:
      | brand_name | model_name | user            |
      | Renault    | Megane     | user: "french"  |
      | Bentley    | Azure      | user: "english" |
      | Ferrari    | 599 GTO    | user: "italian" |

    When I go to a users' vehicles search page
    Then I should see "Renault Megane" within the content
    Then I should see "Bentley Azure" within the content
    Then I should see "Ferrari 599 GTO" within the content

    And I click on "[recherche personnalisée]"

  Scenario: Filter vehicles by a selected country
    When I select "France" country within the vehicles search form
    And I click on "Chercher" within the vehicles search form
    Then I should see "Renault Megane" within the content
    Then I should not see "Bentley Azure" within the content
    Then I should not see "Ferrari 599 GTO" within the content

  Scenario: Filter vehicles by excluded countries
    When I exclude select "United Kingdom" country within the vehicles search form
    And I exclude select "France" country within the vehicles search form
    And I click on "Chercher" within the vehicles search form
    Then I should not see "Renault Megane" within the content
    Then I should not see "Bentley Azure" within the content
    Then I should see "Ferrari 599 GTO" within the content
