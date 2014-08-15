class CreateFavoriteTheaters < ActiveRecord::Migration
  def change
    create_table :favorite_theaters do |t|
      t.integer :theater_id
      t.integer :user_id

      t.timestamps
    end
  end
end
