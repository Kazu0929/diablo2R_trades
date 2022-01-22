require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "newページの取得" do
    get signup_path
    assert_response :success
  end

end
