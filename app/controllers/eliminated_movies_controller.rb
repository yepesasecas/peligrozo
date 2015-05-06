class EliminatedMoviesController < ApplicationController

  def create
    favorite_movie = current_user.watchlist.find_by(movie_id: eliminated_movies_params[:movie_id])
    unless favorite_movie.nil?
      favorite_movie.destroy
    end

    eliminated_movie = current_user.eliminated_movies.new(eliminated_movies_params)
    if eliminated_movie.save
      @movies    = MovieDecorator.build_with(Movie.in(country_code: current_country.code).playing_now_for(current_user))
      @upcoming  = MovieDecorator.build_with(Movie.upcoming_for(current_user))
      @watchlist = MovieDecorator.build_with(current_user.movies.in_watchlist)
    end

  end

  private

    def eliminated_movies_params
      params.require(:eliminated_movie).permit(:movie_id, :tmdb_id)
    end

end
