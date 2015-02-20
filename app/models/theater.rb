class Theater < ActiveRecord::Base
  has_paper_trail

  has_many :schedules
  has_many :favorite_theaters
  has_many :movies, through: :schedules
  has_many :users,  through: :favorite_theaters

  def to_s
    name
  end
end
