class UsersController < ApplicationController

  get '/signup' do
    redirect to '/cats' if is_logged_in?(session)
    erb :'/users/signup'
  end

  post '/signup' do
      @user = User.new(firstname: params[:firstname], lastname: params[:lastname], username: params[:username], password: params[:password], email: params[:email])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/cats'
      else
      flash[:error] = @user.errors.full_messages.join(". ")
      redirect to '/signup'
      end
  end

  get '/login' do
    redirect to '/cats' if is_logged_in?(session)
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session['user_id'] = @user.id
      redirect to '/cats'
    else
      flash[:error] = 'Invalid username or password. Please login.'
      redirect to '/login'
    end
  end

  get '/logout' do
    session.destroy
    redirect to '/'
  end
end
