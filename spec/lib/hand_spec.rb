require "spec_helper"
require "pry"

describe Hand do
  # These UTF-8 characters will be useful for making different hands:
  # '♦', '♣', '♠', '♥'

  let(:winning_hand) { Hand.new([Card.new("♦", 10), Card.new("♥", "J")]) }
  let(:losing_hand) { Hand.new([Card.new("♣", 7), Card.new("♣", 8), Card.new("♦", 9)]) }

  let(:one_ace_pass_hand) { Hand.new([Card.new("♥", "A"), Card.new("♠", 4), Card.new("♠", 6)]) }
  let(:one_ace_lose_hand) { Hand.new([Card.new("♥", "A"), Card.new("♠", "J"), Card.new("♣", 10), Card.new("♠", "J")]) }

  let(:two_ace_pass_hand) { Hand.new([Card.new("♥", "A"), Card.new("♠", "A"), Card.new("♠", 6)]) }
  let(:two_ace_lose_hand) { Hand.new([Card.new("♥", "A"), Card.new("♠", "A"), Card.new("♠", "J"), Card.new("♠", "J")]) }


  describe "#calculate_hand" do
    # We have included some example tests below. Change these once you get started!

    it "Passes" do
      expect(winning_hand.calculate_hand).to eq(20)
    end

    it "1 Ace Passes" do
      expect(one_ace_pass_hand.calculate_hand).to eq(21)
    end

    it "2 Ace Passes" do
      expect(two_ace_pass_hand.calculate_hand).to eq(18)
    end

    it "Fails" do
      expect(losing_hand.calculate_hand).to eq false
    end

    it "1 Ace Fails" do
      expect(one_ace_lose_hand.calculate_hand).to eq false
    end

    it "2 Ace Fails" do
      expect(two_ace_lose_hand.calculate_hand).to eq false
    end

  end
end
