class MovieNightsController < ApplicationController
  def index
    @movie_nights = current_user.user_movie_nights
    @friends_movie_nights = current_user.friends_movie_nights
  end

  def create
    mov_night = current_user.user_movie_nights.new(movie_nights_params)
    if mov_night.save
    	@movies = MovieDecorator.build_with(
        Movie.in(country_code: current_country.code).playing_now_for(current_user))
    end
  end

  def update
    mov_night = current_user.user_movie_nights.find_by(movie_id: movie_nights_params["movie_id"])

    mov_night.destroy if params["commit"] == "movienight"
    mov_night.update(movie_nights_params) if params["commit"] == "seen"

    @movienight = MovieDecorator.build_with(current_user.movies.in_movienight)
  end

  def destroy
    movie_night = MovieNight.find params[:id]

    if current_user == movie_night.owner
      movie_night.destroy
      flash.notice = 'Movie Night successfully destroyed.'
    else
      flash.notice = 'Only the owner can destroy Movie Night'
    end
    redirect_to movie_nights_path
  end

  private
    def movie_nights_params
      params.require(:movie_night).permit(:movie_id)
    end
end
