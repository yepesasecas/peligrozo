class AdminsController < ApplicationController
  before_action :user_logged_in?
  
  def index
    # @movies = Movie.playing_now
    @movies = Movie.with_no_trailer
  end

end
