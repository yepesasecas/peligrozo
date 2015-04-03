class Theater < ActiveRecord::Base
  has_paper_trail

  belongs_to :city

  has_one :country, through: :country_theater
  has_one :country_theater, dependent: :destroy
  has_many :favorite_theaters, dependent: :destroy
  has_many :movies, through: :schedules
  has_many :schedules, dependent: :destroy
  has_many :users,  through: :favorite_theaters

  scope :in, -> (args) { joins(:country).where(countries: {code: args[:country_code]})}

  def to_s
    name
  end
end
