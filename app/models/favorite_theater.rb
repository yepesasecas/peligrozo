class FavoriteTheater < ActiveRecord::Base
  belongs_to :user
  belongs_to :theater
end
