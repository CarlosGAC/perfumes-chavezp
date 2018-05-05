require 'test_helper'

class OrderDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_datum = order_data(:one)
  end

  test "should get index" do
    get order_data_url
    assert_response :success
  end

  test "should get new" do
    get new_order_datum_url
    assert_response :success
  end

  test "should create order_datum" do
    assert_difference('OrderDatum.count') do
      post order_data_url, params: { order_datum: { order_date: @order_datum.order_date } }
    end

    assert_redirected_to order_datum_url(OrderDatum.last)
  end

  test "should show order_datum" do
    get order_datum_url(@order_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_datum_url(@order_datum)
    assert_response :success
  end

  test "should update order_datum" do
    patch order_datum_url(@order_datum), params: { order_datum: { order_date: @order_datum.order_date } }
    assert_redirected_to order_datum_url(@order_datum)
  end

  test "should destroy order_datum" do
    assert_difference('OrderDatum.count', -1) do
      delete order_datum_url(@order_datum)
    end

    assert_redirected_to order_data_url
  end
end
