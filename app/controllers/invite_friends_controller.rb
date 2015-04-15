class InviteFriendsController < ApplicationController
  def index
    @friends = current_user.friends_facebook
    @friendships = current_user.friendships.pluck :uid
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
    saved = current_user.friendships.find_by_uid(favorite_friends_params[:uid])
    saved.delete if saved
    respond_to do |format|
      format.json  { render :json => saved}
    end
  end

  private
  def favorite_friends_params
    params.require(:friend).permit(:uid)
  end
end