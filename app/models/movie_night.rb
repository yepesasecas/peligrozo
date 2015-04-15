class MovieNight < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :user
  belongs_to :movie
  belongs_to :schedule

  scope :seen, ->{ where seen: true }
end
