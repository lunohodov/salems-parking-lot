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
    assert_json_response do |json|
      assert_equal number_to_currency(t.amount_due), json["amount_due"]
    end
  end

  test "should respond with error when ticket can not be found" do
    get ticket_path("missing-barcode")

    assert_response :not_found

    assert_json_response do |json|
      assert_equal 404, json["status"]
      assert_equal "The requested resource was not found", json["message"]
    end
  end

  def assert_json_response(&block)
    assert_equal "application/json", @response.content_type

    if block_given?
      yield ActiveSupport::JSON.decode(@response.body)
    end
  end
end

