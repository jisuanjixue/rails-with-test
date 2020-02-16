# frozen_string_literal: true

require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @order_params = { order: {
      product_ids_and_quantities: [
        { product_id: products(:one).id, quantity: 2 },
        { product_id: products(:two).id, quantity: 3 },
      ]
    } }
  end

  test '没登录不能新建订单' do
      assert_no_difference('Order.count') do
      post api_v1_orders_url, params: @order_params, as: :json
    end
    assert_response :forbidden
  end

  test 'should create order with two products and placements' do
    assert_difference('Order.count', 1) do
      assert_difference('Placement.count', 2) do
        post api_v1_orders_url, params: @order_params, as: :json
             headers:{ Authorization: JsonWebToken.encode(user_id: @order.user_id) },
      end
    end 
    assert_response :created
  end

  test '无订单' do
    get api_v1_orders_url, as: :json
    assert_response :forbidden
  end

  test '订单展示' do
    get api_v1_orders_url(@order),
        headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) },
        as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    include_product_attr = json_response['included'][0]['attributes']
    assert_equal @order.products.first.title, include_product_attr['title']
  end
end
