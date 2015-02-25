require 'test_helper'

class MovieDecoratorTest < ActiveSupport::TestCase

  test "decorator should extract trailer id from youtube url" do
    movie = Movie.create name: "Rey Leon", trailer: "https://www.youtube.com/watch?v=B8NPf8o9-bk"
    decorated_movie = MovieDecorator.new movie

    assert_equal "http://www.youtube.com/embed/B8NPf8o9-bk", decorated_movie.youtube, 
      "Decorator should extract trailer id from youtube url"
  end

  test "decorator should use trailer id when added correctly" do
    movie = Movie.create name: "Rey Leon", trailer: "B8NPf8o9-bk"
    decorated_movie = MovieDecorator.new movie

    assert_equal "http://www.youtube.com/embed/B8NPf8o9-bk", decorated_movie.youtube, 
      "Decorator should extract trailer id from youtube url"
  end
end
