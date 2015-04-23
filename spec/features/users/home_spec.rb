require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  let!(:user) { create(:user) }
  before(:example) do
    login_with_omniauth
  end

  scenario 'User has no api keys', :vcr do
    user.api_keys.destroy_all
    click_link 'Home'
    expect(page).to have_content "an api key is required"
  end

  scenario 'User has api keys', :vcr do
    user.api_keys.create!( attributes_for(:api_key).except(:user_id) )
    click_link 'Home'
    expect(page).to have_content "DKP Index"
  end

end
