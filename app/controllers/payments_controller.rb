class PaymentsController < ApiController
  def create
    Ticket.transaction do
      ticket = Ticket.lock(true).where(barcode: params[:ticket_id]).take!

      render json: { status: 200, message: "TODO: Ticket payed" }
    end
  end
end
