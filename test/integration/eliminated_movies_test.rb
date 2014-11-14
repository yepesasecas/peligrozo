require 'test_helper'

class EliminatedMoviesTest < ActionDispatch::IntegrationTest

  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = :selenium
  
    visit root_path
    setup_omniauth_test(:config_done)
    sign_in_with_facebook
  end

  test "As a User, I want to delete movies." do

     # Setup Movies Data
    user   = users(:one)
    movies = Movie.playing_now.remove(user.movies.ids)
    movie  = movies(:one)

    within("#playing-now-slider") do
      click_link movie.id
    end

    # Open Modal and click 'add to Watchlist'
    within(".modal") do
      assert has_button?("delete-movie-button"), "Modal should have 'delete movie' button"
      click_button("delete-movie-button")
    end

    assert_not has_link?(movie.id), "Movie Poster should dissapear from CARTELERA after 'deleting' movie"
    assert_includes user.eliminated_movies, EliminatedMovie.where(movie_id: movie.id, user_id: user.id).first, "User.eliminated_movies should contain deleted movie."
  end
end
