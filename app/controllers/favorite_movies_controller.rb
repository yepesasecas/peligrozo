class FavoriteMoviesController < ApplicationController
  def index
    @watchlist = current_user.movies
    @upcoming  = Movie.upcoming 
  end

  def create
    id = favorite_movies_params[:movie_id]
    response = 
      if current_user.watchlist.find_by_movie_id(id)
        :ok
      else
        current_user.watchlist.create(movie_id: id)  
        :created
      end
    respond_to do |format|
      format.json  { render json: response}
    end
  end

  private
  def favorite_movies_params
    params.require(:movie).permit(:movie_id)
  end
end
