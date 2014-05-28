require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get close" do
    get :close
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
