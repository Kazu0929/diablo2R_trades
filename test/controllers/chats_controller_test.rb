require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:first)
  end

  test "showページへのパス確認" do
    log_in_as(@user)
    get chat_path(@user)
    assert_response :success
  end

end
