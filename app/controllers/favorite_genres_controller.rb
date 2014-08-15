class FavoriteGenresController < ApplicationController
  before_action :user_logged_in?
  def index
    @genres               = Genre.all
    @user_favorite_genres = current_user.favorite_genres
    @user_genres          = current_user.genres
  end

  def create
    user = User.find params["user_id"]
    genres = params["genres"]
    genres.each_key do |id|
      value          = genres[id].to_i
      favorite_genre = user.favorite_genres.find_by_genre_id(id)
      if value == 1
        favorite_genre.delete if not favorite_genre.nil?
      elsif value != 1
        if favorite_genre.nil?
          user.favorite_genres.create genre_id: id, interest: value
        else
          favorite_genre.update_attributes interest: value
        end
      end
    end
    redirect_to movies_path, success: "Tus generos se guardaron :)"
  end
end
