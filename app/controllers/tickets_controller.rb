class TicketsController < ApiController
  include ActionView::Helpers::NumberHelper

  def create
    vacancy = Vacancy.current
    if vacancy.free_spaces?
      t = Ticket.create!
      render_ticket(t)
    else
      render_status :not_found, "No vacant parking spaces available"
    end
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
