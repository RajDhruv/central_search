require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch_list" do
    get search_fetch_list_url
    assert_response :success
  end

end
