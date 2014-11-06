class FavoriteMoviesController < ApplicationController
  
  def index
    movies     = current_user.movies.in_watchlist
    @watchlist = MovieDecorator.build_with(movies)
  end

  def create
    fav_movie = current_user.favorite_movies.new(favorite_movies_params)
    if fav_movie.save
      @movies = MovieDecorator.build_with(Movie.playing_now.remove(current_user.movies.ids))
    end
  end

  def update
    fav_movie = current_user.favorite_movies.find_by(movie_id: favorite_movies_params["movie_id"])
    if fav_movie.destroy
      movies     = current_user.movies.in_watchlist
      @watchlist = MovieDecorator.build_with(movies)
    end
  end

  private
  
    def favorite_movies_params
      params.require(:favorite_movie).permit(:movie_id)
    end

end
