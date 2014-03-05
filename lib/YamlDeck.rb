require 'yaml'

class YamlDeck 
  attr_reader :cards

  def initialize(path)
    @cards = []
    data = YAML::load(File.open(path))
    data.each do |card_data|
      @cards << YamlCard.new(card_data)
    end
  end
  
end