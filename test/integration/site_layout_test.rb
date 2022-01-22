require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "サイトURLの確認" do
    get root_path
    assert_template 'static_pages/home'
  end
end
