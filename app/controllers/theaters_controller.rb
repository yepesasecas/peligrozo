class TheatersController < ApplicationController
  def index
  end

  def show
    @schedule = Schedule.where("movie_id = ? and theater_id = ?", params[:movie_id], params[:id])
    respond_to do |format|
      format.json  { render :json => @schedule }
    end
  end
end
