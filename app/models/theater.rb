class Theater < ActiveRecord::Base
has_many :schedules
has_many :movies, through: :schedules
end
