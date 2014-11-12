class AdminsController < ApplicationController
  before_action :user_logged_in?, :admin_logged_in?
  
  def index
    @movies = Movie.with_no_trailer
  end
  
end
