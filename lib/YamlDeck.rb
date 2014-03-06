require 'yaml'

class YamlDeck 
  attr_accessor :cards

  def initialize(path)
    @cards = []
    data = YAML::load(File.open(path))
    data.each do |card_data|
      @cards << YamlCard.new(card_data)
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
end
