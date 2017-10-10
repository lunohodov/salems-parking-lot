class TicketsController < ApiController
  def create
    vacancy = Vacancy.current
    if vacancy.free_spaces?
      t = Ticket.create!
      render json: { barcode: t.barcode, issued_at: t.created_at }
    else
      vacant_place_not_found
    end
  end

  def show
    render json: { barcode: ticket.barcode, euros_due: ticket.euros_due }
  end

  def state
    render json: { barcode: ticket.barcode, state: ticket.state }
  end

  private

  def ticket
    @ticket ||= Ticket.where(barcode: params.require(:barcode)).take!
  end
end
