class AdminsController < ApplicationController
  def index

  end

  def fetch_movies
    MoviesFactory.fetch schedules: params[:schedules]
  end
end
