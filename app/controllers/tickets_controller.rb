class TicketsController < ApiController
  include ActionView::Helpers::NumberHelper

  def create
    ticket = Ticket.new
    ticket.save

    render_ticket(ticket)
  end

  def show
    render_ticket(ticket)
  end

  def state
    render json: { barcode: ticket.barcode, state: ticket.state }
  end

  private

  def ticket
    @ticket ||= Ticket.where(barcode: params.require(:barcode)).take!
  end

  def render_ticket(ticket)
    render json: {
      barcode: ticket.barcode,
      amount_due: number_to_currency(ticket.euros_due),
      issued_at: ticket.created_at
    }
  end
end
