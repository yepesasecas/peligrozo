class AddIndexToMovies < ActiveRecord::Migration
  def change
    add_index(:movies, :id)
    add_index(:movies, :name)
    add_index(:movies, :tmdb_id)
    add_index(:movies, :state)
    add_index(:movies, :value)
  end
end
