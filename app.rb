require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :index
  end

  post '/post-space' do
    Space.create(name: params[:name], description: params[:description], email: params[:email], price: params[:price_per_night])
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :spaces
  end

  get '/create_space' do 
    erb :create_space
  end 

  post '/post-account' do 
    redirect '/spaces'
  end 

  run! if app_file == $0
end