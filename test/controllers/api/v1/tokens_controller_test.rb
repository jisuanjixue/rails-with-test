require 'test_helper'

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:one) }

  test '有效JWTtoken' do
    post api_v1_tokens_url,
         params: { user: { email: @user.email, password: 'g00d_pa$$' } },
         as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test '无效JWTtoken' do
    post api_v1_tokens_url,
         params: { user: { email: @user.email, password: 'b@d12_pa$$' } },
         as: :json
    assert_response :unauthorized
  end
end
