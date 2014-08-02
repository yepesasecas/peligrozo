class AddStateToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :state, :string
  end
end
