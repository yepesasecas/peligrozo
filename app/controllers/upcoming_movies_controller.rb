class UpcomingMoviesController < ApplicationController
  def show
    movie            = Movie.find_or_create_by(tmdb_id: params[:id])
    @movie_decorator = MovieDecorator.new(movie, current_user)
  end
end