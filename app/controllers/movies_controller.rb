class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = Movie.upcoming 
    @movies   = Movie.playing_now
  end

  def show
    @movie = Movie.includes(:theaters).find params[:id]
    @favorite_theaters = current_user.find_favorite_theaters @movie if current_user
    @response = {
      movie: @movie, 
      theaters: @movie.theaters, 
      favorite_theaters: @favorite_theaters,
      in_watchlist: current_user.movies.include?(@movie)
    }
    respond_to do |format|
      format.json  { render :json => @response }
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:id)
  end
end
