require 'test_helper'

class StaticsControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get how" do
    get :how
    assert_response :success
  end

end
