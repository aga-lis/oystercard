class Oystercard
  attr_reader :balance, :journeys
  attr_reader :entry_station
  CARD_LIMIT = 90
  #CARD_MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "Oystercard maximum balance of #{CARD_LIMIT} exceeded" if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(exit_station)
    @in_journey = false
    @balance -= 1
    @exit_station = {:exit_station => exit_station}
    @journeys << @entry_station.merge(@exit_station)
    @entry_station = nil

  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < 1
    @entry_station = {:entry_station => station}
  end

private

def deduct(value)
  @balance -= value
end

end
