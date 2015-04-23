module OmniAuthTestHelper

  def login_with_omniauth( provider = :google_oauth2 )
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new( attributes_for( provider ) )
    visit "/auth/#{provider}"
  end
end

