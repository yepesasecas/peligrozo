class ChangeMovieValueToString < ActiveRecord::Migration
  def change
    change_column :movies, :value, :string
  end
end
