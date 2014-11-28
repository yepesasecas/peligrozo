class AddSeenToFavoriteMovies < ActiveRecord::Migration
  def change
    add_column :favorite_movies, :seen, :boolean, default: false
    add_index :favorite_movies, :seen
  end
end
