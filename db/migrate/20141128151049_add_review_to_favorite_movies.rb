class AddReviewToFavoriteMovies < ActiveRecord::Migration
  def change
    add_column :favorite_movies, :review, :text
  end
end
