class Vacancy
  include ActiveModel::Serializers::JSON

  TOTAL_SPACES = 54

  attr_reader :total_spaces
  attr_reader :occupied_spaces

  def self.current
    Vacancy.new(total: TOTAL_SPACES, occupied: Ticket.unpaid.count)
  end

  def initialize(total:, occupied:)
    @total_spaces = total
    @occupied_spaces = occupied
  end

  def free_spaces
    total_spaces - occupied_spaces
  end

  def free_spaces?
    free_spaces > 0
  end

  def attributes
    { 'free_spaces' => nil, 'occupied_spaces' => nil, 'total_spaces' => nil }
  end
end
