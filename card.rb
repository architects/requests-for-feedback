require 'luhn'

class Card
  attr_accessor :name, :card_number, :balance, :limit, :orig_limit
  def initialize(name, card_number, limit)
    @name = name
    @card_number = card_number
    if Luhn.valid? @card_number
      @balance = "$0"
    else
      @balance = "ERROR"
    end
    @limit = limit
    @orig_limit = limit
  end

  def charge(amount)
    unless @balance == "ERROR"
      amount = amount.gsub(/\D/,'').to_i
      balance = @balance.gsub(/\D/,'').to_i
      limit = @limit.gsub(/\D/,'').to_i
      if amount < limit
        @balance = "$" + (balance + amount).to_s
        @limit =  "$" + (limit - amount).to_s
      end
    end
  end

  def credit(amount)
    unless @balance == "ERROR"
      amount = amount.gsub(/\D/,'').to_i
      balance = @balance.gsub(/\D/,'').to_i
      limit = @limit.gsub(/\D/,'').to_i
      @balance = "$" + (balance - amount).to_s
      @limit = "$" + (limit + amount).to_s
      # this makes sure that you never go over your original limit, because
      # that would be absurd
      if @limit > @orig_limit
        @limit = @orig_limit
      end
    end
  end
end
