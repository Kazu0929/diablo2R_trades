require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "サイトURLの確認" do
    get
    assert_template 'static_pages/#home'
  end
end
