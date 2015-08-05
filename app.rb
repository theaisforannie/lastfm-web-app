require 'sinatra'
require 'dotenv'

Dotenv.load

get '/' do 
  erb :index
end

get '/callback' do
  "welcome back"
end