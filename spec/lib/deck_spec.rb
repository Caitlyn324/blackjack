require "spec_helper"

describe Deck do
  let(:deck) { Deck.new } # Creates a variable that can be used for tests

  describe "#build_deck" do
    # Remember that the '#' in '#build_deck' means it's a method.
    it "builds a deck of 52 cards" do
      expect(deck.cards.size).to eq 52
    end

    it "creates unique cards" do
      expect(deck.cards.uniq.size).to eq 52
    end
  end

  describe " correct deal output " do
    it "Output Player was dealt CARD for each receives card" do
      start_size = deck.cards.size
      finish_size = start_size - 2

      deck.deal()
      deck.deal()

      expect(deck.cards.size).to eq finish_size
    end

    it "Output Dealer was dealt CARD for each recieved card" do
      correct_card = deck.cards[-1]
      expect(deck.deal).to eq correct_card
    end
  end
end
