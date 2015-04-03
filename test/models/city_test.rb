require 'test_helper'

class CityTest < ActiveSupport::TestCase
  
  context "a City" do
    should have_many :theaters
  end
end
