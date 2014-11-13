class AddStateToFavoriteMovie < ActiveRecord::Migration
  def change
    add_column :favorite_movies, :state, :string
    add_index :favorite_movies, :state
  end
end
