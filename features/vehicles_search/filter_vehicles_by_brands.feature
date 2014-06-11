@javascript
Feature: Filter vehicles by brands
  In order to improve convenience of browsing other users' vehicles
  As a guest
  I want to narrow search results by brands

  Background: I am on the vehicles search page
    And the following easy approved vehicles exist:
      | brand_name | model_name |
      | Renault    | Mégane     |
      | Citroën    | Type A     |
      | Peugeot    | 206        |
      | Peugeot    | 3008       |
    And the following easy vehicles exist:
      | brand_name | model_name |
      | Peugeot    | 3300       |

    When I go to a users' vehicles search page
    Then I should see "Citroën Type A" within the content
    And I should see "Peugeot 206" within the content
    And I should see "Peugeot 3008" within the content
    And I should see "Renault Mégane" within the content
    And I should not see "Peugeot 3300" within the content

    And I click on "[recherche personnalisée]"

  Scenario: Filter vehicles by a selected brand
    When I select "Citroën" brand from chosen within the vehicles search form
    And I click on "Chercher" within the vehicles search form
    Then I should see "Citroën Type A" within the content
    And I should not see "Peugeot 206" within the content
    And I should not see "Peugeot 3008" within the content
    And I should not see "Renault Mégane" within the content
    And I should not see "Peugeot 3300" within the content

  Scenario: Filter vehicles by excluded brands
    When I exclude select "Citroën" brand within the vehicles search form
    And I exclude select "Renault" brand within the vehicles search form
    And I click on "Chercher" within the vehicles search form
    Then I should not see "Citroën Type A" within the content
    And I should see "Peugeot 206" within the content
    And I should see "Peugeot 3008" within the content
    And I should not see "Renault Mégane" within the content
    And I should not see "Peugeot 3300" within the content
