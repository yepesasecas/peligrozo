class UpcomingMoviesController < ApplicationController
  def show
    @movie = Movie.new(tmdb_id: params[:id]).details
    puts @movie
  end
end