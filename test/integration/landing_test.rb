require 'test_helper'

class LandingTest < ActionDispatch::IntegrationTest
  
  def setup
    visit root_path
  end

  test "anyone can go to Landing page." do
    assert_equal landing_index_path, current_path, "root path doesnt redirect to landing_index_path"

    within("h1") do
      assert has_content?("CONTROLA LOS CINES"), "landing should contain CONTROLA LOS CINES"
    end
  end

  test "first login through Landing Page with user configuration" do
    user = users(:two)
    
    setup_omniauth_test(:at_genres)
    sign_in_with_facebook
    assert_equal user_favorite_genres_path(user), current_path, "after clicking BOTON FACEBOOK, should go to favorite genres"
    
    click_link "skip"
    assert_equal user_favorite_theaters_path(user), current_path, "after clicking OMITIR, should go to favorite theaters"
    
    click_link "skip"
    assert_equal movies_path, current_path, "after clicking OMITIR, should go to CARTELERA"
  end
end
