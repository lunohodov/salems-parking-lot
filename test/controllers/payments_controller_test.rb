require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should create a payment for specified ticket" do
    ticket = Ticket.create!

    post ticket_payments_path(ticket.barcode), params: { option: :credit_card }

    assert_response :success
    assert_json_response(
      barcode: ticket.barcode,
      euros_paid: ticket.payment.amount_in_euros
    )
  end

  test "should respond with 404 when ticket does not exist" do
    post ticket_payments_path("some_id"), params: { option: :cash }

    assert_not_found
  end
end
