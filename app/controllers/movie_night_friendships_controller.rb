class MovieNightFriendshipsController < ApplicationController
  def index

  end


  def create
		p "movie night id codigo"
		p params[:movie_id]
  	#MovieNightFriendship.create(movie_night_id: 1, friendship_id: 3)
  	#mov_night_fr = current_user.movie_night_friends.new(movie_night_id: 1, friendship_id: 3)
    #if mov_night_fr.save
    #end
  end


  def new
  	
  end

  


end
