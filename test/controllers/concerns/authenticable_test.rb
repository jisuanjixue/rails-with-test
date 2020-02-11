class AuthenticableTest < ActionDispatch::IntegrationTest
  class MockController
    include Authenticable
    attr_accessor :request
    def initialize
      mock_request = Struct.new(:headers)
      self.request = mock_request.new({})
    end
  end

  setup do
    @user = users(:one)
    @authentication = MockController.new
  end

  test '获取用户用Authorization token' do
    @authentication.request.headers['Authorization'] =
      JsonWebToken.encode(user_id: @user.id)
    assert_equal @user.id, @authentication.current_user.id
  end

  test '无法获取用户， 由于空的 Authorization token' do
    @authentication.request.headers['Authorization'] = nil
    assert_nil @authentication.current_user
  end
end
