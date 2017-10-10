class ApiController < ActionController::API
  rescue_from StandardError, with: :internal_error
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
  rescue_from ActionController::ParameterMissing, with: Proc.new { |e| invalid_request(e.message) }

  def internal_error(e = nil)
    logger.error e
    render_error __method__.to_s, 500, "The server encountered internal error"
  end

  def invalid_request(message = nil)
    render_error __method__.to_s, 400, message || "The request has a missing parameter or an invalid parameter value"
  end

  def resource_not_found
    render_error __method__.to_s, 404, "The requested resource was not found"
  end

  def vacant_place_not_found
    render_error __method__.to_s, 404, "The requested resource was not found"
  end

  def render_error(code, status, message)
    render json: { error_code: code, error_status: status, error_message: message }, status: status
  end
end
