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
  
    Given the following devices exist:
    | name        | 
    | Mobile     |
  
    Given the following settopboxes exist:
    | name        | 
    | Apple       |
  
  Scenario: Show and Edit and Destroy
    Given I am on the packages page
    When I follow "New Package"
    Then I should be on the new package page
    And I fill in "Name" with "ABC"
    And I fill in "Cost" with "10"
    And I fill in "Link" with "https://www.Youtube.com"
    Then I check "DVR"
    Then I check "KTV"
    Then I check "Mobile"
    Then I check "Apple"
    And I press "Submit"
    Then I should see "Create success!"
    When I follow "Package list"
    Then I should be on the packages page
    Then I should see "Show"
    And I follow "Show"
    Then I am on the package page
    And I follow "Back"
    Then I should be on the packages page
    And I follow "Edit"
    Then I am on the edit package page
    And I press "Submit"
    Then I should be on the package page
    And I follow "Back"
    Then I should be on the packages page
    
  Scenario: Add Package and Add New Hierarchical Package
    Given I am on the packages page
    When I follow "New Package"
    Then I should be on the new package page
    And I fill in "Name" with "ABC"
    And I fill in "Cost" with "10"
    And I fill in "Link" with "https://www.Youtube.com"
    Then I check "DVR"
    Then I check "KTV"
    Then I check "Mobile"
    Then I check "Apple"
    And I press "Submit"
    Then I should see "Create success!"
    Then I should see "10"
    Then I should see "Add New Hierarchical Package "
    And I am on the package page
    Given I am on the packages page
    When I follow "New Hierarchical Package"
    Then I follow "Select"
    Then I fill in "Name" with "Sun1"
    Then I check "Sun TV"
    Then I fill in "Cost" with "100"
    Then I fill in "Link" with "https://www.Youtube1.com"
    Then I check "DVR"
    Then I press "Submit"
    Then I should see "Package name"
    

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