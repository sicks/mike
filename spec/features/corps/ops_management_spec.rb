require 'rails_helper'

RSpec.feature "Operation Management", type: :feature do

  context "when user is logged in, and has api keys" do
    let!(:user) { create(:user) }
    before(:example) do
      login_with_omniauth
      user.api_keys.create( attributes_for(:api_key) )
    end

    scenario "user views ops index", :vcr do
      click_link "Ops"

      expect(page).to have_content "Operations"
    end

    scenario "user creates a new op", :vcr do
      click_link "Ops"
      click_link "new"
      select user.corporations.first.name, from: "Corp"
      fill_in "Name", with: "chain mapping"
      click_link_or_button "save"

      expect(page).to have_content "chain mapping"
    end
  end
end
