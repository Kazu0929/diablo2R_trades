require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "HOMEページパス及びタイトル確認" do
    get root_path
    assert_response :success
    assert_select "title", "DIABLO2R TRADES"
  end

end
