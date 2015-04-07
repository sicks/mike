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

Given(/^I have no api keys$/) do
  pending # express the regexp above with the code you wish you had
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

When(/^I visit '(.*)'$/) do |path|
  visit path
end

# Thens
# =====
Then(/^a new user should be created$/) do
  find_user
  expect(@user).to_not eq nil
end

Then(/^I should see '(.*)'$/) do |message|
  expect(page).to have_content message
end

Then(/^I should be redirected to '(.*)'$/) do |path|
  expect(current_path).to eq path
end

