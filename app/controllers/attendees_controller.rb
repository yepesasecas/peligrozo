class AttendeesController < ApplicationController
  def create
    movie_night = MovieNight.find movie_night_id
    if current_user.friends_movie_nights.include? movie_night
      movie_night.users << current_user
      flash.notice = "Current User successfully added to movie night."
    else
      flash.notice = "Current User not allowed to join Movie Night"
    end
    redirect_to movie_nights_path
  end

  def destroy
    attendee = Attendee.where movie_night_id: movie_night_id, user: current_user
    if attendee
      attendee.destroy_all
      flash.notice = 'Current User was successfully removed from Movie Night'
    else
      flash.notice = 'Current user is not part of Movie Night'
    end
    redirect_to movie_nights_path
  end

  private
    def movie_night_id
      params.require(:movie_night_id)
    end
end
