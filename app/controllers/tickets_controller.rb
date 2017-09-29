class TicketsController < ActionController::API
  def create
    ticket = Ticket.new
    ticket.save

    render json: ticket
  end
end
