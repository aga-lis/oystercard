require_relative 'journey'
class Oystercard
  attr_reader :balance, :journey
  CARD_LIMIT = 90
  CARD_MIN_BALANCE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Oystercard maximum balance of #{CARD_LIMIT} exceeded" if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_out(exit_station)
    if @journey.in_journey?
      deduct(CARD_MIN_BALANCE)
    else
      deduct(PENALTY_FARE)
      @journey.journey_touch_in("No entry station logged")
    end
    @journey.journey_touch_out(exit_station)
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < 1
    if @journey.in_journey?
      deduct(PENALTY_FARE)
    @journey.journey_touch_out("No exit station logged")
  end
    @journey.journey_touch_in(station)
  end

private

def deduct(value)
  @balance -= value
end
end
