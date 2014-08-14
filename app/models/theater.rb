class Theater < ActiveRecord::Base
  has_many :schedules
  has_many :favorite_theaters
  has_many :movies, through: :schedules
  has_many :users,  through: :favorite_theaters
end
