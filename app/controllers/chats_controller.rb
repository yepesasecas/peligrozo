class ChatsController < ApplicationController
  def create
    movie_night = MovieNight.find(params[:movie_night_id])
    chat = movie_night.chat!
    if movie_night
      chat.add_message owner: current_user.name, conversation: chat_params[:conversation]
    end

    redirect_to movie_nights_path
  end

  def update
    movie_night = MovieNight.find(params[:movie_night_id])
    chat = movie_night.chat!
    if movie_night
      chat.add_message owner: current_user.name, conversation: chat_params[:conversation]
    end

    redirect_to movie_nights_path
  end

  private
  def chat_params
    params.require(:chat).permit(:conversation)
  end
end
