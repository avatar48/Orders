require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get invoices_list_url
    assert_response :success
  end

end
