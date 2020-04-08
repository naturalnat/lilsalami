require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'alittlesalami'
    use Rack::Flash
  end

  helpers do

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def is_logged_in?(session)
      !!session[:user_id]
    end
  end

  get '/' do
      erb :index
  end
end
