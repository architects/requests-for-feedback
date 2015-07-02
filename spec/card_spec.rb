require 'spec_helper'

describe Card do
  before :each do
    @card = Card.new "Gregg", 1234567812345670, "$3000"
  end

  describe "#new" do
    it "takes three arguements and returns a card object" do
      expect(@card).to be_an_instance_of Card
    end
  end

  describe "#name" do
    it "should return name" do
      expect(@card.name).to eq("Gregg")
    end
  end

  describe "#number" do
    it "should return number" do
      expect(@card.card_number).to eq(1234567812345670)
    end
  end

  describe "#balance" do
    it "should return balance" do
      expect(@card.balance).to eq("$0")
    end
  end

  describe "#limit" do
    it "should return limit" do
      expect(@card.limit).to eq("$3000")
    end
  end

  describe "#luhn_check" do
    it "should return error if card number doesn't pass luhn check" do
      @bad_card = Card.new "Gregg", 49927398717, "$4000"
      expect(@bad_card.balance).to eq("ERROR")
    end
  end

  describe "#charge" do
    it "should charge the amount to the card" do
      @card.charge("$100")
      expect(@card.balance).to eq("$100")
      expect(@card.limit).to eq("$2900")
    end
  end

  describe "#credit" do
    it "should credit the amount to the card" do
      @card.balance = "$100"
      @card.credit("$100")
      expect(@card.balance).to eq("$0")
      expect(@card.limit).to eq("$3000")
    end
  end
end
