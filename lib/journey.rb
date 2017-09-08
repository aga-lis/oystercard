class Journey
  attr_reader :entry_station, :exit_station, :journeys
  def initialize
    @in_journey = false
    @journeys = []
  end

  def in_journey?
    !!entry_station
  end

  def journey_touch_out(exit_station)
    @exit_station = {:exit_station => exit_station}
    @journeys << @entry_station.merge(@exit_station)
    @entry_station = nil
  end

  def journey_touch_in(station)
    @entry_station = {:entry_station => station}
  end
end
