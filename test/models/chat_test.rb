require 'test_helper'

class ChatTest < ActiveSupport::TestCase

  def setup
    @user = users(:first)
    @room = rooms(:three)
    @chat = @user.chats.build(room_id: @room.id, message:"aaa")
  end

  test "インスタンス生成されるか" do
    assert @chat.valid?
  end

  test "messageの存在確認" do
    @chat.message = ""
    assert_not @chat.valid?
  end
end
