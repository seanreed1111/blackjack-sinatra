require './Hand'
require './PlayingCard'

#the Game class knows whether the player is allowed to double down or split in any situation
#Game must enforce to player whether that is an allowed or unallowed action
class Player
  attr_accessor :name, :cash, :hand, :win

  def self.count
    ObjectSpace.each_object(self).count
  end
  
  def initialize(name)
    @name = name
    @hand = Hand.new
    @split = false #has player split yet?
    @number_of_splits = 0
    @double_down = false #has player doubled down yet?
    @win = false
  end

  def clear
    @hand = Hand.new
    @split = false
    @number_of_splits = 0
    @double_down = false
    @win = false
  end

  def winnings(amount=0)
    @cash += amount
  end

  def has_already_split?
    @split
  end

  def has_already_doubled_down?
    @double_down
  end

  def split!
    #split the player's current hand into two hands
    @number_of_splits += 1 
    @split = true
  end

  def double_down!
    #double the player's bet and take one card
    @double_down = true
  end


  def preprocess!(setup)
    table_name = nil

    total = self.hand.total
    if self.hand.has_ace
      (total == 12 && setup["split_allowed"] ) ? table_name = "split_table" : table_name = "soft_hand_table"
    elsif self.hand.first_card == self.hand.second_card
        if total == 8 || total == 10 || (!setup["split_allowed"]) #no splits allowed
          table_name = "hard_hand_table" 
        else
          table_name = "split_table" 
        end
    else
      table_name = "hard_hand_table"
    end

    table_name
  end



  #AI basic strategy generator 
  # Player#computer_play! returns "hit", "stand", "dobule", or "split"
  def computer_play!(setup, dealer_up_card_value)   
    answer = nil
    lookup_value = ""
    if self.hand.number_of_cards == 2
      table_name = self.preprocess!(setup)
    elsif self.hand.has_ace?
      table_name = "soft_hand_table"
    else
      table_name = "hard_hand_table"    
    end

    if table_name == "hard_hand_table" || table_name == "soft_hand_table"
      lookup_value = self.hand.total #lookup_value should be integer
    else
      #table_name is split_table. #lookup_value should be string, e.g. "22" or 33" 
        lookup_value = self.hand.first_card.to_s + self.hand.second_card.to_s

    end

    #answer_key will be set to "h", "s", "d", or "p"
    answer_key = setup[table_name][lookup_value][dealer_up_card_value]

    answer = setup[answer_key] #"hit", "stand", "double", or "split"
    answer = "hit" if answer == "split"  ###testing only###

    answer
  end

#testing stubs
def preprocess_stub! (setup_hash)
    #pick at random
    setup_hash[["split_table", "hard_hand_table", "soft_hand_table"].sample] 
  end
  
  #stub. method should ultimately return "HIT", "STAND", "DOUBLE", or "SPLIT"
  def computer_play_stub!(setup, dealer_up_card_value)   
    #AI basic strategy generator
    table = self.preprocess!(setup) #this tells you the table in setup_hash needed in all scenarios
    answer = ["hit", "stand"].sample
  end
end