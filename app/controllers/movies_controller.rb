class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = Movie.upcoming
    @movies   = Movie.playing_now
  end

  def show
    movie            = Movie.includes(:theaters).find(params[:id])
    @movie_decorator = MovieDecorator.new(movie, current_user)
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

end
