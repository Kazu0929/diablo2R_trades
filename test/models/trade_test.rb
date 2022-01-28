require 'test_helper'

class TradeTest < ActiveSupport::TestCase

  def setup
    @user = users(:first)
    @trade = @user.trades.build( mode:"Softcore", season:"Normal", trade_type:"Buy", item_to_want:"AAA", item_to_offer:"CCC", content:"text")
  end

  test "インスタンス生成されるか" do
    assert @trade.valid?
  end

  test "user_idの存在確認" do
    @trade.user_id = nil
    assert_not @trade.valid?
  end

  test "modeの存在確認" do
    @trade.mode = nil
    assert_not @trade.valid?
  end

  test "seasonの存在確認" do
    @trade.season = nil
    assert_not @trade.valid?
  end

  test "trade_typeの存在確認" do
    @trade.season = nil
    assert_not @trade.valid?
  end

  test "item_to_wantの存在確認" do
    @trade.item_to_want = nil
    assert_not @trade.valid?
  end

  test "item_to_offerの存在確認" do
    @trade.item_to_offer = nil
    assert_not @trade.valid?
  end

  test "contentの字数制限の確認" do
    @trade.content = "a" * 141
    assert_not @trade.valid?
  end

  test "データを最新順に取得しているか" do
    assert_equal trades(:orange), Trade.first
  end
end
