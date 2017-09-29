require 'test_helper'

class BarcodeThingie
  include ActiveModel::Validations

  attr_accessor :barcode

  def initialize(barcode)
    @barcode = barcode.to_s
  end

  validates :barcode, :'Barcode::' => true
end

class BarcodeTest < ActiveSupport::TestCase
  test "should generate valid" do
    assert_match (/^[0-9a-fA-F]{16}$/), Barcode.generate
  end

  test "validator should reject invalid values" do
    invalid_values.each do |v|
      record = BarcodeThingie.new(v)

      assert_not record.valid?, "Value: '#{v}'"
      assert_not record.errors[:barcode].empty?
    end
  end

  test "validator should accept valid values" do
    valid_values.each do |v|
      record = BarcodeThingie.new(v)

      assert record.valid?, "Value: '#{v}'"
      assert record.errors[:barcode].empty?
    end
  end

  def invalid_values
    [
      nil,
      "",
      " ",
      12345678901234566, 
      "83d60c44b9d9ef1",
      "83d60c44b9d9ef17 ",
      " 83d60c44b9d9ef17",
      " 83d60c44b9d9ef17 ",
      "83d60c44b9d9ef176",
    ]
  end

  def valid_values
    [
      "83d60c44b9d9ef17",
      "1111111111111111",
      "ffffffffffffffff"
    ]
  end
end
