class Dealer
  attr_reader :hand

    def initialize
      @hand = Hand.new
    end

    def clear
      @hand = []
    end

    def play!
      #move dealer functionality here
      #separate initial deal from hit/stand decision
    end
end