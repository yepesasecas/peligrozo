class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie_night
end
