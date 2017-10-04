require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test "should require a payment option" do
    p = Payment.new

    assert_not p.valid?
    assert_not p.errors[:option].empty?
  end

  test "should require a ticket" do
    p = Payment.new

    assert_not p.valid?
    assert_not p.errors[:ticket].empty?
  end

  test "should require an amount" do
    p = Payment.new

    assert_not p.valid?
    assert_not p.errors[:amount_in_euro_cents].empty?
  end

  test "should return appropriate amount in euros" do
    assert_equal 0, Payment.new.amount_in_euros, "not present"
    assert_equal 0, Payment.new(amount_in_euro_cents: 0).amount_in_euros, "0 when given"
    assert_equal 2, Payment.new(amount_in_euro_cents: 200).amount_in_euros
  end
end
