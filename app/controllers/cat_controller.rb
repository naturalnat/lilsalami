class CatController < ApplicationController
  get '/create' do
    erb :'cats/create'
  end

  post '/create' do
    user = Helpers.current_user(session)
    if user.nil?
      redirect to '/'
    elsif params[:name].empty?
      flash[:error] = 'Please name your cat'
      redirect to '/create'
    else

      @cats = Cat.create(params)
      @cats.user_id = session['user_id']
      @cats.save

      flash[:message] = 'Successfully created cat!'
      redirect to "/allcats/#{params[:name]}"
   end
  end

  get '/allcats/:name' do
    @catname = params[:name]

    erb :'cats/catname'
  end

  get '/allcats/:name/edit' do
    @cat = Cat.find_by_name(params[:name])
    @cat
    erb :'/cats/edit'
  end

  get '/allcats' do
    @user_id = Helpers.current_user(session).id
    @cats = Cat.all
    erb :'cats/all'
  end

  patch '/allcats/:name' do
    @cat = Cat.find_by_name(params[:name])

    if @cat.user_id.to_i == Helpers.current_user(session).id

      @cat.update(params[:cat])
      @cat.save
      flash[:message] = 'Successfully changed name!'
      redirect to '/allcats'
    else
      redirect to '/'
    end
  end

  delete '/allcats/:name/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    elsif @cat = Cat.find_by_name(params[:name])
      @cat.delete if @cat.user == Helpers.current_user(session)
      flash[:message] = 'Cat deleted :('
      redirect to '/allcats'
      end
  end

  get '/allcats/:name' do
    @catname = params[:name]
    erb :'cats/catname'
  end

  get '/thankyoubrother' do
    erb :'cats/thankyou'
  end
end
