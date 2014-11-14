class FavoriteMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  state_machine :state, initial: :to_watch do

    event :watch do
      transition from: :to_watch, to: :watched
    end
  
  end

end
