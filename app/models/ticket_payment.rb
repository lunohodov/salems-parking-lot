class TicketPayment
  include ActiveModel::Validations

  attr_reader :ticket
  attr_reader :option

  validates :ticket, presence: true
  validates :option, inclusion: { in: Payment.options }
  validate :payment_not_already_made

  def initialize(ticket:, option:)
    @ticket = ticket
    @option = option
  end

  def make
    if valid?
      create_payment
      true
    else
      false
    end
  end

  def made?
    ticket.present? && ticket.paid?
  end

  def euros_paid
    if made?
      ticket.payment.amount_in_euros
    else
      0
    end
  end

  private

  def payment_not_already_made
    if made?
      errors.add(:ticket, "ticket has already been paid")
    end
  end

  def create_payment
    ticket.create_payment!(
      option: option,
      amount_in_euro_cents: euros_to_cents(ticket.euros_due)
    )
  end

  def euros_to_cents(euros)
    euros * 100
  end
end
