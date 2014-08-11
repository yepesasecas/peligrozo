class FavoriteGenresController < ApplicationController
  def index
    @genres = Genre.all.limit 9
  end

  def create
    genres = params["genres"]
    p genres
    genres.each_key do |id|
      value = genres[id].to_i
      FavoriteGenre.create(user_id: params["user_id"], genre_id: id, interest: value) if value != 1
    end
  end
end
