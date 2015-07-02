module CardProcessor
  class Card
    attr_accessor :number,
                  :security_code,
                  :expiration,
                  :errors

    def initialize(attributes={})
      @number         = attributes.fetch(:number) { add_error(:number, "Card number is missing") }
      @security_code  = attributes.fetch(:number) { add_error(:number, "Security code is missing") }
      @expiration     = attributes.fetch(:expiration) { add_error(:number, "Expiration is missing") }
      @limit          = attributes.fetch(:limit, nil)

      @errors = {}
    end

    def valid?
      validate && @errors.empty?
    end

    def validate
      return false unless @errors.empty?

      # TODO
      # Implement validation logic, perform a remote lookup
      # to validate whether the card is valid.
    end

    # Same as validate but will throw an error if the card is invalid
    def validate!
      raise 'Invalid card' unless validate
    end

    def account
      lookup_account_by_card_number(AccountLookupService.find_account_by_card_number(self.number))
    end

    def credit(amount_in_cents)
      account.credit(amount_in_cents, transaction_description, transaction_id)
    end

    def debit(amount_in_cents, transaction_description, transaction_id)
      account.debit(amount_in_cents, transaction_description, transaction_id)
    end

    def current_balance
      account.current_balance
    end

    def available_balance
      account.limit - account.current_balance
    end

    def limit
      account.limit
    end

    private

      def add_error(field, message)
        @errors[field.to_sym] = message
      end
  end
end
