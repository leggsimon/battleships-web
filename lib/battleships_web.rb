require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/start' do
    @name = params[:name]
  	erb :start
  end

  get '/game' do
    $game = Game.new(Player, Board)
    ship_placer($game)
    erb :game
  end

  get '/fire' do
    coordinate = params[:coordinate]
    @state = $game.player_1.shoot coordinate.to_sym

    if $game.has_winner?
      check_winner
      erb :winner
    else
      erb :fire
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

  set :views, proc { File.join(root, '..', 'views')}

  def ship_placer(game)
    game.player_2.place_ship Ship.cruiser, :E6
    game.player_2.place_ship Ship.submarine, :I2 , :vertically
    game.player_2.place_ship Ship.battleship, :A4
    game.player_2.place_ship Ship.destroyer, :E8
    game.player_2.place_ship Ship.aircraft_carrier, :J3 , :vertically
  end

  def check_winner
    if $game.player_1.winner?
      @winner = "YOU WIN!"
    end
  end
end
