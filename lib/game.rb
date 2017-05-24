require_relative "card"
require_relative "deck"
require_relative "hand"

class Game

  def initialize(player_name)
    @player = Hand.new(player_name)
    @dealer = Hand.new("Dealer")
    @deck = Deck.new
    @result = {
      won: false,
      lost: false,
      stalemate: false,
      natural: false
    }
  end

  def play
    bust = false
    start(@player)
    puts "#{@player.name} Score: #{@player.calculate_hand}"

    input = ""
    while input.downcase != "s" && @player.total < 21 && input.downcase != "konami"
      print "Hit or stand (H/S): "
      input = gets.chomp
      if input.downcase == "konami"
        puts "BLACKJACK!"
        @player.total = 21
        @result[:won] = true
        @result[:natural] = true
      end

      if input.downcase == "h"
        hit(@player)
        puts "#{@player.name}\'s Score: #{@player.calculate_hand}\n\n"
        if @player.total == 21
          puts "BLACKJACK!"
          @result[:won] = true
          @result[:natural] = true
        end
      elsif input.downcase == "s"
        puts "\n#{@player.name} Stands."
        puts "#{@player.name}\'s Score: #{@player.calculate_hand}\n\n"
        if @player.total == 21
          puts "BLACKJACK!"
          @result[:won] = true
          @result[:natural] = true
        end
      elsif input.downcase != "konami"
        puts "INVALID INPUT. WAY TO GO EINSTEIN"
      end
    end

    if @player.total < 21
      start(@dealer)
      puts "Dealer\'s Score: #{@dealer.calculate_hand}\n\n"
      while @dealer.total < 17
        hit(@dealer)
        puts "Dealer\'s Score: #{@dealer.calculate_hand}\n\n"
        if @dealer.total > 21
          puts "Dealer Busts! You Win!"
          @result[:won] = true
          bust = true
        end
      end
    elsif @player.total > 21
      puts "It's a Bust! Sorry, you lose :'("
      @result[:lost] = true
      bust = true
    end

    if !bust
      if @player.total > @dealer.total && @player.total <= 21
        puts "Congratulations, You Win!"
        @result[:won] = true
      elsif @player.total < @dealer.total && @dealer.total <= 21
        puts "Sorry, you lose :'("
        @result[:lost] = true
      else
        puts "Stalemate! Everybody Wins (kinda)!"
        @result[:stalemate] = true
      end
    end

  @result
  end

def start(participant_start)
    2.times do
      new_card = @deck.deal
      participant_start.add_card(new_card)
      puts "#{participant_start.name} was dealt #{new_card.value}#{new_card.suit}"
    end
end

def hit(participant_hit)
  new_card = @deck.deal
  participant_hit.add_card(new_card)
  puts "#{participant_hit.name} was dealt #{new_card.value}#{new_card.suit}"
end


end
