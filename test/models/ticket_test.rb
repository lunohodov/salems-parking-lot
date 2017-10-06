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

  test "should calculate minimum fee for issued tickets" do
    t = Ticket.new(created_at: Time.now)

    assert_equal 2, t.euros_due
  end

  test "should calculate fee for every hour started" do
    assert_equal 2, Ticket.new(created_at: 1.minutes.ago).euros_due
    assert_equal 2, Ticket.new(created_at: 60.minutes.ago).euros_due
    assert_equal 4, Ticket.new(created_at: 61.minutes.ago).euros_due
  end

  test "should calculate no fee, when ticket is not issued yet" do
    t = Ticket.new

    assert_equal 0, t.euros_due
  end
end
