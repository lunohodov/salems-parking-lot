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

  test "should respond with :invalid_request when option is invalid" do
    ticket = Ticket.create!

    post ticket_payments_path(ticket.barcode), params: { option: nil }
    assert_response :bad_request

    post ticket_payments_path(ticket.barcode), params: { }
    assert_response :bad_request

    post ticket_payments_path(ticket.barcode), params: { option: :bad_of_beans }
    assert_response :bad_request
  end

  test "should respond with 404 when ticket does not exist" do
    post ticket_payments_path("some_id"), params: { option: :cash }

    assert_not_found
  end
end
