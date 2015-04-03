class FavoriteTheatersController < ApplicationController
  before_action :user_logged_in?

  def index
    @theaters = Theater.includes(:city).in(country_code: current_country.code)
    @favorite_theaters = current_user.theaters.in(country_code: current_country.code)
    @steps = true if params[:steps] == "true"
  end

  def create
    saved = current_user.favorite_theaters.create(favorite_theaters_params) 
    respond_to do |format|
      format.json  { render :json => saved }
    end
  end

  def delete
    saved = current_user.favorite_theaters.find_by_theater_id(favorite_theaters_params[:theater_id])
    saved.delete if saved
    respond_to do |format|
      format.json  { render :json => saved}
    end
  end

  private
  def favorite_theaters_params
    params.require(:theater).permit(:theater_id)
  end

end
