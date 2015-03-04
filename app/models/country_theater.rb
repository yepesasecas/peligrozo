class CountryTheater < ActiveRecord::Base

  belongs_to :country
  belongs_to :theater
end
