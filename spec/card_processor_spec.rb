require 'spec_helper'


describe CardProcessor do

  def define_input(input)
    $stdin = StringIO.new(input)
  end


  before :each do
    @card_processor = CardProcessor.new
  end

  describe "#new" do
    it "should be an instance of CardProcessor" do
      expect(@card_processor).to be_an_instance_of CardProcessor
    end
  end

  describe "#add" do
    it "should run add action" do
      define_input("Add Tom 4111111111111111 $1000\nend")
      @card_processor.run
      expect(@card_processor.cards[:tom].name).to eq("Tom")
    end
  end

  describe "#charge" do
    it "should charge" do
      define_input("Add Tom 4111111111111111 $1000\nCharge Tom $500\nend")
      @card_processor.run
      expect(@card_processor.cards[:tom].balance).to eq("$500")
      expect(@card_processor.cards[:tom].limit).to eq("$500")
    end
  end

  describe "#credit" do
    it "should credit" do
      define_input("Add Tom 4111111111111111 $1000\nCredit Tom $500\nend")
      @card_processor.run
      expect(@card_processor.cards[:tom].balance).to eq("$-500")
      expect(@card_processor.cards[:tom].limit).to eq("$1000")
    end
  end

  describe "#braintree" do
    it "should correctly test braintree data" do
      define_input("Add Tom 4111111111111111 $1000\nAdd Lisa 5454545454545454 $3000\nAdd Quincy 1234567890123456 $2000\nCharge Tom $500\nCharge Tom $800\nCharge Lisa $7\nCredit Lisa $100\nCredit Quincy $200\nend")
      expect(@card_processor.run).to eq("Lisa: $-93\nQuincy: ERROR\nTom: $500\n")
    end
  end
end
