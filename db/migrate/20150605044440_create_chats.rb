class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :movie_night_id
      t.text :conversation

      t.timestamps null: false
    end
    add_index :chats, :movie_night_id
  end
end
