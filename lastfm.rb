require 'digest'
require 'uri'
require 'net/http'
require 'json'
require_relative 'authenticate'

class LastFM
  def initialize()
  end

  # api_request calls this (and gives it a method)
  def request_params(method)
    @request_params = {
      :api_key => ENV['LASTFM_API_KEY'],
      :token => @auth_token,
      :api_sig => nil,
      :method => method,
      :format => 'json'
    }
  end


  def api_request(method, verb)
    request_params(method)

    uri = URI('http://ws.audioscrobbler.com/2.0/')

    if verb == :get
      uri.query = URI.encode_www_form(@request_params)
      response = Net::HTTP.get_response(uri)
    elsif verb == :post
      response = Net::HTTP.post_form(uri, params)
    else
      raise "whomp that is not a valid method"
    end

    http_response_data = JSON.parse(response.body)
  end

  # request_params(method) calls this
  def create_signature
    signature = ""
    @request_params.keys.sort do |k|
      if k != :api_sig || k != :format
        signature << k.to_s << @request_params[k].to_s
      end
    end
    @request_params[:api_sig] = md5(signature + ENV['LASTFM_SECRET'])
  end

  # create_signature calls this
  def md5(string)
    md5 = Digest::MD5.new
    md5 << string
    md5.hexdigest
  end
end