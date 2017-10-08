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
      amount_due: number_to_currency(t.euros_due)
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

  test "should respond with state of 'paid' when ticket is paid" do
    t = Ticket.create!
    t.create_payment!(option: :cash, amount_in_euro_cents: t.euros_due * 100)

    get state_ticket_path(t.barcode)

    assert_response :success
    assert_json_response(state: 'paid')
  end

  test "should respond with state of 'unpaid' when ticket is not paid" do
    t = Ticket.create!

    get state_ticket_path(t.barcode)

    assert_response :success
    assert_json_response(state: 'unpaid')
  end
end

