class FavoriteMovie < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :movie

  scope :seen, ->{ where seen: true }
end
