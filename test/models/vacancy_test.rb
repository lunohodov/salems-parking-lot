require 'test_helper'

class VacancyTest < ActiveSupport::TestCase
  test "should calculate free spaces" do
    v = Vacancy.new(total: 10, occupied: 3)

    assert_equal 7, v.free_spaces
  end

  test "should serialize as json" do
    actual = Vacancy.new(total: 5, occupied: 2).as_json

    assert_equal 5, actual['total_spaces']
    assert_equal 2, actual['occupied_spaces']
    assert_equal 3, actual['free_spaces']
  end
end
