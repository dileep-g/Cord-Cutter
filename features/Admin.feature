Feature: Admin Powers
  
  As an admin
  I want to handle stream packages
  So that users have a lot of popular choices
  
# Background: Admin is logged in
#   Given I am on the signin page
#   And I follow "Sign in with Google"
#   Then I am on the home page
Background: Admin is logged in
    Given I am on the signup page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I fill in "Confirmation" with "test123pass"
    And I check "Sign up as admin"
    And I press "Create my account"
    Then I should be on the user page
    And I should see "Sign up success!" 
    Given I am on the login page
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "test123pass"
    And I press "Login"
    Then I should be on the user page
  
  Given the following channels exist:
  | name        | 
  | Sun TV      | 
  | KTV         | 

  Given the following packages exist:
  | name        | cost |
  | Sun Network |  50  |

  Scenario: Show and Edit and Destroy
    When I follow "Package list" 
    Then I should be on the packages page
    And I follow "Show"
    Then I am on the package page
    And I follow "Back"
    Then I should be on the packages page
    And I follow "Edit"
    Then I am on the edit package page
    And I press "Update package information"
    Then I should be on the package page
    And I follow "Back"
    Then I should be on the packages page
    
  Scenario: Add Package
    Given I am on the packages page
    When I follow "New Package"
    Then I should be on the new package page
    And I fill in "Name" with "ABC"
    #And I fill in "Cost" with "10"
    #And I go with "Sun TV, KTV" from Channels
    And I press "Create new package"
    Then I should see "Create success!"
    And I am on the package page

  # Scenario: Add Stream Package
  #   When I follow "Add Stream Package"
  #   Then I should see "New Stream Package"
  #   And I fill in "Name" with "ABC"
  #   And I fill in "Cost" with "10"
  #   And I press "Create Stream package"
  #   Then I should see "Stream package was successfully created"
  #   And I am on the details page for "ABC"
  
  # Scenario: More Info about and back to home
  #   When I go to the details page for "Sun Network"
  #   Then I should see "Name: Sun Network"
  #   And I follow "Back"
  #   Then I should be on the home page
  
  # Scenario: More Info and Edit
  #   When I go to the details page for "Sun Network"
  #   And I follow "Edit"
  #   Then I should be on the edit page for "Sun Network"
  #   And I fill in "Cost" with "500"
  #   And I press "Update Stream package"
  #   Then I should see "Stream package was successfully updated"
  #   And I am on the details page for "Sun Network"
  #   And the cost of "Sun Network" should be 500
    
  # Scenario: More Info -> Edit -> Show
  #   cenario: More Info and Edit
  #   When I go to the details page for "Sun Network"
  #   And I follow "Edit"
  #   And I follow "Show"
  #   Then I should be on the details page for "Sun Network"
    
  # Scenario: More Info -> Edit -> Back
  #   When I go to the details page for "Sun Network"
  #   And I follow "Edit"
  #   And I follow "Back"
  #   Then I should be on the home page