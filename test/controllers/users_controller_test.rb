require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get favorite_genres" do
    get :favorite_genres
    assert_response :success
  end

end
