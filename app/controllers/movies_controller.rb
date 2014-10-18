class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = Movie.upcoming
    @movies   = Movie.playing_now
  end

  def show
    @movie             = Movie.includes(:theaters).find params[:id]
    @favorite_theaters = current_user.favorite_theaters_by movie: @movie
    @movie_theaters    = @movie.theaters
    @schedule          = select_first_schedule_to_show
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update(movie_params)
      redirect_to admins_index_path, notice: "Se actualizo correctamente"
    else
      redirect_to admins_index_path, error: "No se pudo actualizo"
    end
  end

  private
  
    def movie_params
      params.require(:movie).permit(:tmdb_id, :trailer)
    end

    def select_first_schedule_to_show
      if @favorite_theaters.empty?
        @movie.schedules.find_by(theater_id: @movie.theaters.first.id)
      else
        @movie.schedules.find_by(theater_id: @favorite_theaters.first.id)
      end
    end

end
