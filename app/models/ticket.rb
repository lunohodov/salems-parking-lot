require "securerandom"

class Ticket < ApplicationRecord
  alias_attribute :issued_at, :created_at

  validates :barcode, presence: true, uniqueness: true

  before_validation :ensure_has_barcode

  private

  def ensure_has_barcode
    self.barcode = generate_barcode if barcode.blank?
  end

  def generate_barcode
    SecureRandom.hex(8)
  end
end
