class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = Movie.upcoming
    @movies   = Movie.playing_now
  end

  def show
    movie              = Movie.includes(:theaters).find(params[:id])
    @movie_decorator   = MovieDecorator.new(movie)
    @favorite_theaters = current_user.favorite_theaters_by(movie: @movie_decorator)
    @movie_theaters    = @movie_decorator.theaters
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
        @movie_decorator.schedules.find_by(theater_id: @movie_decorator.theaters.first.id)
      else
        @movie_decorator.schedules.find_by(theater_id: @favorite_theaters.first.id)
      end
    end

end
