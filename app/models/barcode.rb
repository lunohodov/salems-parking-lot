require "securerandom"

class Barcode
  class << self
    def generate
      SecureRandom.hex(8)
    end
  end

  class Validator < ActiveModel::EachValidator
    FORMAT = /^[0-9a-fA-F]{16}$/

    def validate_each(record, attribute, value)
      record.errors.add attribute, "must be 16 digits hex" unless FORMAT.match?(value.to_s)
    end
  end
end
