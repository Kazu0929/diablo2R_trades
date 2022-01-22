require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "ログインページパス確認" do
    get login_path
    assert_response :success
  end

end
