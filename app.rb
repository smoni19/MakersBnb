require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/space'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    "Welcome to MakersBnB"
  end

  run! if app_file == $0
end