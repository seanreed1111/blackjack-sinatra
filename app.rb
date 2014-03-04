require "bundler"
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

class Blackjack < Sinatra::Application

  get "/" do
    haml :index
  end

  get "/blackjack/:num_decks" do
    deck = Deck.new(:num_decks) #need to rewrite deck class
    haml :blackjack
  end
end
