require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/start' do
    @name = params[:name]
  	erb :start
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

  set :views, proc { File.join(root, '..', 'views')}
end
