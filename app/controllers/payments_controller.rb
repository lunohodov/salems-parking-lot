class PaymentsController < ApiController
  def create
    ticket_payment = TicketPayment.new(ticket: ticket, option: params.require(:option))
    if ticket_payment.make
      render json: { status: 200 }
    else
      render_error 400, ticket_payment.errors.full_messages.join('\n')
    end
  end

  private

  def ticket
    @ticket ||= Ticket.where(barcode: params.require(:ticket_id)).take!
  end
end
