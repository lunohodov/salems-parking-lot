class ApiController < ActionController::API
  rescue_from StandardError, with: :handle_error

  private

  def handle_error(e)
    # FIXME
    logger.error e

    case e
      when ActiveRecord::RecordNotFound
        render_error 404, "The requested resource was not found"
      else
        render_error 500, "An unexpected error occurred"
    end
  end

  def render_error(status, message)
    render json: { status: status, message: message }, status: status
  end
end
