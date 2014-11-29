class FavoriteMoviesController < ApplicationController
  
  def index
    @watchlist = MovieDecorator.build_with(current_user.movies.in_watchlist)
  end

  def create
    fav_movie = current_user.favorite_movies.new(favorite_movies_params)
    if fav_movie.save
      @movies = MovieDecorator.build_with(Movie.playing_now_for(current_user))
    end
  end

  def update
    fav_movie = current_user.favorite_movies.find_by(movie_id: favorite_movies_params["movie_id"])
    
    fav_movie.destroy if params["commit"] == "watchlist"
    fav_movie.update(favorite_movies_params) if params["commit"] == "seen"

    @watchlist = MovieDecorator.build_with(current_user.movies.in_watchlist)
  end

  private
  
    def favorite_movies_params
      params.require(:favorite_movie).permit(:movie_id, :seen, :review, :stars)
    end

end
