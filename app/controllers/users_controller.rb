class UsersController < ApplicationController
  before_action :user_logged_in?
  
  def history
    @watchlist = User.find(params["id"]).watchlist.includes(:movie).reverse
  end
end
