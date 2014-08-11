class CreateFavoriteGenres < ActiveRecord::Migration
  def change
    create_table :favorite_genres do |t|
      t.integer :user_id
      t.integer :genre_id
      t.integer :interest

      t.timestamps
    end
  end
end
