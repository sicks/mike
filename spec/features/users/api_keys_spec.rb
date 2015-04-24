require 'rails_helper'

RSpec.feature 'API Key Management' do
  let!(:user) { create(:user) }
  let(:api_key) { attributes_for(:api_key) }

  before(:example) do
    login_with_omniauth
  end

  context 'user has no api keys' do
    let(:api_key) { attributes_for(:api_key) }
    before(:example) do
      user.api_keys.destroy_all
    end

    scenario 'user adds an api key', :vcr do
      click_link "API Keys"
      fill_in 'Key', with: api_key[:key_id]
      fill_in 'Vcode', with: api_key[:vcode]
      click_link_or_button 'save'
      expect(page).to have_content "add API Key success"
    end
  end

  context 'user has API keys' do
    before(:example) do
      user.api_keys.create( api_key )
      user.api_keys.create( api_key )
    end

    scenario 'user views api keys list', :vcr do
      click_link "API Keys"
      expect(page).to have_css('div.api_key', count: user.api_keys.count)
    end

    scenario 'user adds another api key', :vcr do
      click_link 'API Keys'
      click_link 'new'
      fill_in 'Key', with: api_key[:key_id]
      fill_in 'Vcode', with: api_key[:vcode]
      click_link_or_button 'save'
      expect(page).to have_content "add API Key success"
    end

    scenario 'user deletes api key', :vcr do
      click_link 'API Keys'
      first("div.api_key").click_link 'delete'

      expect(page).to have_content "delete API Key success"
    end
  end
end

