class AddCityToTheaters < ActiveRecord::Migration
  def change
    add_column :theaters, :city_id, :integer
  end
end
