require "test_helper"
require "json"

class PostssControllerTest < ActionDispatch::IntegrationTest
  test "show action returns the correct post" do
    get post_url(posts(:composite_key)), headers: { "Accept" => "application/json" }
    json_response = JSON.parse(@response.body)

    assert_equal posts(:composite_key).author_id, json_response["author_id"]
    assert_equal posts(:composite_key).slug, json_response["slug"]
    assert_response :success
  end
end
