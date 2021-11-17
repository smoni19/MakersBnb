require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'
require_relative './lib/account'

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
    @name = session[:name]
    erb :spaces
  end

  get '/login' do
    erb :login
  end

  post '/post-login' do
    @user = Account.login(email: params[:email], password: params[:password])
    session[:name] = @user.name
    redirect '/spaces'
  end

  get '/create_space' do 
    erb :create_space
  end 

  post '/post-account' do 
    Account.create(name: params[:name], email: params[:email], password: params[:password])
    session[:name] = params[:name]
    redirect '/spaces'
  end 

  run! if app_file == $0
end