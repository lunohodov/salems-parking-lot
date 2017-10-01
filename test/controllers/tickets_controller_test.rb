require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::NumberHelper

  test "should create a new ticket" do
    post tickets_path

    assert_response :success
    assert_json_response
  end

  test "should provide the fee due for a specified ticket" do
    t = Ticket.create

    get ticket_path(t.barcode)

    assert_response :success
    assert_json_response number_to_currency(t.fee)
  end

  def assert_json_response(expected = nil)
    assert_equal "application/json", @response.content_type
    assert_equal expected, @response.body unless expected.nil?
  end
end

