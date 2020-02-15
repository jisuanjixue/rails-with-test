require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "价格有且大于0" do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test "通过产品名称查询" do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test '通过产品名称查询并归类' do
    assert_equal [products(:another_tv), products(:one)], Product.filter_by_title('tv').sort
  end

  test '大于200过滤价格并排序' do
    assert_equal [products(:two), products(:one)],
    Product .above_or_equal_to_price(200).sort
  end

  test '小于200过滤价格并排序' do
    assert_equal [products(:another_tv)], 
    Product .below_or_equal_to_price(200).sort
  end

  test '过滤 "videogame" 和价格小于 "100"' do
    search_hash = { keyword: 'videogame', min_price: 100 }
    assert Product.search(search_hash).empty? 
  end

  test '查询带有TV关键字的产品' do
    search_hash = { keyword: 'tv', min_price: 50, max_price: 150 }
    assert_equal [products(:another_tv)], Product.search(search_hash)
  end

  test '获取全部产品，默认不传参数' do
    assert_equal Product.all.to_a, Product.search({})
  end

  test '通过产品ids参数查询' do
    search_hash = { product_ids: [products(:one).id] }
    assert_equal [products(:one)], Product.search(search_hash)
  end
end
