class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :movie_night_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :attendees, :movie_night_id
    add_index :attendees, :user_id
  end
end
