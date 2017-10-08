class Ticket < ApplicationRecord
  PRICE_PER_HOUR_EUROS = 2

  has_one :payment

  validates :barcode, :'Barcode::' => true, uniqueness: true

  before_validation :ensure_has_barcode

  def euros_due
    unless paid?
      hours_due * PRICE_PER_HOUR_EUROS
    else
      0
    end
  end

  def paid?
    payment.present? && payment.valid?
  end

  def state
    if paid_within_last_15_minutes?
      :paid
    else
      :unpaid
    end
  end

  private

  def paid_within_last_15_minutes?
    paid? && 15.minutes.ago < payment.created_at
  end

  def hours_due(end_time = Time.now)
    return 0 if created_at.nil?

    duration_hours = (end_time.to_i - created_at.to_i) / 3600.0

    [duration_hours.ceil, 1].max
  end

  def ensure_has_barcode
    self.barcode = Barcode.generate if barcode.blank?
  end
end
