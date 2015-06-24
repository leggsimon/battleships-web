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
    ships_hash = {'destroyer' => Ship.destroyer,
                  'battleship' => Ship.battleship,
                  'aircraft_carrier' => Ship.aircraft_carrier,
                  'submarine' => Ship.submarine,
                  'cruiser' => Ship.cruiser}

    $game.player_1.place_ship ships_hash[@shiptype], @coordinates.to_sym, @orientation.to_sym

    erb :game
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
