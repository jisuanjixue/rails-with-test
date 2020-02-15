# frozen_string_literal: true

require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test '无订单' do
    get api_v1_orders_url, as: :json
    assert_response :forbidden
  end

  test '订单展示' do
    get api_v1_orders_url,
        headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) },
        as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @order.user.orders.count, json_response['data'].count
  end
end
