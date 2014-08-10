class UsersController < ApplicationController
  def index
  end

  def favorite_genres
    @genres = Genre.all
  end
end
