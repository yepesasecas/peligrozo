require 'test_helper'

class MoviesTest < ActionDispatch::IntegrationTest

  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = :selenium
    visit root_path
    
    setup_omniauth_test(:config_done)
    sign_in_with_facebook
  end

  test "movies page should contain CARTELERA, COMING SOON" do
    within("body") do
      assert has_content?("CARTELERA"), "Cartelera should contain the word CARTELERA"
      assert has_content?("PROXIMAMENTE"), "Cartelera should contain the word PROXIMAMENTE"
    end
  end

  test "As a User, I want movies to disappear from CARTELERA when added to watchlist" do
    # Setup Movies Data
    movie = movies(:one)
    movies = Movie.playing_now.remove(users(:one).movies.ids)
    assert_includes movies, movie, "movies should contain atleast one movie to Test CARTELERA Slider"

    # Verify Cartelera Slider and click Movie Poster
    within("#playing-now-slider") do
      assert has_css?(".slider"), "CARTELLERA Should have a .slider css class"
      
      assert has_link?(movie.id), "CARTELLERA Slider should have one poster movie link."
      click_link movie.id
    end

    # Open Modal and click 'add to Watchlist'
    assert has_selector?(".modal"), "Should open the modal, after clicking a movie"
    within(".modal") do
      assert has_button?("watchlist-button"), "Modal should have 'Add To Watchlist' button"
      click_button("watchlist-button")
    end

    #Verify modal and 'Movie poster' disappears
    assert_not has_selector?(".modal"), "Modal should disappear after adding movie to watchlist"
    assert_not has_link?(movie.id), "Movie Poster should dissapear from CARTELERA after adding it to 'Watchlist'"
  end

end
