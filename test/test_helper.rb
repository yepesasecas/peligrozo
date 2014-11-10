ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'database_cleaner'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  DatabaseCleaner.strategy = :transaction

  def sign_in_with_facebook
    click_link "Boton facebook"
  end

  def setup_omniauth_test(status)
    user = case status
    when :config_done then users(:one)
    when :at_genres then users(:two)
    end

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: user.uid,
      info: {
        first_name: "Gaius",
        last_name:  "Baltar",
        email:      "test@example.com"
      },
      credentials: {
        token:      "123456",
        expires_at: Time.now + 1.week
      },
      extra: {
        raw_info: {
          gender: 'male'
        }
      }
    })
  end

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
