require 'test_helper'
require 'minitest/mock'

class VacancyControllerTest < ActionDispatch::IntegrationTest
  test "shows current vacancy" do
    expected_vacancy = Vacancy.new(total: 10, occupied: 5)

    Vacancy.stub :current, expected_vacancy do
      get free_spaces_url

      assert_response :success
      assert_json_response(free_spaces: expected_vacancy.free_spaces)
    end
  end
end
