class CreateCountryUsers < ActiveRecord::Migration
  def change
    create_table :country_users do |t|
      t.integer :country_id
      t.integer :user_id

      t.timestamps
    end
  end
end
