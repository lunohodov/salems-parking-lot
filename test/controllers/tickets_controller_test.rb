require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::NumberHelper

  test "should create a new ticket" do
    post tickets_path

    assert_response :success
    assert_equal "application/json", @response.content_type
  end

  test "should provide the fee due for a specified ticket" do
    t = Ticket.create

    get ticket_path(t.barcode)

    assert_response :success
    assert_equal "application/json", @response.content_type
    assert_equal number_to_currency(t.fee), @response.body
  end
end

