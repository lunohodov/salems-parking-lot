require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should create a new ticket" do
    post tickets_path

    assert_response :success
    assert_equal "application/json", @response.content_type
  end
end
