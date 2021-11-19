require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'
require_relative './lib/account'
require_relative './lib/booking'
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

  get '/my_spaces' do 
    session[:id] = Account.get_id(email: @email = session[:email])
    @my_spaces = Space.my_spaces(account_id: session[:id])
    
    @my_space_id = @my_spaces.map do |space|
      space_id = Space.get_id(email: space.email, name: space.name)
      Booking.get_space_booking(space_id: space_id)
    end
    @request_spaces = @my_spaces.zip(@my_space_id)

    @name = session[:name]
    erb :my_spaces
  end 

  get '/my_booking_history' do
    @my_bookings = Booking.get_my_booking(account_id: session[:id])
    @name = session[:name]
    erb :my_booking_history
  end

  post '/post-booking-request' do
    session[:space_name] = params[:name]
    session[:space_email] = params[:email]
    redirect '/booking'
  end

  get '/booking' do
    @name = session[:name]
    erb :booking
  end

  post '/post-booking-date' do
    session[:space_date] = params[:date]
    space_id = Space.get_id(email: session[:space_email], name: session[:space_name])
    approved = Booking.find_approved_bookings(date: session[:space_date], space_id: space_id)
    if approved
      redirect '/booking-failed'
    else
      Booking.create(date: session[:space_date], approval_status: "pending", account_id: session[:id], space_id: space_id)
      redirect '/confirmation'
    end
  end

  get '/confirmation' do
    erb :confirmation
  end

  get '/booking-failed' do
    erb :booking_failed
  end

  post '/post-status' do
    booking_id = Booking.get_id(space_id: params[:space_id], account_id: params[:account_id], date: params[:date])
    Booking.edit_status(booking_id: booking_id, new_status: params[:approval_status])
    if params[:approval_status] == "Approved"
      Booking.decline_pendings(booking_id: booking_id, space_id: params[:space_id], date: params[:date])
      flash[:approval] = "Booking for #{params[:date]} has been <span>approved!</span>"
    elsif params[:approval_status] == "Declined"
      flash[:decline] = "Booking for #{params[:date]} has been <span>declined!</span>"
    end
    redirect '/my_spaces'
  end

  run! if app_file == $0
end