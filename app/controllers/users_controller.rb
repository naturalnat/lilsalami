class UsersController < ApplicationController

  get '/signup' do
   redirect to '/allcats' if Helpers.is_logged_in?(session)
   erb :'/users/signup'
 end

  post '/signup' do
      if Helpers.is_logged_in?(session)
        redirect to '/allcats'
      elsif params[:username] == '' || params[:password] == '' || params[:email] == ''
         flash[:error] = 'Username, email and password fields must be filled'
        redirect to '/signup'
      # elsif User.find_by(username: params[:username])
      #   flash[:error] = 'Username taken, please choose another'
      #   redirect to '/signup'

      else
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
        session[:user_id] = @user.id
        redirect to '/'
      end
    end

    get '/login' do
      redirect to '/allcats' if Helpers.is_logged_in?(session)
      erb :'/users/login'
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session['user_id'] = @user.id
        redirect to '/allcats'
      else
        # flash[:error] = 'Invalid username or password. Please login.'
        redirect to '/login'
      end
    end

    get '/logout' do
     if Helpers.is_logged_in?(session)
        session.clear
      redirect to '/'
       else
         redirect to '/allcats'
       end
     end

    # get '/allcats' do
    #   # if Helpers.is_logged_in?(session)
    #     # @user = Helpers.current_user(session)
    #     # @cats = Cat.all
    #     erb :'/cats/all'
    #   # else
    #     # flash[:error] = 'Must be logged in to go to menu'
    #     # redirect to '/login'
    #   end


end
