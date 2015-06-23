require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  set :views, proc {File.join(root,'..','views')}

  get '/name' do
    erb :name
  end

  get '/welcome' do
    @player_name = params[:name]
    erb :welcome
  end





  # start the server if ruby file executed directly
  run! if app_file == $0
end
