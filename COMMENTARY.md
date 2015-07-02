GH,

The criticism you received from your interview about this code is
correct, but the person who gave it to you should work on
delivering feedback in a way which can actually have a positive
outcome.

I will attempt to take criticism that this code is poorly
modeled, and that it doesn't follow ruby conventions, and explain what they must have meant by that and how you can improve upon these areas.

Let's start with the easiest of the two.

#### Following Ruby Conventions

My first recommendation is to write yourself a bash script that you use to start a new ruby project.  Use something like the `bundler gem` command which will create a project skeleton for you.  Then just make minor tweaks so that you have your sort of default toolchain available.  Rspec, pry, whatever gems and such you rely on.  

Maybe use something like rubocop, and just run it frequently.  Tools like this will break certain harmless habits, but it is in the interests of good citizenship.

This has the added benefit of demonstrating -- especially when doing a live programming exercise -- that you take consistency seriously, that you automate the boring parts of your work, and sends all sorts of other good signals.

Anyway, a majority of the problems I see in your code would be solved if you take it upon yourself to work inside the constraints of a ruby gem project file structure.   It would encourage you to use modules to namespace and organize your code.  It would encourage you to use patterns for requiring your own dependencies in predictable ways, among a number of other good habits it would just make automatic.  

Shit like this you should not want to think about or do manually or with some homespun shit.  

Your project requires me to use a gem.  Which version of the gem? I have to install it manually.  It isn't hard, of course, but why are you making me think of it at all? 

This is one area, especially, that following Ruby conventions is
important.  It saves you and everyone who uses your code time, and
mental energy, very very early in the game.

**Style and formatting too...**

You should read Github's Ruby style guide, it has some good advice in it.  Ruby is designed to be writeable and readable, so why not let the text breathe a little?  For starters.

### Poor Modeling of the Domain Model 

Let's start with the fact that the `Card` class just can't be used,
at all, unless I'm passing it a valid number. In what
circumstances would this be useful?  

Why would the validation behavior happen in the initialize
method? 

Let's assume that there was a good reason, why is validating the card number not in its own method that gets called from initialize? 

Isn't validating the number a key capability for a `Card` object?

Second - is this a debit card or a credit card? Does the card have a balance or does the Account? 

Modeling object classes in Ruby forces you to be very user centered.  Ask yourself, where will this class be used? A `Card` class could conceivably be used on a web form, in a back end invoicing system. 

This would help you develop a better interface for the Card class.

### Poor Modeling of the data types

How can it be possible that the balance is "ERROR"? Why is the balance a string? How am I going to do math on a string?

```
  def credit(amount)
    unless @balance == "ERROR"
      amount = amount.gsub(/\D/,'').to_i
      balance = @balance.gsub(/\D/,'').to_i
      limit = @limit.gsub(/\D/,'').to_i
      @balance = "$" + (balance - amount).to_s
    end
  end
```

Look at all of the acrobatics you have to go through just to make your currency amounts support math.

Store all of your currency amounts in cents.  There are no fractions of pennies, really.  When you want to display it as currency, use a currency formatter which converts from the numeric value to the display value.

### Poor Modeling of the Interface

The fact that you are using strings to represent balance, and
limit, and other values makes sense in light of the fact that the code that you produced is making the assumption that it is going to be run and output to a Terminal.

**Why is your code making this assumption?**  

This comes back to the convention argument, and the
importance of developing habits which make the decisions you have to make easier for yourself.  

I suspect if you had followed the Ruby gem structure, you would have had a
`bin/card-processor` executable act as the main entry point to your
app.  

This would have encouraged you to model the interface separately from the domain model.  When the app is called from the bin you assume it is a CLI, you detect the TTY, you know to use puts. 

But if you're not being run from the TTY, then your `Card` class can be used more abstractly.

You would have created a Card object whose purpose was not
displaying interface errors, but doing what Cards actually do in the world, which is represent an Account, and make credits or debits to that account.

You would have developed an interface for validating the card.

Your bin script might have been something like:

```
#!/bin/bash

require 'card-processor'

# don't actually do this, you would want
# to use a proper CLI arguments parser

card_number, expiration, cvv = ARGV

card = CardProcessor::Card.new(card_number, expiration, argv)

if card.valid?
  puts "Shit is valid"
else
 puts "Nah."
end
```

The best part about this is you likely would have done these things
naturally without being aware of it, because the conventions and
patterns you follow make doing the right thing take less effort. 

# Conclusion

1) Rely on conventions, constraints, and automation to eliminate
certain decisions from your process, it will make make doing the right thing require less effort. Whether it is in code formatting, file structure organization, or many other areas you need to make decisions about, this will go a long way.

Conserve the mental energy you have for the creative problems you will face, like domain and interface modeling.  It isn't easy.

2) Separate your concerns.  Displaying errors is a user interface and reporting function. Detecting errors is a business logic function. 

They don't depend on one another in theory, so keep them separate in practice. 

3) **Don't be discouraged.**  I understand you thought this code was good, and the fact that it actually isn't does not take away from the fact that it still represents and improvement for you relative to where you were last week.  When you look back on this in a few months you will most likely laugh.  This is a great and beautiful thing.


#### In fact this is the only thing that matters.  Be better than you were last week.

You'll never stop learning, improving, correcting your
mistakes and discovering new ways of doing things.  

That is the beauty of this job and what makes it so utterly addictive.

Keep doing your thing, and reach out any time for help

JS
