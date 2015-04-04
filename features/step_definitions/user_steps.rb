# Helpers
# =======
def create_visitor
  @visitor ||= { provider: "google", uid: "123456789" }
end

def delete_user
  @user ||= User.includes(:auths).find_by( auths: { uid: @visitor[:uid], provider: @visitor[:provider] } )
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
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be signed in$/) do
  pending # express the regexp above with the code you wish you had
end

