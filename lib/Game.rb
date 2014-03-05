class Game
  attr_reader :computer_players, :human_players, :dealer, :deck, :setup_hash
  def initialize(setup_hash)
    @setup_hash = setup_hash
    @split_allowed = setup_hash["split_allowed"]
    @double_down_allowed = setup_hash["double_down_allowed"]
    @das_allowed = setup_hash["das_allowed"] #das = double after split
    @human_players = [] # array of player objects
    @computer_players = [] #array of player objects
    @dealer = Dealer.new
    @deck = Deck.new.shuffle!
  end

  def player_setup!(num_humans, num_bots)
    # return "error" if num_humans + num_bots > 7 
    num_humans.times do
      @human_players << Player.new("Human Player #{Player.count+1}")
    end

    num_bots.times do
      @computer_players << Player.new("Computer Player #{Player.count+1}")
    end

    nil
  end

  def first_two_cards!
    2.times {
      @human_players.each do |player|
        player.hand.hit! deck
      end

      @computer_players.each do |player|
        player.hand.hit! deck
      end

      @dealer.hand.hit! deck
    }
  end



  def split_allowed?
    @split_allowed
  end

  def double_down_allowed?
    @double_down_allowed
  end

  def das_allowed? 
    @das_allowed
  end

  def computer_players_exist?
    @computer_players.length > 0
  end

  def number_of_computer_players
    @computer_players.length
  end
end
