class Genre < ActiveRecord::Base

  has_many :favorite_genres
  has_many :movie, through: :movie_genre
  has_many :movie_genres
end
