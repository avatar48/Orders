require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get orders_edit_url
    assert_response :success
  end

  test "should get list" do
    get orders_list_url
    assert_response :success
  end

end
