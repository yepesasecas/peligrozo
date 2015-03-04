class Theater < ActiveRecord::Base
  has_paper_trail

  has_one :country, through: :country_theater
  has_one :country_theater
  has_many :favorite_theaters
  has_many :movies, through: :schedules
  has_many :schedules
  has_many :users,  through: :favorite_theaters

  scope :in, -> (args) { joins(:country).where(countries: {code: args[:country_code]})}

  def to_s
    name
  end
end
