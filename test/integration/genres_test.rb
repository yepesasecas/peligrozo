require 'test_helper'

class GenresTest < ActionDispatch::IntegrationTest

  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = :selenium
    visit root_path
    
    setup_omniauth_test(:config_done)
    sign_in_with_facebook
    click_link "user-dropdown"
    click_link "GENEROS"
  end

  test "As a user, I can change my favorite genres" do 
    assert has_content?(genres(:one).name.upcase), 
      "'accion' should be displays as an option."
    assert has_content?(genres(:two).name.upcase),
      "'comedia' should be displays as an option."
  end

end
