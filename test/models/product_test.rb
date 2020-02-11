require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "价格有且大于0" do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end
end