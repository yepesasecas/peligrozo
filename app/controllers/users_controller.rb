class UsersController < ApplicationController
  before_action :user_logged_in?
  
  def history
    @watchlist = User.find(params["id"]).watchlist.includes(movie:[:genres]).reverse
  end
end
