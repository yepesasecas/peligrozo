require 'test_helper'

class LandingTest < ActionDispatch::IntegrationTest
  
  test "anyone can go to Landing page." do
    visit root_path
    assert_equal landing_index_path, current_path, "root path doesnt redirect to landing_index_path"

    within("h1") do
      assert has_content?("CONTROLA LOS CINES"), "landing should contain CONTROLA LOS CINES"
    end
  end

  test "first login through Landing Page with first configuration" do
    visit root_path
    
    sign_in_with_facebook
    configuration_steps
  end
end
