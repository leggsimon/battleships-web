require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
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
      $game = Game.new Player, Board
      erb :welcome
    else
      redirect '/name'
    end
  end

  get '/current_game' do
    erb :game
  end

  post '/placed_ship' do
    @coordinates = params[:Coordinates]
    @shiptype    = params[:shipTypes]
    @orientation = params[:orientation]
    # ships_hash = {destoyer => Ship.destoyer}

    $game.player_1.place_ship Ship.battleship, :B4, :vertically

    erb :game
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
