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
      @cat = user.cats.create(params)
      flash[:message] = "Successfully created #{@cat.name}!"
      redirect to "/cats/#{@cat.id}"
   end
  end

  get '/cats' do
    @user_id = Helpers.current_user(session).id
    @cats = Cat.all
    erb :'cats/all'
  end

  get '/cats/:id' do
    @cat = Cat.find(params[:id])
    erb :'cats/catname'
  end

  get '/cats/:id/edit' do
    @cat = Cat.find(params[:id])
    @cat
    erb :'/cats/edit'
  end

  patch '/cats/:id' do
    @cat = Cat.find(params[:id])
    if @cat.user_id.to_i == Helpers.current_user(session).id
      @cat.update(params[:cat])
      @cat.save
      flash[:message] = 'Successfully changed name!'
      redirect to '/cats'
    else
      redirect to '/'
    end
  end


  delete '/cats/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    elsif @cat = Cat.find(params[:id])
      @cat.delete if @cat.user == Helpers.current_user(session)
      flash[:message] = 'Cat deleted :('
      redirect to '/cats'
    end
  end


  get '/cats/:id' do
    @cat = params[:id]
    erb :'cats/catname'
  end


  get '/cats/:id/feed' do
    @cat = Cat.find(params[:id])

    if @cat.counter < 10
      @cat.update_attributes(counter: @cat.counter + 1)
    end
    erb :'cats/feed'
  end


end
