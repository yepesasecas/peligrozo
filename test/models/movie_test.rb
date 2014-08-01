require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "get_movie_details before_create is getting tmdb_id" do
    movie = Movie.create name: "Rey Leon"
    assert_equal 8587, movie.tmdb_id, "tmdb_id is not the same."
  end
end
