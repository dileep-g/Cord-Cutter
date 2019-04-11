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
    | Sun         | 
    | KTV         | 
    
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
    And I follow "Edit antenna channel"
    Then I am on the antenna page
    Then I should see "KTV"
    #Then I check "KTV"
    Then I press "Submit"
    And I should be on the users1 page
    And I follow "Edit antenna channel"
    Then I follow "Cancel and to back to profile"
    Then I should be on the users1 page
    And I follow "Edit your devices"
    Then I should be on the devices1 page
    # Then I should see "Apple"
    Then I press "Submit"
    And I should be on the users1 page
    And I follow "Edit your devices"
    Then I follow "Cancel and to back to profile"
    Then I should be on the users1 page
    And I follow "Edit your set top boxes"
    Then I should be on the boxes1 page
    Then I press "Submit"
    And I should be on the users1 page
    
  

  Scenario: Add Package
    Given I am on the devices page
    When I follow "New Device"
    Then I should be on the new device page
    And I fill in "Name" with "ABC"
    #And I fill in "Cost" with "10"
    #And I go with "Sun TV, KTV" from Channels
    And I press "Create new device"
    Then I should see "Create success!"
    And I am on the device page