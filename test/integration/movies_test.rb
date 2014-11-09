require 'test_helper'

class MoviesTest < ActionDispatch::IntegrationTest

  test "movies page should contain CARTELERA, COMING SOON and Sliders" do
    visit root_path
    
    sign_in_with_facebook
    configuration_steps
    
    within("body") do
      assert has_content?("CARTELERA"), "Cartelera should contain the word CARTELERA"
      assert has_content?("PROXIMAMENTE"), "Cartelera should contain the word PROXIMAMENTE"
    end
  end

end
