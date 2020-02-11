require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '用户邮箱有效' do
    user = User.new(email: 'test@test.org', password_digest: 'test123')
    assert user.valid?
  end

  test '用户邮箱必须无效地址' do
    user = User.new(email: 'test', password_digest: 'test123')
    assert_not user.valid?
  end

  test '用户邮箱必须无效' do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: 'test123')
    assert_not user.valid?
  end

  test '删除用户，改用户的相关产品也要删除' do            
    assert_difference('Product.count', -1) do
      users(:one).destroy
    end
  end
end
