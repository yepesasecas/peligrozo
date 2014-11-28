class FavoriteMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  scope :seen, ->{ where seen: true }
end
