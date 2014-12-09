class MoviesController < ApplicationController
  before_action :user_logged_in?, :user_first_time?
  
  def index
    @upcoming = MovieDecorator.build_with(Movie.upcoming_for(current_user))
    @movies   = MovieDecorator.build_with(Movie.playing_now_for(current_user))
  end

  def show
    movie            = Movie.includes(:theaters).find(params[:id])
    @movie_decorator = MovieDecorator.new(movie, current_user)
    @today           = Date.today.strftime("%-d/%-m/%Y")
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update(movie_params)
      @movie.update_genres
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
