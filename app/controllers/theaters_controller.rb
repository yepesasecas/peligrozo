class TheatersController < ApplicationController
  before_action :user_logged_in?
  def index
  end

  def show
    @schedule = Schedule.where("movie_id = ? and theater_id = ?", params[:movie_id], params[:id]).first
    respond_to do |format|
      format.json  { render :json => @schedule.schedule_description.to_a }
    end
  end
end
