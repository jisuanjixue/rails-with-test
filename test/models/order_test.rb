require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'order有确定的总数' do
    order = orders(:one)
    order.total = -1
    assert_not order.valid?
  end
end
