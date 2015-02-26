class Country < ActiveRecord::Base

  has_many :country_theaters
  has_many :country_movies
  has_many :movies, through: :country_movies
  has_many :theaters, through: :country_theaters
  has_many :users, through: :country_users
  has_many :country_users
end
