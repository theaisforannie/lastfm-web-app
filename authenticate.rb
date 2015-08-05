require 'dotenv'
require_relative 'lastfm'
require_relative 'variables'

Dotenv.load

class Auth
  def initialize

  end

  def self.construct_auth_url
    SharedVariables::LASTFM_AUTH_ROOT + ENV['LASTFM_API_KEY'].to_s + "&cb=" \
    + SharedVariables::CALLBACK_URL
  end

  def set_token(params)
    @auth_token = params['token']
  end
end
