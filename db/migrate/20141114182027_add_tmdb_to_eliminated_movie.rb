class AddTmdbToEliminatedMovie < ActiveRecord::Migration
  def change
    add_column :eliminated_movies, :tmdb_id, :integer
    add_index :eliminated_movies, :tmdb_id
  end
end
