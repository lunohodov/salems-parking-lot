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
    assert_json_response(
      amount_due: number_to_currency(t.amount_due)
    )
  end

  test "should respond with error when ticket can not be found" do
    get ticket_path("missing-barcode")

    assert_response :not_found
    assert_json_response(
      status: 404,
      message: "The requested resource was not found"
    )
  end
end

