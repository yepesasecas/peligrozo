class FavoriteMoviesController < ApplicationController
  
  def index
    movies = current_user.movies.in_watchlist
    @watchlist = MovieDecorator.build_with(movies)
  end

  def create
    id    = favorite_movies_params[:movie_id]
    movie = current_user.watchlist.find_by_movie_id(id)
    if movie
      response = :bad_request
    else
      current_user.watchlist.create(movie_id: id)  
      response = :ok
    end
    respond_to do |format|
      format.json  { render json: response}
    end
  end

  def delete
    id = favorite_movies_params[:movie_id]
    movie = current_user.watchlist.find_by_movie_id(id)
    if movie
      movie.delete
      response = :ok
    else
      response = :bad_request
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
