OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
           :scope => 'publish_actions, email, user_friends'
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: 'facebook',
  uid: '123545',
  info: {
    first_name: "Gaius",
    last_name:  "Baltar",
    email:      "test@example.com"
  },
  credentials: {
    token: "123456",
    expires_at: Time.now + 1.week
  },
  extra: {
    raw_info: {
      gender: 'male'
    }
  }
})