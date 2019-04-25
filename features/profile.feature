Feature: Admin Powers
  
  As an admin
  I want to handle stream packages
  So that users have a lot of popular choices
  
# Background: Admin is logged in
#   Given I am on the signin page
#   And I follow "Sign in with Google"
#   Then I am on the home page
Background: Add package information 
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
    | BET         | 
    | BTN         |
    |       CBS   |
    | A&E         |
    | ABC         |
    | AMC         |
    When I follow "Package list" 
    Then I follow "New Package"
    Then I fill in "Name" with "CBS"
    Then I fill in "Cost" with "60"
    Then I check "DVR" 
    Then I check "CBS"
    Then I check "BET"
    Then I check "BTN"
    Then I press "Submit"
    Then I should see "Create success!"
    Then I follow "Back"
    Then I follow "New Package"
    Then I fill in "Name" with "AmazonPrime"
    Then I fill in "Cost" with "50"
    Then I check "CBS"
    Then I check "BET"
    Then I check "BTN"
    Then I press "Submit"
    Then I should see "Create success!"
    
  Scenario: Show and Edit and Destroy
    When I follow "User management" 
    Then I should be on the users page
    And I follow "Show"
    Then I am on the users1 page
    And I follow "Edit your profile"
    Then I fill in "First name" with "Ruijing"
    Then I fill in "Last name" with "Bao"
    Then I press "Update profile"
    Then I should be on the users1 page
    And I follow "Edit your profile"
    Then I follow "Cancel and return to profile page"
    Then I should be on the users1 page
    And I follow "Edit Antenna Channel"
    Then I am on the antenna page
    Then I check "BET"
    Then I press "Submit"
    And I should be on the users1 page
    And I follow "Edit Antenna Channel"
    Then I follow "Cancel and to back to profile"
    Then I should be on the users1 page
    And I follow "Edit your Devices"
    Then I should be on the devices1 page
    # Then I should see "Apple"
    Then I press "Submit"
    And I should be on the users1 page
    And I follow "Edit your Devices"
    Then I follow "Cancel and to back to profile"
    Then I should be on the users1 page
    And I follow "Edit your Set Top Boxes"
    Then I should be on the boxes1 page
    Then I press "Submit"
    And I should be on the users1 page
    
  

  Scenario:Recommendation
    When I follow "User management" 
    Then I should be on the users page
    And I follow "Show"
    Then I am on the users1 page
    And I follow "Edit your profile"
    Then I fill in "First name" with "Ruijing"
    Then I fill in "Last name" with "Bao"
    Then I press "Update profile"
    Then I should be on the users1 page
    Then I follow "Calculate"
    Then I check "CBS"
    Then I check "BTN"
    Then I check "BET"
    Then I check "DVR"
    Then I fill in "Budget" with "60"
    Then I check "Only need one package?"
    Then I press "Calculate"
    # Then I should be on the result page
    Then I should see "Package set"