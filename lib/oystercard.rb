class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Oystercard maximum balance of £90 exceeded' if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    false
  end

end
