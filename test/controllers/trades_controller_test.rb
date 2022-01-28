require 'test_helper'

class TradesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @trade = trades(:orange)
  end

  test "ログインしない状態で投稿ができないか" do
    assert_no_difference 'Trade.count' do
      post trades_path, params: { trade: { item_to_want:"aaa", item_to_offer:"aaa",content: "Lorem ipsum", platform_ids: [1,2] } }
    end
    assert_redirected_to login_url
  end

  test "ログインしない状態で削除ができないか" do
    assert_no_difference 'Trade.count' do
      delete trade_path(@trade)
    end
    assert_redirected_to login_url
  end
end