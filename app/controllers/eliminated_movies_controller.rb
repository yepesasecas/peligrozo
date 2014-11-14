class EliminatedMoviesController < ApplicationController

  def create
    eliminate_movie = current_user.eliminated_movies.new(eliminated_movies_params)
    if eliminate_movie.save
      @movies = MovieDecorator.build_with(Movie.playing_now_for(current_user))
    end
  end

  private

    def eliminated_movies_params
      params.require(:eliminated_movie).permit(:movie_id)
    end

end
