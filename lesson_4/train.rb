class Train
  attr_reader :speed, :route, :current_station, :wagons, :number, :wagon_type
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def gain_speed
    self.speed = speed + 10
  end

  def slow_down
    self.speed = 0
  end

  def attach(wagon)
    return unless not_moving? || wagon.is_a?(wagon_type)

    wagons << wagon
  end

  def detach
    return unless not_moving? || wagons.empty?

    wagons.pop
  end

  def take_route(route)
    self.route = route
    self.current_station_index = 0
    self.current_station = route.stations.first
    self.current_station.take_train(self)
  end

  def move_back
    return if current_station_index.zero?
    self.current_station.get_train_away(self)
    previous_station.take_train(self)
    self.current_station = previous_station
    self.current_station_index = previos_index
  end

  def move_forward
    return if current_station_index == route.stations.size - 1
    self.current_station.get_train_away(self)
    next_station.take_train(self)
    self.current_station = next_station
    self.current_station_index = next_index
  end

  protected

  attr_reader :current_station_index
  attr_writer :current_station_index, :current_station, :wagons, :wagon_type, :route

  def not_moving?
    speed.zero?
  end

  def next_index
    current_station_index + 1
  end

  def previos_index
    current_station_index - 1
  end

  def next_station
    return unless route
    route.stations[next_index]
  end

  def previous_station
    return unless route
    route.stations[previos_index]
  end
end
