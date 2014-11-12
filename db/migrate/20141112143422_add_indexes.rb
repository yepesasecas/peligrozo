class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:favorite_genres, :user_id)
    add_index(:favorite_genres, :genre_id)

    add_index(:favorite_movies, :user_id)
    add_index(:favorite_movies, :movie_id)

    add_index(:favorite_theaters, :user_id)
    add_index(:favorite_theaters, :theater_id)

    add_index(:genres, :id)
    add_index(:genres, :name)
    add_index(:genres, :tmdb_id)

    add_index(:schedules, :id)
    add_index(:schedules, :movie_id)
    add_index(:schedules, :theater_id)

    add_index(:theaters, :id)
    add_index(:theaters, :name)

    add_index(:users, :id)    
    add_index(:users, :uid)    
  end

end
