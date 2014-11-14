class EliminatedMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def self.movies_ids
    map(&:movie_id)
  end
end
