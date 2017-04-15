require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get user" do
    get orders_user_url
    assert_response :success
  end

  test "should get invoice" do
    get orders_invoice_url
    assert_response :success
  end

end
