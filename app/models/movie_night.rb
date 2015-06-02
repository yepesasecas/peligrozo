class MovieNight < ActiveRecord::Base
  has_paper_trail

  has_many :attendees
  has_many :users, through: :attendees, source: :user

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :movie
  belongs_to :schedule

  scope :seen, ->{ where seen: true }
end
