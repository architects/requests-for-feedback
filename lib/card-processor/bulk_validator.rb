module CardProcessor
  class BulkValidator
    def self.validate_from_csv(path_to_csv, options={})
      # TODO
      # Support loading card numbers, expiration numbers, and security codes from a CSV
    end

    attr_accessor :card_data

    def initialize(card_data=[], options={})
      @card_data = Array(card_data)
      run if options[:auto_run]
    end

    # Generates a hash keyd by card number with any
    # errors related to that card
    def errors_by_card
      cards.reduce({}) do |memo, card|
        memo[card.number] = card.errors
        memo
      end
    end

    def cards
      @cards ||= card_data.map {|attributes| CardProcessor::Card.new(attributes) }
    end

    # runs the
    def all_cards_valid?
      cards.all?(&:valid?)
    end

  end
end
