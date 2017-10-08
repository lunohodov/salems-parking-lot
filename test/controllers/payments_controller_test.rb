require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should create a payment for specified ticket" do
    ticket = Ticket.create!

    post ticket_payments_path(ticket_id: ticket.barcode), params: { option: :credit_card }

    assert_response :success
    assert_json_response(status: 200)
    assert ticket.paid?
  end

  test "should respond with 404 when ticket does not exist" do
    post ticket_payments_path(ticket_id: "some_id"), params: { option: :cash }

    assert_response :not_found
    assert_json_response(
      status: 404
    )
  end
end
