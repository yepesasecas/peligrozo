class CreateMovieNightFriendships < ActiveRecord::Migration
  def change
    create_table :movie_night_friendships do |t|
      t.integer :movie_night_id      
      t.integer :friendship_id      

      t.timestamps
    end
  end
end
