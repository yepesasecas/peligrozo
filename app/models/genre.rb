class Genre < ActiveRecord::Base
  has_many :favorite_genres
end
