@javascript
Feature: Change order of gallery collages
  In order to fix inappropriate order of gallery collages
  As a user
  I want to change order of gallery collages

  Scenario:
    Given a user "john" exists with username: "johndoe"
    And a user "richard" exists with username: "richardroe"
    And an approved vehicle "john's celica" exists with user: user "john"
    And a gallery "full of collages" exists with layout: "collages", vehicle: approved vehicle "john's celica"
    And the following sample collages exist:
      | sample collage | gallery                     |
      | top            | gallery: "full of collages" |
      | middle         | gallery: "full of collages" |
      | bottom         | gallery: "full of collages" |

    And I login as the user "richard"

    When I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of collages"'s pictures list
    Then I should see the following collages list:
      | collage                  |
      | sample collage: "top"    |
      | sample collage: "middle" |
      | sample collage: "bottom" |

    When I logout
    And I login as the user "john"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of collages"'s pictures list
    And I click on "Edit collages" within the content
    And I move higher the collage: sample collage "bottom"
    Then I should see the following collages list:
      | collage                  |
      | sample collage: "top"    |
      | sample collage: "bottom" |
      | sample collage: "middle" |

    When I logout
    And I login as the user "richard"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of collages"'s pictures list
    Then I should see the following collages list:
      | collage                  |
      | sample collage: "top"    |
      | sample collage: "bottom" |
      | sample collage: "middle" |

    When I logout
    And I login as the user "john"
    And I go to the approved vehicle "john's celica"'s profile by a direct link
    And I click on "Galleries"
    And I go to the gallery "full of collages"'s pictures list
    And I click on "Edit collages" within the content
    And I move lower the collage: sample collage "top"
    Then I should see the following collages list:
      | collage                  |
      | sample collage: "bottom" |
      | sample collage: "top"    |
      | sample collage: "middle" |
