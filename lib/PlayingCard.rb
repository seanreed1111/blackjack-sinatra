class PlayingCard
    attr_accessor :suit, :value, :rank,:image_url

    def initialize(suit, rank, value)
        @suit = suit
        @rank = rank
        @value = value
    end

    def show
        print" #{self.rank} of #{self.suit}" 
    end

    def is_ace?
        @rank == "A"
    end

end