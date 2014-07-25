class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
