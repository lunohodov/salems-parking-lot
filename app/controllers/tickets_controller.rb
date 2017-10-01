class TicketsController < ActionController::API
  include ActionView::Helpers::NumberHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    ticket = Ticket.new
    ticket.save

    render_ticket(ticket)
  end

  def show
    ticket = Ticket.where(barcode: params[:id]).take!

    render_ticket(ticket)
  end

  private

  def render_ticket(ticket)
    render json: {
      barcode: ticket.barcode,
      issued_at: ticket.issued_at,
      fee: number_to_currency(ticket.fee)
    }
  end

  def record_not_found(e)
    render json: { status: 404, message: "The requested resource was not found" }, status: 404
  end
end
