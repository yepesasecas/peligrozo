require 'test_helper'

class TheatersTest < ActionDispatch::IntegrationTest

  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = :selenium
    visit root_path
    
    setup_omniauth_test(:config_done)
    sign_in_with_facebook
    click_link "user-dropdown"
    click_link "TUS CINES"
  end

  test "As a user, I can change my favorite theaters" do 
    assert has_content?("CINÉPOLIS SANTA ANITA"), 
      "'Tus Cines' should have one theater."
  end
  
end
