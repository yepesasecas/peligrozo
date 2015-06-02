class DropMovieNightFriendship < ActiveRecord::Migration
  def change
    drop_table :movie_night_friendships
  end
end
