class TicketsController < ApiController
  include ActionView::Helpers::NumberHelper

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
      amount_due: number_to_currency(ticket.amount_due),
      created_at: ticket.created_at
    }
  end
end
