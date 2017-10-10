require 'test_helper'
require 'minitest/mock'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should create a new ticket" do
    post tickets_path

    assert_response :success
    assert_json_response [ :barcode, :issued_at ]
  end

  test "should not create a ticket when there are no vacant spaces" do
    Vacancy.stub :current, Vacancy.new(total: 1, occupied: 1) do
      post tickets_path

      assert_not_found(code: :vacant_place_not_found)
    end
  end

  test "should provide euros due for ticket" do
    t = Ticket.create

    get ticket_path(t.barcode)

    assert_response :success
    assert_json_response(barcode: t.barcode, euros_due: t.euros_due)
  end

  test "should respond with :resource_not_found when ticket does not exist" do
    paths = [ticket_path("missing-barcode"), state_ticket_path("missing-code")]

    paths.each { |path|
      get path
      assert_not_found
    }
  end

  test "should respond with ticket state" do
    t = Ticket.create!

    get state_ticket_path(t.barcode)

    assert_response :success
    assert_json_response(barcode: t.barcode, state: t.state.to_s)
  end
end

