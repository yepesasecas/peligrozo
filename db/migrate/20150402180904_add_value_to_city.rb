class AddValueToCity < ActiveRecord::Migration
  def change
    add_column :cities, :value, :string
  end
end
