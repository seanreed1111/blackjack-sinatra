require './PlayingCard'
class Deck
    SUITS = [:clubs, :hearts, :diamonds, :spades]
    RANKS = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    VALUES = [1,2,3,4,5,6,7,8,9,10,10,10,10]

    attr_accessor :cards

    def initialize
        @cards = [] #an array of PlayingCard objects
        SUITS.each do |suit|
            RANKS.each_with_index do |rank, i|
                @cards << PlayingCard.new(suit, rank, VALUES[i])
            end
        end
    end

    def shuffle!
        n = @cards.length
        for i in 0...n
            r = rand(n-i)+i
            @cards[r], @cards[i] = @cards[i], @cards[r]
        end
        self
    end

    def shuffle
        dup.shuffle!
    end

    def deal
        @cards.pop
    end

    def remaining
        @cards.length
    end

    def deal_all
        number_of_cards = @cards.length
        number_of_cards.times do 
           deal
        end
    end
end