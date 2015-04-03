require 'test_helper'

class CountryTest < ActiveSupport::TestCase

  context "a Country" do
    should have_many :cities
    should have_many :movies
    should have_many :theaters
    should have_many :users
  end
end
