class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :value
      t.text :overview, limit: false
      t.string :poster_path
      t.date :release_date
      t.integer :tmdb_id

      t.timestamps
    end
  end
end
