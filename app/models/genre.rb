class Genre < ActiveRecord::Base
  #has_paper_trail

  has_many :favorite_genres
  # has_many :movie, through: :movie_genre
  has_many :movie_genres
  # has_many :users, through: :favorite_genres
end
