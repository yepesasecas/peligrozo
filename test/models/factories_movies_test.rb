require 'test_helper'

class FactoriesMoviesTest < ActiveSupport::TestCase

  def setup
    Sources::Manager.stubs(:fetch_movies).returns(movie_demo)
    Factories::Movies.update

    @movie = Movie.last
  end

  test "Factories::Movies.update method is inserting right data for the first time" do

    assert_equal "En El Bosque", @movie.name, 
      "Movie's last name should be En el bosque"
    assert_equal 1, @movie.schedules.count, 
      "Movie should contain one schedule"
    assert_equal "En el bosque [14][S] 9:30", @movie.schedules.first.description, 
      "Movie's Schedule's description is not the one on the Data example"
    assert_equal 1, @movie.theaters.count, 
      "Movie should contain one theater"
    assert_equal "CINEPLANET PRIMAVERA", @movie.theaters.first.name, 
      "Movie's Theater's name is not the one on the Data example"
  end

  test "Factories::Movies.update method is inserting right data for  the second time" do
    Sources::Manager.stubs(:fetch_movies).returns(movie_demo_two)
    Factories::Movies.update
    
    assert_equal "En El Bosque", @movie.name, 
      "Movie's last name should be En el bosque"
    assert_equal 1, @movie.schedules.count, 
      "Movie should contain one schedule"
    assert_equal "En el bosque [14][S] 9:30", @movie.schedules.first.description, 
      "Movie's Schedule's description is not the one on the Data example"
    assert_equal 1, @movie.theaters.count, 
      "Movie should contain one theater"
    assert_equal "CINEPLANET SALAVERRY", @movie.theaters.first.name, 
      "Movie's Theater's name is not the one on the Data example"
  end
end