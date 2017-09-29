require 'test_helper'

class TicketTest < ActiveSupport::TestCase
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
