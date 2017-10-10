require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def assert_not_found(code: :resource_not_found)
    assert_response :not_found

    assert_json_response do |json|
      assert_equal code.to_s, json[:error_code]
    end
  end

  def assert_json_response(spec = nil, &block)
    assert_equal "application/json", @response.content_type

    case spec
    when Hash
      assert_equal spec, response_json
    when Array
      assert_equal spec, response_json.keys
    else
      # Do nothing
    end

    yield(response_json, spec) if block_given?
  end

  def response_json
    @json ||= ActiveSupport::JSON.decode(@response.body).symbolize_keys
  end
end
