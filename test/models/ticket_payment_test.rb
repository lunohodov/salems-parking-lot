require 'minitest/mock'
require 'test_helper'

class TicketPaymentTest < ActiveSupport::TestCase
  test "should not be valid with missing ticket" do
    tp = TicketPayment.new(ticket: nil, option: :cash)

    assert_not tp.valid?
    assert_not tp.errors[:ticket].empty?
  end

  test "should not be valid with invalid option" do
    tp = TicketPayment.new(ticket: nil, option: :bag_of_beans)

    assert_not tp.valid?
    assert_not tp.errors[:option].empty?
  end

  test "should not pay a ticket twice" do
    stub_paid_ticket do |t|
      tp = TicketPayment.new(ticket: t, option: :cash)

      assert_not tp.make
      assert_not tp.errors[:ticket].empty?
    end
  end

  test "should make ticket payment" do
    t = Ticket.create!
    tp = TicketPayment.new(ticket: t, option: :credit_card)

    assert tp.make
    assert t.paid?
  end

  private

  def stub_paid_ticket(attributes = {}, &block)
    t = Ticket.new(attributes)
    t.stub :paid?, true do
      yield t
    end
  end
end
