class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90
  #CARD_MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Oystercard maximum balance of #{CARD_LIMIT} exceeded" if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
    @balance -= 1

  end

  def touch_in
    fail "Insufficient balance to touch in" if balance < 1
    @in_journey = true
  end

private

def deduct(value)
  @balance -= value
end

end
