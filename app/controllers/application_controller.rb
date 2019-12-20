# frozen_string_literal: true

require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'alittlesalami'
    use Rack::Flash
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to '/allcats'
    else
      erb :index
    end
  end
end
