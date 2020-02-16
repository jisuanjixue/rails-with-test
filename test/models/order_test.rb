# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'order有确定的总数' do
    order = orders(:one)
    order.total = -1
    assert_not order.valid?
  end

  test '创建2个订单' do
    @order.build_placements_with_product_ids_and_quantities [
      { product_id: @product1.id, quantity: 2 },
      { product_id: @product2.id, quantity: 3 }
    ]
    assert_difference('Placement.count', 2) do
      @order.save
    end
  end
end
