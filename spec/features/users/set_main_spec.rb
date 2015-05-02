require 'rails_helper'

RSpec.feature "user selects their main" do
  let!(:user) { create(:user) }
  before(:example) do
    login_with_omniauth
  end

  context "user with an api key and no main set" do
    before(:example) do
      user.api_keys.create( attributes_for(:api_key) )
      user.main_id = nil
    end

    scenario "user selects their main", :vcr do
      click_link "API Keys"
      select "Sicks", from: :user_main_id
      click_link_or_button "save"

      expect(page).to have_content "logged in as Sicks"
    end
  end
end
