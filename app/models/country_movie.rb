class CountryMovie < ActiveRecord::Base

  belongs_to :movie
  belongs_to :country
end
