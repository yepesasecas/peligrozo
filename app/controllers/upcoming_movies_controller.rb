class UpcomingMoviesController < ApplicationController
  def show
    @movie_decorator = MovieDecorator.new(
      Movie.find_or_create_by(tmdb_id: params[:id]),
      current_user)
  end
end
