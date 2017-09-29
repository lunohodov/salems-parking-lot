class Ticket < ApplicationRecord
  alias_attribute :issued_at, :created_at

  validates :barcode, :'Barcode::' => true, uniqueness: true

  before_validation :ensure_has_barcode

  private

  def ensure_has_barcode
    self.barcode = Barcode.generate if barcode.blank?
  end
end
