class MovieNightsController < ApplicationController
	def index
    @movienight = MovieDecorator.build_with(current_user.movienights.in_movienight)
    @movienightfriends = MovieDecorator.build_with(current_user.getmovies_by_friends)   

  end

  def create
    mov_night = current_user.movie_nights.new(movie_nights_params)
    if mov_night.save
    	@movies = MovieDecorator.build_with(
        Movie.in(country_code: current_country.code)
             .playing_now_for(current_user)
      )
    end
  end

  def update
    mov_night = current_user.movie_nights.find_by(movie_id: movie_nights_params["movie_id"])
    
    mov_night.destroy if params["commit"] == "movienight"
    mov_night.update(movie_nights_params) if params["commit"] == "seen"

    @movienight = MovieDecorator.build_with(current_user.movies.in_movienight)
  end

  def show
    
  end

  private  
    def movie_nights_params
      params.require(:movie_night).permit(:movie_id)
    end
end
