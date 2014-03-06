class Hand
  attr_reader :cards, :has_ace
  attr_accessor :win
  def initialize()
    @cards = [] #an array of YamlCard objects
    @has_ace = false
    @win = false
    @busted = false
  end

  def clear
    @cards = []
    @has_ace = false
    @win = false
    @busted = false

  end

  def total
    count = 0
    @cards.each do |yamlcard|
      count += yamlcard.value 
    @has_ace = @has_ace || yamlcard.is_ace?
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
    self.total > 21 ? @busted = true : @busted=false
  end



  def has_ace?
    @has_ace
  end

  def hit!(deck)
    @cards << deck.deal
  end

  def double_down

  end

  def split

  end
end
