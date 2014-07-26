class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :movie_id
      t.integer :theater_id
      t.string :description
      t.string :price

      t.timestamps
    end
  end
end
