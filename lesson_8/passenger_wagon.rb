class PassengerWagon < Wagon
  include Validation

  attr_reader :number_of_seats, :taken_seats
  validate :number_of_seats, :type, Integer

  def initialize(number_of_seats)
    @type = 'Passenger'
    @number_of_seats = number_of_seats
    validate!
    @taken_seats = 0
  end

  def take_seat
    raise 'Все места заняты' if number_of_seats == taken_seats

    self.taken_seats += 1
  end

  def free_seats
    number_of_seats - taken_seats
  end

  private

  attr_writer :number_of_seats, :taken_seats
end
