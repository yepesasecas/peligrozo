class CreateEliminatedMovies < ActiveRecord::Migration
  def change
    create_table :eliminated_movies do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
    add_index :eliminated_movies, :user_id
    add_index :eliminated_movies, :movie_id
  end
end
