require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'
require_relative './lib/account'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  register Sinatra::Flash


  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/post-login' do
    @user = Account.login(email: params[:email], password: params[:password])
    if @user 
      session[:name] = @user.name
      session[:email] = @user.email
      session[:id] = Account.get_id(email: @user.email)
      redirect '/spaces'
    else 
      flash[:message] = "Unsuccessful! Please check email or password :("
      redirect '/login'
    end 
  end

  post '/post-account' do 
    @user = Account.create(name: params[:name], email: params[:email], password: params[:password])
    session[:name] = @user.name
    session[:email] = @user.email
    session[:id] = Account.get_id(email: @user.email)
    redirect '/spaces'
  end

  get '/create_space' do
    if session[:email]
      @email = session[:email]
      @id = session[:id]
      erb :create_space
    else
      erb :index
    end
  end 

  post '/post-space' do
    Space.create(name: params[:name], description: params[:description], email: params[:email], price: params[:price_per_night], account_id: params[:account_id])
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Space.all
    @name = session[:name]
    erb :spaces
  end

  run! if app_file == $0
end