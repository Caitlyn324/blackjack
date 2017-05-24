class Card
  attr_reader :suit, :value

  def initialize suit, value
    @suit = suit
    @value = value
  end

  def face?
    @value == "J" || @value == "Q" || @value == "K"
  end

  def ace?
    @value == "A"
  end

end
