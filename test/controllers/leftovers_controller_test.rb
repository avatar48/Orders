require 'test_helper'

class LeftoversControllerTest < ActionDispatch::IntegrationTest
  test "should get send" do
    get leftovers_send_url
    assert_response :success
  end

end
