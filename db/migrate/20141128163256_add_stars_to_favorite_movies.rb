class AddStarsToFavoriteMovies < ActiveRecord::Migration
  def change
    add_column :favorite_movies, :stars, :integer
  end
end
