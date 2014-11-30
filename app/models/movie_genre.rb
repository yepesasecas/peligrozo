class MovieGenre < ActiveRecord::Base

  belongs_to :movie
  belongs_to :genre

  validates_uniqueness_of :genre_id, scope: [:movie_id] 
end
