require 'sinatra/base'
require 'battleships'
require_relative 'ship'

class BattleshipsWeb < Sinatra::Base
  enable :sessions

  PLAYERS = ['player1', 'player2']

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
    if session[:player] == 'player1'
      @ship_state = $game.player_1.shoot(@fire_coordinate.to_sym)
    else
      @ship_state = $game.player_2.shoot(@fire_coordinate.to_sym)
    end

    erb :shoot
  end

  post '/placed_ship' do
    @coordinates = params[:Coordinates]
    @shiptype    = params[:shipTypes]
    @orientation = params[:orientation]
    if  session[:player] == 'player1'
      $game.player_1.place_ship Ship::SHIPS[@shiptype], @coordinates.to_sym, @orientation.to_sym
    else
      $game.player_2.place_ship Ship::SHIPS[@shiptype], @coordinates.to_sym, @orientation.to_sym
    end
    erb :game
  end

  helpers do

    def assign_player
      session[:player] = PLAYERS.pop
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
