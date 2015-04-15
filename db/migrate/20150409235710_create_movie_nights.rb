class CreateMovieNights < ActiveRecord::Migration
  def change
    create_table :movie_nights do |t|
      t.integer :user_id      
      t.integer :movie_id      
      t.integer :schedules_id      

      t.timestamps
    end
  end
end
