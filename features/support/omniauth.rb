Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:google] = {
    provider: "google",
    uid: "123456789",
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
