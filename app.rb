require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/spaces' do 
    erb :spaces
  end

  get '/create_space' do 
    erb :create_space
  end 

  run! if app_file == $0
end