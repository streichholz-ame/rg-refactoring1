class BasicCard
  CAPITALIST_CARD = 'capitalist'.freeze
  USUAL_CARD = 'usual'.freeze
  VIRTUAL_CARD = 'virtual'.freeze
  CARD_DIGITS = (0..9).freeze
  CARD_NUMBER_LENGTH = 16

  attr_reader :number
  attr_accessor :balance

  def initialize
    @number = generate_card_number
    @balance = start_balance
  end

  def withdraw(amount)
    @balance -= amount + withdraw_tax(amount)
  end

  def put(amount)
    @balance += amount - put_tax(amount)
  end

  def sent(amount)
    @balance -= amount + sender_tax(amount)
  end

  def withdraw_tax(amount)
    tax(amount, withdraw_percent, withdraw_fixed)
  end

  def put_tax(amount)
    tax(amount, put_percent, put_fixed)
  end

  def sender_tax(amount)
    tax(amount, sender_percent, sender_fixed)
  end

  private

  def start_balance
    0
  end

  def generate_card_number
    (Array.new(CARD_NUMBER_LENGTH) { rand(CARD_DIGITS) }).join
  end

  def tax(amount, percent, fixed)
    amount * percent / 100.0 + fixed
  end

  def withdraw_percent
    0
  end

  def put_percent
    0
  end

  def sender_percent
    0
  end

  def withdraw_fixed
    0
  end

  def put_fixed
    0
  end

  def sender_fixed
    0
  end
end
