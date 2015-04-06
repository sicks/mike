# Helpers
# =======
def create_visitor
  @visitor ||= { provider: "google_oauth2", uid: "123456789" }
end

def find_user
  @user ||= User.includes(:auths).find_by( auths: @visitor.slice(:uid, :provider) )
end

def delete_user
  find_user
  @user.destroy unless @user.nil?
end

# Givens
# ======
Given(/^I do not exist as a user$/) do
  create_visitor
  delete_user
end

Given(/^I already exist as a user$/) do
  create_visitor
  create(:user)
end

Given(/^I am not logged in$/) do
  page.driver.submit :delete, "/logout", {}
end

Given(/^I am logged in$/) do
  create_visitor
  visit login_path
  click_link 'google'
end

# Whens
# =====
When(/^I sign in via google auth$/) do
  visit login_path
  click_link 'google'
end

When(/^I logout$/) do
  click_link 'Logout'
end

When(/^I visit the home page$/) do
  visit root_path
end

# Thens
# =====
Then(/^a new user should be created$/) do
  find_user
  expect(@user).to_not eq nil
end

Then(/^I should see a login success message$/) do
  expect(page).to have_content "Login Successful."
end

Then(/^I should see a logout success message$/) do
  expect(page).to have_content "Logout Successful."
end

Then(/^I should see 'login'$/) do
  expect(page).to have_content "Login"
end

