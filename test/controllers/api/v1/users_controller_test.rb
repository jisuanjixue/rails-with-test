require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test '显示用户' do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end

  test "创建用户测试" do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json
    end
    assert_response :created
  end

  test "没有根据邮箱创建用户失败" do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
    end
    assert_response :unprocessable_entity
  end
end
