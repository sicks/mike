require 'rails_helper'

RSpec.feature 'OmniAuth Authentication', type: :feature do
  let!(:user) { create(:user) }
  before(:example) do
    login_with_omniauth
  end

  scenario 'User signs in with google', :vcr do
    expect(page).to have_content "logged in as"
  end

  scenario "User signs out", :vcr do
    click_link "Logout"
    expect(page).to have_content "unrecognized user"
  end
end
