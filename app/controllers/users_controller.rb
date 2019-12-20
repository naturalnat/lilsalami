class UsersController < ApplicationController
  get '/signup' do
    redirect to '/allcats' if Helpers.is_logged_in?(session)
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == '' || params[:password] == '' || params[:email] == ''
      flash[:error] = 'Username, email and password fields must be filled'
      redirect to '/signup'
    elsif User.find_by(email: params[:email])
      flash[:error] = 'E-mail already in use. Please choose another'
    elsif User.find_by(username: params[:username])
      flash[:error] = 'Username already in use. Please choose another'
      redirect to '/signup'

    else
      @user = User.create(firstname: params[:firstname], lastname: params[:lastname], username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect to '/create'
    end
  end

  get '/login' do
    redirect to '/allcats' if Helpers.is_logged_in?(session)
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session['user_id'] = @user.id
      redirect to '/allcats'
    else
      flash[:error] = 'Invalid username or password. Please login.'
      redirect to '/login'
    end
  end

  get '/logout' do
    session.destroy
    redirect to '/'
    redirect to '/allcats' if Helpers.is_logged_in?(session)
  end
end
