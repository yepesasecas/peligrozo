require 'test_helper'

class WatchlistTest < ActionDispatch::IntegrationTest

  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = :selenium
    visit root_path
    
    setup_omniauth_test(:config_done)
    sign_in_with_facebook
    click_link "WATCHLIST"
  end

  test "As a User in Watchlist, I see a slider with all my favorite movies"  do
    user   = users(:one)
    movies = user.movies.in_watchlist
    movie  = movies.first
    
    assert_includes movies, movie, 
      "User should contain one favorite movie in his Watchlist"

    assert has_selector?("#watchlist-slider"), 
      "Should have #watchlist-slider"
    
    within("#watchlist-slider") do
      assert has_link?(movie.id), 
        "Movie poster link should appear in Watchlist"
      click_link(movie.id)
    end

    # Open Modal and click 'add to Watchlist'
    assert has_selector?(".modal"), 
      "Should open the modal, after clicking a movie"
    
    within(".modal") do
      assert has_button?("watchlist-button"), 
        "Modal should have 'Remove from Watchlist' button"
      click_button("watchlist-button")
    end

    #Verify modal and 'Movie poster' disappears
    # assert_not find(".modal").visible?, 
    #   "Modal should disappear after removing movie from watchlist"
    assert_not has_link?(movie.id), 
      "Movie Poster should dissapear from WATCHLIST after removing it from 'Watchlist'"
  end

end
