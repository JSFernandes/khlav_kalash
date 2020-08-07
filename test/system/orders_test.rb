require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "creating a Order" do
    visit root_url

    select @order.country, from: "order_country"
    fill_in "Email address", with: @order.email_address
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    fill_in "Postal code", with: @order.postal_code
    click_on "Pay $2.99"

    assert_text "Order was successfully created"
  end

  test "creating an Order with invalid email address" do
    visit root_url

    select @order.country, from: "order_country"
    fill_in "Email address", with: "not_an_email"
    fill_in "First name", with: @order.first_name
    fill_in "Last name", with: @order.last_name
    click_on "Pay $2.99"

    assert_text "Email address is invalid"
  end

  test "creating an Order with missing mandatory fields" do
    visit root_url

    click_on "Pay $2.99"

    assert_text "First name can't be blank"
    assert_text "Postal code can't be blank"
    assert_text "Email address can't be blank"
  end
end
