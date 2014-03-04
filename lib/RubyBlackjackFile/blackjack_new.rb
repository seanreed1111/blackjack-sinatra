require './Game'
require './SD-H17-noDAS.rb' #contains Rules
require 'debugger'

#make sure you account for what happens if you run out of cards mid-deal

#1000.times {  ###this is for testing purposes ####

  game = Game.new(Rules.new.load!)

  puts "Blackjack! How many Human players?"
  num_humans = 0 #####gets.chomp.to_i

  puts "Blackjack! How many bot players?(max #{7-num_humans})"
  num_bots = 7#gets.chomp.to_i

  game.player_setup!(num_humans, num_bots)
  game.first_two_cards! #distributes cards to all players AND dealer. 


   puts "Great! we have #{Player.count} players"
   puts "Let's deal! The dealer shows "

  puts "#{game.dealer.hand.first_card}"
  puts ""
  puts "The players have the following cards:"

  game.human_players.each do |player|
    puts "#{player.name} "
    player.hand.cards.each do |card|
        print "#{card.show} "
    end
    puts "Initial Total is #{player.hand.total}."
  end

  game.computer_players.each do |player|
    puts "#{player.name} "
    player.hand.cards.each do |card|
        print "#{card.show} "
    end
    puts "Intial Total is #{player.hand.total}."
  end

  puts "The dealer shows "
  puts "#{game.dealer.hand.second_card}"


  #loop over all players
  #players should be allowed to
  # 1) Hit
  # 2) Stand
  # 3) Double Down
  # 4) Split

  #only HIT and STAND implemented here for human players
  game.human_players.each do |player|
     while (true) do 
      puts "#{player.name} you have #{player.hand.total}. Would you like to hit or stand?"
      answer = gets.chomp.downcase
      break if answer == "stand"

      if answer == "hit" || answer == "double"

        player.hand.hit! game.deck

        if player.hand.busted?
          print "sorry, you busted, you have "
            player.hand.cards.each do |card|
                print "#{card.show} "
            end
          puts
        end
      end

      break if player.hand.busted? || answer == "double"
    end
  end

    #loop over all bots
    #bots should be allowed to
    # 1) Hit
    # 2) Stand
    # 3) Double Down
    # 4) Split

   #BOTS IMPLEMENTED HERE
  if game.computer_players_exist? 
    game.computer_players.each do |player|
       while (true) do 
        puts "#{player.name} has #{player.hand.total}."
        answer = player.computer_play!(game.setup_hash, game.dealer.hand.second_card)
        print"#{player.name} decides to #{answer}\n"

        break if answer == "stand"

        if answer == "hit" || answer == "double"

          player.hand.hit! game.deck

          if player.hand.busted?
            puts "sorry, you busted, you have "
              player.hand.cards.each do |card|
                  print "#{card.show} "
              end
            puts
          end
        end
        break if player.hand.busted? || answer == "double"
      end
    end
  end

  puts



  #dealer's rules: must hit soft 17
  #                must stand on hard 17 or higher
  #                must hit everything else

  while (true) do
    dealer_total = game.dealer.hand.total
    puts "dealer_total = #{dealer_total} at beginning of while loop"
    break if dealer_total >= 18
    break if dealer_total == 17  && !game.dealer.hand.has_ace? #hard 17
    game.dealer.hand.hit! game.deck
  end
  puts "Dealer has"
  game.dealer.hand.cards.each do |card|
    print "#{card.show} "
  end
  puts "dealer_total is #{dealer_total}"

  dealer_busted = game.dealer.hand.busted?

  game.human_players.each do |player|
    next if player.hand.busted?
    if dealer_busted || (player.hand.total > dealer_total)
      puts "#{player.name} wins! "
      player.hand.win = true
      #adjust player's winnings by the amount of the bet
    end 
  end

  game.computer_players.each do |player|
    next if player.hand.busted?
    if dealer_busted || (player.hand.total > dealer_total)
      puts "#{player.name} wins! "
      player.hand.win = true
      #adjust player's winnings by the amount of the bet
    end 
  end
  puts

#} ##### end of testing loop