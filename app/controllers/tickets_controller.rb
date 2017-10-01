class TicketsController < ActionController::API
  include ActionView::Helpers::NumberHelper

  def create
    ticket = Ticket.new
    ticket.save

    render json: ticket
  end

  def show
    ticket = Ticket.where(barcode: params[:id]).take

    render json: number_to_currency(ticket.fee)
  end
end
