class CreateCountryMovies < ActiveRecord::Migration
  def change
    create_table :country_movies do |t|
      t.integer :movie_id
      t.integer :country_id

      t.timestamps
    end
  end
end
