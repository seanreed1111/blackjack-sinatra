class Hand
  attr_reader :cards, :has_ace
  attr_accessor :win
  def initialize()
    @cards = [] #an array of PlayingCard objects
    @has_ace = false
    @win = false
  end

  def clear
    @cards = []
    @has_ace = false
    @win = false

  end

  def total
    count = 0
    @cards.each do |playingcard|
      count += playingcard.value 
    @has_ace = @has_ace || playingcard.is_ace?
    end

    #The playingcard.value of Aces = 1
    #At most one Ace per hand can have value of 11,
    #but this +10 added to count must not make 
    #the player's count go over 21

    if @has_ace
      return count + 10 if count + 10 <= 21 
    end
    return count
  end

  def first_card
    @cards[0].value
  end

  def second_card
    @cards[1].value 
  end
  
  def number_of_cards
    @cards.length
  end

  def busted?
    self.total > 21 
  end

  def has_ace?
    @has_ace
  end

  def double_down

  end

  def split

  end

  def hit!(deck)
    @cards << deck.deal
  end

  def show(&cards)
    @cards.each do |card|
      print "#{card.show} "
    end
    puts
    puts "Total is #{player.hand.total}."
  end
end
