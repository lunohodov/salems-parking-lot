class Payment < ApplicationRecord
  enum option: [ :cash, :credit_card, :debit_card ]

  belongs_to :ticket

  validates :ticket, presence: true
  validates :option, presence: true
  validates :amount_in_euro_cents, numericality: { integer_only: true }

  def amount_in_euros=(euros)
    self[:amount_in_euro_cents] = euros * 100
  end

  def amount_in_euros
    if amount_in_euro_cents.present?
      amount_in_euro_cents / 100.0
    else
      0
    end
  end
end
