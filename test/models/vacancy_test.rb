require 'test_helper'

class VacancyTest < ActiveSupport::TestCase
  test "should calculate free spaces" do
    v = Vacancy.new(total: 10, occupied: 3)

    assert_equal 7, v.free_spaces
  end
end
