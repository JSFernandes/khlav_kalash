require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  def auth_headers
    {"Authorization" => "Basic #{Base64.encode64('admin:password')}"}
  end

  test "should get index" do
    get orders_url, headers: auth_headers
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: {
        order: {
          amount_cents: @order.amount_cents,
          country: @order.country,
          email_address: @order.email_address,
          first_name: @order.first_name,
          last_name: @order.last_name,
          postal_code: @order.postal_code,
        }
      }
    end

    assert_redirected_to new_payment_url(order_number: Order.last.number)
  end

  test "should show order" do
    get order_url(@order), headers: auth_headers
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order), headers: auth_headers
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), headers: auth_headers, params: { order: { amount_cents: @order.amount_cents, country: @order.country, email_address: @order.email_address, first_name: @order.first_name, last_name: @order.last_name } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order), headers: auth_headers
    end

    assert_redirected_to orders_url
  end
end
