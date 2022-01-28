require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:first)
    remember(@user)
  end

  test "カレントユーザーと一致しているか" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "記憶ダイジェストが記憶トークンと適合しない場合にnilになるか" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end


end