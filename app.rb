require 'sinatra'
require 'dotenv'
require_relative 'variables'
require_relative 'authenticate'
require_relative 'lastfm'

Dotenv.load

auth = Auth.new

get '/' do 
  erb :index
end

get '/callback' do
  auth.set_token(params)

  new_session = LastFM.new
  new_session.api_request("auth.getSession", :get)



  "welcome back"
end