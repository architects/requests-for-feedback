require_relative 'card.rb'

class CardProcessor
  attr_accessor :cards, :display

  def initialize
    @cards = {}
  end

  def get_input
    $stdin.gets.chomp.split(" ")
  end

  def display
    output = ''
    @cards.sort.each do |k,v|
      output << v.name + ": " + v.balance + "\n"
    end
    return output
  end

  def run
    puts "Welcome to Card Processor 0.1"
    while input = get_input
      case input[0]
      when 'Add'
        @cards[input[1].downcase.to_sym] = Card.new(input[1], input[2], input[3])
      when 'Charge'
        @cards[input[1].downcase.to_sym].charge(input[2])
      when 'Credit'
        @cards[input[1].downcase.to_sym].credit(input[2])
      when 'end'
        return display
      else
        puts "Invalid Input!"
        break
      end
    end
  end

end
