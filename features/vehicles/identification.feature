@javascript
Feature: Vehicle identification feature
  In order to identify vehicle versions
  As a user
  I want to set version attributes

  Scenario: cascading logic
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    And the following easy vehicles exist:
      | easy vehicle  | user        | brand_name | model_name |
      | Audi A3       | user "john" | Audi       | A3         |
    And I login as the user "john"

    When I go to the easy vehicle "audi A3"'s profile by a direct link

    Then I should see "Body"
    And I should see "Version"
    And I should see "Driver"
    And I should see "Status"
    And I should not see "Model Year"
    And I should not see "Generation"

    When I add "hatchback" option to chosen select "#version_body_id"
    And I add "AST05" option to chosen select "#name_id"
    And I select "sold on" ownership status from chosen
    And I wait for AJAX

    Then I should see "Model Year"
    And I should see "Generation"
    And I should not see "Transmission"
    And I should not see "Type"

    When I add "1999" option to chosen select "#production_year_id"
    And I wait for AJAX

    Then I should see "Transmission"
    And I should see "Type"

  Scenario: cascade selects source fetching
    Given the following users exist:
      | user | username | country_code |
      | john | johndoe  | GB           |
    Given the following easy models exists:
      | easy model | brand_name | name |
      | A3         | Audi       | A3   |
    And the following versions exist:
      | version | model           | body      | production_year | name           | transmission_numbers  | transmission_type |
      | audi    | easy model "A3" |           |                 |                |                       |                   |
      | audi1   | easy model "A3" | Coupe     | 2005            | 1.5 Attraction | 1                     | AAA               |
      | audi2   | easy model "A3" | Hatchback | 2007            | 1.7 Attraction | 2 auto                | WWW               |
      | audi3   | easy model "A3" | Hatchback | 2008            | 1.8 Attraction | 3 manual              | WTF               |
    And the following vehicles exist:
      | vehicle  | user        | version        |
      | audi 1.6 | user "john" | version "audi" |
    And I login as the user "john"

    When I go to the vehicle "audi 1.6"'s profile by a direct link
    And I wait for AJAX

    Then "version_body_id" select should contain "Hatchback"
    And "version_body_id" select should contain "Coupe"
    And "name_id" select should not contain "1.5 Attraction"
    And "name_id" select should not contain "1.7 Attraction"
    And "name_id" select should not contain "1.8 Attraction"

    When I select "Hatchback" version body from chosen
    And I wait for AJAX

    Then "name_id" select should contain "1.7 Attraction"
    And "name_id" select should contain "1.8 Attraction"
    And "name_id" select should not contain "1.5 Attraction"

    When I select "1.7 Attraction" name from chosen
    And I select "sold on" ownership status from chosen
    And I wait for AJAX

    Then "production_year_id" select should contain "2007"
    And "production_year_id" select should contain "2008"
    And "production_year_id" select should not contain "2005"

    When I select "2008" production year from chosen
    And I wait for AJAX

    Then "version_transmission_numbers_id" select should contain "3 manual"
    And "version_transmission_numbers_id" select should not contain "2 auto"
    And "version_transmission_numbers_id" select should not contain "1"

    When I select "3 manual" version transmission numbers from chosen
    And I wait for AJAX

    Then "version_transmission_type_id" select should contain "WTF"
    And "version_transmission_type_id" select should not contain "AAA"
    And "version_transmission_type_id" select should not contain "WWW"

    When I select "WTF" version transmission type from chosen
    And I wait for AJAX

    And I should see "GB" selected in single chosen select "#market_version_name_id"


  Scenario Outline: saving attributes
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    Given the brand "Audi" exist with name: "audi"
    And the model "A3" exists with brand: brand "Audi"
    And the following versions exist
      | version | model      | body  | name         | production_year | transmission_numbers | transmission_type | production_code | market_version_name | <attribute> |
      | audi3   | model "A3" | coupe | version_name | 1945            | 4 auto               | WPF               | WRSSAW1         | mrt 12sSWfg         |             |
    And the vehicle "audi a3" exist with user: user "john", version: version "audi3"
    And I login as the user "john"

    When I go to the vehicle "audi a3"'s profile by a direct link
    And "<select_id>" select should not contain "<value>"
    And I add "<value>" option to chosen select "#<select_id>"
    And I go to the vehicle "audi a3"'s profile by a direct link

    Then I should see "<value>" selected in single chosen select "#<select_id>"

    Examples:
      | attribute            | value      | select_id                       |
      | body                 | newBody    | version_body_id                 |
      | name                 | newVersion | name_id                         |
      | transmission_numbers | 3 manual   | version_transmission_numbers_id |
      | transmission_type    | WTF        | version_transmission_type_id    |
      | production_code      | RRP        | production_code_id              |


  Scenario Outline: selectors should be filled by the same version values
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    Given the brand "Audi" exist with name: "audi"
    And the model "A3" exists with brand: brand "Audi"
    And the following versions exist
      | version | model      | <attribute> |
      | audi3   | model "A3" | <value1>    |
      | audi32  | model "A3" | <value2>    |
    And the vehicle "audi a3" exist with user: user "john", version: version "audi3"
    And I login as the user "john"

    When I go to the vehicle "audi a3"'s profile by a direct link
    And I click on "Identification"

    Then "<attribute>" select should contain "<value1>"
    And "<attribute>" select should contain "<value2>"

  Examples:
    | attribute | value1 | value2|
    | body      | test1  | test2 |

  Scenario: ownership
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    Given the version "audi" exist
    And the vehicle "audi A6" exist with version: version "audi", user: user "john"
    And I login as the user "john"

    When I go to the vehicle "audi A6"'s profile by a direct link
    And I select "sold on" ownership status from chosen within the ownership
    And I fill in "ownership_year" with "2012" within the ownership
    And I select "dad" ownership owner name from chosen within the ownership
    And I go to the vehicle "audi A6"'s profile by a direct link

    And I should see "sold on" selected in single chosen select "#ownership_status_id"
    And I should see "2012" in "ownership_year" field
    And I should see "dad" selected in single chosen select "#ownership_owner_name_id"


  Scenario Outline: should show default translations
    Given the following users exist:
      | user | username | locale            | country_code       |
      | john | johndoe  | <native_locale>   | <native_country>   |
      | jack | jackndoe | <watching_locale> | <watching_country> |

    And the following approved versions exist:
      | approved version | body  | transmission_numbers | transmission_type | production_year | name  |<attribute> |
      | audi             | tbody | tnumbers             | ttype             | 1999            | tname |<value>     |

    And the following easy translations exist:
      | key                                          | locale                               | text        |
      | model\|version\|<attribute>\|<transliterate> | <watching_locale>_<watching_country> | <translate> |

    And the vehicle "audi A6" exist with version: approved version "audi", user: user "john"
    And I login as the user "jack"

    When I go to the vehicle "audi A6"'s profile by a direct link
    And I click on "Identification"

    Then I should see "<translate>" within "td.<attribute>"

  Examples:
    | attribute            | native_locale | native_country | watching_locale | watching_country | value   | transliterate | translate |
    | body                 | en            | FR             | fr              | BR               | sedan   | sedan         | sedane    |
    | body                 | fr            | FR             | en              | BR               | coupé   | coupe         | cupe      |
    | transmission_type    | fr            | FR             | en              | BR               | 5-étape | 5-etape       | 5-st      |
    | transmission_numbers | fr            | FR             | en              | BR               | WTF     | WTF           | FTM       |

  Scenario Outline: aliases for different vehicle types
    Given the following users exist:
      | user    | username   |
      | john    | johndoe    |
    And the following vehicles exist:
      | vehicle | user        | vehicle_type |
      | Audi A3 | user "john" | <type>       |
    And I login as the user "john"

    When I go to the vehicle "audi A3"'s profile by a direct link

    Then I should see "<alias1>"
    And I should see "<alias2>"
    And I should see "<alias3>"

    Examples:
    | type       | alias1 | alias2   | alias3  |
    | automobile | Body   | Model    | Version |
    | motorcycle | Engine | Category | Model   |