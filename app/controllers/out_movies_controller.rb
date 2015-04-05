class OutMoviesController < ApplicationController

  def show
    @movie_decorator = MovieDecorator.new(Movie.find(params[:id]), current_user)
  end
end
