module OmniAuthTestHelper

  def mock_auth_setup
    if Rails.env.test?
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123456789'
      })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
  end
end

