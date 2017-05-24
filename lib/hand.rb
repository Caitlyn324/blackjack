require_relative 'deck'
require_relative 'card'

class Hand
  attr_reader :cards, :name
  attr_accessor :total

  def initialize(name, cards = [])
    @name = name
    @cards = cards
    @total = 0
  end

  def add_card(new_card)
    @cards << new_card
  end

  def calculate_hand
    @total = 0
    ace_count = 0

    @cards.each do |card|
      if card.ace?
        ace_count += 1
        @total += 1
      elsif card.face?
        @total += 10
      else
        @total += card.value
      end
    end

    if @total < 21
      ace_count.times do
        while (@total + 10) <= 21
          @total += 10
        end
      end
    end

    return @total
  end

end
