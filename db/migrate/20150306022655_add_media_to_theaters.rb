class AddMediaToTheaters < ActiveRecord::Migration
  def change
    add_column :theaters, :email, :string
    add_column :theaters, :facebook, :string
    add_column :theaters, :twitter, :string
  end
end
