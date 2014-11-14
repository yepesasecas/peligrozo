require 'test_helper'

class EliminatedMovieTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :movie
end
