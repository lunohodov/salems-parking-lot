require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_json_response(spec = {}, &block)
    assert_equal "application/json", @response.content_type

    json = ActiveSupport::JSON.decode(@response.body).symbolize_keys

    spec.each do |k, v|
      assert_equal v, json[k.to_sym], "Field mismatch #{k}"
    end

    yield(json, spec) if block_given?
  end
end
