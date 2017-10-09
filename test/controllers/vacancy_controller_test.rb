require 'test_helper'

class VacancyControllerTest < ActionDispatch::IntegrationTest
  test "shows current vacancy" do
    expected_vacancy = Vacancy.current

    get free_spaces_url

    assert_response :success
    assert_json_response(expected_vacancy.as_json)
  end
end
