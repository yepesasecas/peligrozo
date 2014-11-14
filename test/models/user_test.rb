require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "a User" do 
    should have_many :eliminated_movies
  end
end
