class LandingController < ApplicationController
  
  def index
    # @now_playing = Tmdb::Movie.now_playing
    @upcoming = Fetch::Moviesdb.upcoming 
    @movies   = Movie.all
  end
end
