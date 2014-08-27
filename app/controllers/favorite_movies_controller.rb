class FavoriteMoviesController < ApplicationController
  def index
    @watchlist = current_user.watchlist
    @upcoming  = Movie.upcoming 
  end
end
