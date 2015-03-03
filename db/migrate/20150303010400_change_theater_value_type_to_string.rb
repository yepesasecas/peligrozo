class ChangeTheaterValueTypeToString < ActiveRecord::Migration
  def change
    change_column :theaters, :value, :string
  end
end
