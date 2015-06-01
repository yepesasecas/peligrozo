class InviteFriendsController < ApplicationController
  def index
    @facebook_friends = current_user.facebook.friends
    @friends = current_user.friends
		@steps = true if params[:steps] == "true"
		#current_user.feed_facebook
  end

  def create
  	saved = current_user.friendships.create(favorite_friends_params)
  	#current_user.feed_facebook
    respond_to do |format|
      format.json  { render :json => saved }
    end
  end

  def delete
    saved = current_user.friendships.find_by(favorite_friends_params)
    saved.delete if saved
    respond_to do |format|
      format.json  { render :json => saved}
    end
  end

  private
  def favorite_friends_params
    params.require(:friend).permit(:friend_id)
  end
end
