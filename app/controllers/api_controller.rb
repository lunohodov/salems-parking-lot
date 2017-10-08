class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def render_status(code, message)
    render json: { status: code, message: message }, status: code
  end

  private

  def resource_not_found
    render_status 404, "The requested resource was not found"
  end
end
