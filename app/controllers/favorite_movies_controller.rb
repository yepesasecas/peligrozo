class FavoriteMoviesController < ApplicationController
  def index
    @watchlist = current_user.movies
    @upcoming  = Movie.upcoming 
  end

  def create
    current_user.watchlist.create movie_id: favorite_movies_params[:movie_id]
    respond_to do |format|
      format.json  { render json: :success }
    end
  end

  private
  def favorite_movies_params
    params.require(:movie).permit(:movie_id)
  end
end
