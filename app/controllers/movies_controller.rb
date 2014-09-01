class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = Movie.upcoming 
    @movies   = Movie.playing_now
  end

  def show
    @movie             = Movie.includes(:theaters).find params[:id]
    @favorite_theaters = current_user.find_favorite_theaters_by_movie @movie
    @schedule          = select_first_schedule
  end

  private
    def movie_params
      params.require(:movie).permit(:id)
    end

    def select_first_schedule
      if @favorite_theaters.empty?
        @movie.schedules.find_by theater_id: @movie.theaters.first.id
      else
        @movie.schedules.find_by theater_id: @favorite_theaters.first.id
      end
    end

end
