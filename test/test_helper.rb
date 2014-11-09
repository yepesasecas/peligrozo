ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_with_facebook
    click_link "Boton facebook"
  end

  def configuration_steps
    assert_equal user_favorite_genres_path("980190963"), current_path, "after clicking BOTON FACEBOOK, should go to favorite genres"
    
    click_link "skip"
    assert_equal user_favorite_theaters_path("980190963"), current_path, "after clicking OMITIR, should go to favorite theaters"
    
    click_link "skip"
    assert_equal movies_path, current_path, "after clicking OMITIR, should go to CARTELERA"
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
