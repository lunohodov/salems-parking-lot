class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(e)
    render json: { status: 404, message: "The requested resource was not found" }, status: 404
  end
end
