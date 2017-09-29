require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "should ticket does not validate when barcode is invalid" do
    t = Ticket.new
    t.barcode = "some code"

    assert_not t.valid?
    assert_not t.errors[:barcode].empty?
  end

  test "should not create ticket without barcode" do
    t = Ticket.new

    assert t.save
    assert_not t.barcode.blank?
  end

  test "should not create ticket without an issue time" do
    t = Ticket.new

    assert t.save
    assert_not t.issued_at.blank?
  end
end
