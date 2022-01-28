require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
    @other_user = users(:second)
  end

  test "ログインせずindexビューに飛んだ時にリダイレクトされるか" do
    get users_path
    assert_redirected_to login_url
  end

  test "ログインせずeditビューに飛んだ時にリダイレクトされるか" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにupdateアクションを実行した時リダイレクトされるか" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "web経由でadmin属性の変更が拒否されるか" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password:              "password",
              password_confirmation: "password",
              admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "違うユーザーがeditビューに飛んだ時にリダイレクトされるか" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "違うユーザーがupdateアクションを実行した時にリダイレクトされるか" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログインせずdeleteリクエストが送れないか" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "adminでないとdeleteリクエストが送れないか" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
