# Helpers
# =======
def create_visitor
  @visitor ||= { provider: "google_oauth2", uid: "123456789" }
end

def find_user
  @user ||= User.includes(:auths).find_by( auths: { uid: @visitor[:uid], provider: @visitor[:provider] } )
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

# Whens
# =====
When(/^I sign in via google auth$/) do
  visit login_path
  click_link 'google'
end

# Thens
# =====
Then(/^a new user should be created$/) do
  find_user
  expect(@user).to_not eq nil
end

Then(/^I should see a success message$/) do
  expect(page).to have_content "Login Successful."
end

