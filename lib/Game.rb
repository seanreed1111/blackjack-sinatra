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
    @deck = YamlDeck.new.shuffle!
    run!
  end

  def number_of_computer_players
    @computer_players.length
  end


  def player_setup!(num_humans, num_bots)
    # return "error" if num_humans + num_bots > 7 
    num_humans.times do
      @human_players << Player.new("Human Player #{Player.count+1}")
    end

    number_of_computer_players.times do
      @computer_players << Player.new("Computer Player #{Player.count+1}")
    end

    
    nil
  end

  def first_two_cards!
    2.times {
      @human_players.each do |player|
        player.hand.hit! @deck
      end

      @computer_players.each do |player|
        player.hand.hit! @deck
      end

      @dealer.hand.hit! @deck
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

  def run_computer_players!
    #let computer make hit/stand decisions. 
    #need Timeout between each players
      game.computer_players.each do |player|
     while (true) do 
      puts "#{player.name} has #{player.hand.total}."
      answer = player.computer_play!(self.setup_hash, self.dealer.hand.second_card)
      print"#{player.name} decides to #{answer}\n"

      break if answer == "stand"

      if answer == "hit" || answer == "double"
        player.hand.hit! @deck   ###hit has to trigger some javascript call##
      end
      break if player.hand.busted? || answer == "double"
    end
  end

  def run_dealer!
    while (true) do
      dealer_total = @dealer.hand.total
      break if @dealer.hand.busted?
      break if dealer_total >= 18
      break if dealer_total == 17  && !@dealer.hand.has_ace? #hard 17
      @dealer.hand.hit! @deck    ###hit has to trigger some javascript call##
    end
  end

  def run!
    player_setup!(0,7) #hardcoded, no humans and seven bots

    first_two_cards!
    run_computer_players! #computer players make hit/stand decision
    run_dealer! #dealer makes hit/stand decisions
    find_winning_hands(@computer_players)
    pay_winning_hands!(@computer_players)
  end

  def find_winning_hands(players_array)
    players_array.each do |player|
    next if player.hand.busted == true
    if @dealer.hand.busted == true || (player.hand.total > @dealer.hand.total)
      player.hand.win = true
    end 
  end

  def pay_winning_hands(players_array)
    #adjust player's bank winnings by the amount of the bet
    players_array.each do |player|
      if player.hand.win == true
        player.change_cash(player.bet*2)
      end
    end
  end
end
