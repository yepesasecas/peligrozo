require 'test_helper'

class FetchTest < ActiveSupport::TestCase
  test "Fetch::Perucom.get_movies" do
    assert Fetch::Perucom.get_movies(1) != [], "Module Perucom is not fetching movies"
  end

  test "Fetch::Perucom.get_theaters" do
    assert Fetch::Perucom.get_theaters != [], "Module Perucom is not fetching theaters"
  end

  test "Fetch::Perucom.create_schedules" do
    movies   = Movie.all
    theaters = Theater.all
    Fetch::Perucom.create_schedules(movies, theaters)
    assert_equal 1, Theater.count, "Module Perucom is not creating schedules"
  end

  test "Fetch::moviesdb.search by name" do
    movie = Fetch::Moviesdb.search("Rey Leon")[0]
    assert_equal 8587, movie.id, "Module moviesdb is not searching movies by name"
  end
end
