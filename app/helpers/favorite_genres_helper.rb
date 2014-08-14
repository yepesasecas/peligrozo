module FavoriteGenresHelper
  def genre_interest?(args=[])
    genre       = args[:genre]
    user_genres = args[:user_genres]
    value       = args[:value]
    return true if not user_genres.include? genre and value == 1
    if user_genres.include? genre and current_user.favorite_genres.find_by_genre_id(genre.id).interest == value
      true
    else
      false
    end
  end
end
