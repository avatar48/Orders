require 'test_helper'

class DocumetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get documets_show_url
    assert_response :success
  end

end
