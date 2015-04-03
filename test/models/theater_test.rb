require 'test_helper'

class TheaterTest < ActiveSupport::TestCase

  context "a Theater" do
    should belong_to :city
  end
end
