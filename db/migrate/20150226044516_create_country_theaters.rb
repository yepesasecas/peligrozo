class CreateCountryTheaters < ActiveRecord::Migration
  def change
    create_table :country_theaters do |t|
      t.integer :country_id
      t.integer :theater_id

      t.timestamps
    end
  end
end
