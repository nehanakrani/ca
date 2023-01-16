require "test_helper"

class API::V1::GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_groups_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_groups_show_url
    assert_response :success
  end
end
