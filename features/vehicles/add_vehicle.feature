@javascript
Feature: Add a vehicle
  In order to share my vehicle with others
  As a user
  I want to add my vehicles

  Scenario: navigation to the new vehicle page
    Given a user "john" exists with username: "johndoe"

    And I login as the user "john"

    When I go to view my profile by a direct link
    And I click on "Vehicles" within the content
    And I click on "Add a vehicle"

    Then I should be on the new vehicle page

  Scenario: brand model version exist
    Given a user "john" exists with username: "johndoe"
    And the following easy versions exist:
      | brand_name | model_name | name   |
      | Audi       | TT         | RS 2.5 |

    And I login as the user "john"

    When I go to the new vehicle page by a direct link
    And I select "automobile" vehicle type within the content
    And I select "Audi" brand from chosen within the content
    And I select "TT" model from chosen within the content
    And I click on "Create the vehicle"

    Then I should see "Audi TT" within the breadcrumb

  Scenario: brand exists, new model to add
    Given a user "john" exists with username: "johndoe"
    And the brand exists with name: "Ducati"

    And I login as the user "john"

    When I go to the new vehicle page by a direct link
    And I select "motorcycle" vehicle type within the content
    And I select "Ducati" brand from chosen within the content

    And I add "Multistrada" option to chosen select "#model_id"
    And I click on "Create the vehicle"

    Then I should see "Ducati Multistrada" within the breadcrumb
    When I click on "Identification" within the content
    Then I should see "Model" within the content

  Scenario: brand and model to add
    Given a user "john" exists with username: "johndoe"

    And I login as the user "john"

    When I go to the new vehicle page by a direct link
    And I select "motorcycle" vehicle type within the content
    And I add "Ducati" option to chosen select "#brand_id"
    And I wait for AJAX
    And I add "Multistrada" option to chosen select "#model_id"
    And I click on "Create the vehicle"

    Then I should see "Ducati Multistrada" within the breadcrumb
    When I click on "Identification" within the content
    Then I should see "Model" within the content

  Scenario: version should have owner's country market version name
    Given a user "john" exists with username: "johndoe", country_code: "UA"
    And the following easy versions exist:
      | brand_name | model_name | name   |
      | Audi       | TT         | RS 2.5 |

    And I login as the user "john"

    When I go to the new vehicle page by a direct link
    And I select "automobile" vehicle type within the content
    And I select "Audi" brand from chosen within the content
    And I select "TT" model from chosen within the content
    And I click on "Create the vehicle"

    And I wait for AJAX

    And I add "some body" option to chosen select "#version_body_id"
    And I add "some name" option to chosen select "#name_id"
    And I select "me" ownership owner name from chosen
    And I select "build mine" ownership status from chosen

    And I wait for AJAX

    And I add "2000" option to chosen select "#production_year_id"

    And I wait for AJAX

    And I add "6 manual" option to chosen select "#version_transmission_numbers_id"

    And I wait for AJAX

    And I add "RWD" option to chosen select "#version_transmission_type_id"

    Then I should see "UA" selected in single chosen select "#market_version_name_id"