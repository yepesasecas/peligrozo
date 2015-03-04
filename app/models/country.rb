class Country < ActiveRecord::Base

  has_many :country_theaters, dependent: :destroy
  has_many :country_movies, dependent: :destroy
  has_many :movies, through: :country_movies
  has_many :theaters, through: :country_theaters
  has_many :users, through: :country_users
  has_many :country_users, dependent: :destroy
end
