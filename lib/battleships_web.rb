require 'sinatra/base'
require 'battleships'
require_relative 'ship'

class BattleshipsWeb < Sinatra::Base
  enable :sessions

  PLAYERS = ['player2', 'player1']

  get '/' do
    erb :index
  end

  set :views, proc {File.join(root,'..','views')}

  get '/name' do
    erb :name
  end

  post '/welcome' do
    if params[:name] != ''
      @player_name = params[:name]
      session['player_name'] = @player_name
      $game ||= Game.new Player, Board
      assign_player unless PLAYERS.empty?
      erb :welcome

    else
      redirect '/name'
    end
  end

  get '/current_game' do
    erb :game
  end

  get '/prepare_to_shoot' do
    erb :shoot
  end

  post '/shoot' do
    @fire_coordinate = params[:fire_coordinate]

    begin
      if session[:player] == 'player1'
        @ship_state = $game.player_1.shoot(@fire_coordinate.to_sym)
      else
        @ship_state = $game.player_2.shoot(@fire_coordinate.to_sym)
      end
    rescue
        @ship_state = 'Cannot shoot Coordinate more than once'
    end



    if $game.has_winner?
      erb :winner
    else
      erb :shoot
    end
  end

  post '/placed_ship' do
    @coordinates = params[:Coordinates]
    @shiptype    = params[:shipTypes]
    @orientation = params[:orientation]
    @available_ships = {'destroyer' => Ship.destroyer,
                        'battleship' => Ship.battleship,
                        'aircraft_carrier' => Ship.aircraft_carrier,
                        'submarine' => Ship.submarine,
                        'cruiser' => Ship.cruiser}

    begin
      if  session[:player] == 'player1'
        $game.player_1.place_ship @available_ships.delete(@shiptype), @coordinates.to_sym, @orientation.to_sym
      else
        $game.player_2.place_ship @available_ships.delete(@shiptype), @coordinates.to_sym, @orientation.to_sym
      end
    rescue

    end
    erb :game
  end


  helpers do

    def winner
      return 'Player 1 wins!' if $game.player_1.winner?
      return 'Player 2 wins!' if $game.player_2.winner?
    end

    def assign_player
      session[:player] = PLAYERS.pop
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
