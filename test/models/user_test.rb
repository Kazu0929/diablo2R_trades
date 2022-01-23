require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "112233", password_confirmation: "112233")
  end

  test "validでtrueか確認" do
    assert @user.valid?
  end

  test "nameのバリデーション" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "emailのバリデーション" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "nameの長さバリデーションでfalseか" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "emailの長さのバリデーションでfalseか" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "emailの正規表現バリデーションでtrueになるか" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} はtrueです"
    end
  end

  test "emailの正規表現バリデーションでfalseになるか" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} はfalseです"
    end
  end

  test "emailが重複すればfalseを返すか" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emailを大文字変換しfalseを返すか" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emailを小文字変換しfalseを返すか" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emailが小文字変換され保存されるか" do
    mixed_case_email = "Test@ExAMPle.CoM"
    @user.update_attribute(:email, mixed_case_email)
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "passwordが空白ならfalseを返すか" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "passwordの最低文字数を満たさないならfalseを返すか" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "remember_digestがnilならfalseを返すか" do
    assert_not @user.authenticated?('')
  end
end
