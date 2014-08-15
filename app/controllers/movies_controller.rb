class MoviesController < ApplicationController

  def index
    @upcoming = Movie.upcoming 
    @movies   = Movie.playing_now
  end

  def show
    @movie             = Movie.includes(:theaters).find params[:id]
    @favorite_theaters = current_user.set_favorite_theaters @movie if current_user
    @response = {movie: @movie, 
              theaters: @movie.theaters, 
     favorite_theaters: @favorite_theaters}
    respond_to do |format|
      format.json  { render :json => @response }
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:id)
  end
end
