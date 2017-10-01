class Ticket < ApplicationRecord
  PRICE_PER_HOUR = 2

  alias_attribute :issued_at, :created_at

  validates :barcode, :'Barcode::' => true, uniqueness: true

  before_validation :ensure_has_barcode

  def amount_due
    hours_due * PRICE_PER_HOUR
  end

  private

  def hours_due(end_time = Time.now)
    return 0 if issued_at.nil?

    duration_hours = (end_time.to_i - issued_at.to_i) / 3600.0

    [duration_hours.ceil, 1].max
  end

  def ensure_has_barcode
    self.barcode = Barcode.generate if barcode.blank?
  end
end
