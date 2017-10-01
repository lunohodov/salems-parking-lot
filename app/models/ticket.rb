class Ticket < ApplicationRecord
  PRICE_PER_HOUR = 2

  alias_attribute :issued_at, :created_at

  validates :barcode, :'Barcode::' => true, uniqueness: true

  before_validation :ensure_has_barcode

  def fee
    duration_hours * PRICE_PER_HOUR
  end

  private

  def duration_hours(end_time = Time.now)
    unless issued_at.nil?
      (end_time.to_i - issued_at.to_i) / 3600.0
    else
      0
    end.ceil
  end

  def ensure_has_barcode
    self.barcode = Barcode.generate if barcode.blank?
  end
end
