# frozen_string_literal: true

class CatController < ApplicationController
  get '/create' do
    erb :'cats/create'
  end

  post '/create' do
    user = current_user(session)

    if user.nil?
      redirect to '/;'
    elsif params[:name].empty?
      flash[:error] = "Please enter all fields."
      redirect to '/create'
    else
      params[:image] = params[:image].reject { |c| c.empty? }
      params[:image] = params[:image][-1]
      @cat = user.cats.create(params)
      flash[:message] = "Successfully created #{@cat.name}!"
      redirect to "/cats/#{@cat.id}"
   end
  end

  get '/cats' do
    if !is_logged_in?(session)
      redirect to '/'
    else
    @user_id = current_user(session).id
    @cats = Cat.all
    erb :'cats/all'
  end
end

  get '/cats/:id' do
    if @cat = Cat.find(params[:id])
    else redirect to '/cats'
  end
    erb :'cats/catid'
  end

  get '/cats/:id/edit' do
    @cat = Cat.find(params[:id])
    @cat
    erb :'/cats/edit'
  end

  patch '/cats/:id' do
    @cat = Cat.find(params[:id])
    if @cat.user_id.to_i == current_user(session).id
      @cat.update(params[:cat])
      @cat.save
      flash[:message] = 'Successfully changed name!'
      redirect to '/cats'
    else
      redirect to '/'
    end
  end

  delete '/cats/:id/delete' do
    if !is_logged_in?(session)
      redirect to '/'
    elsif @cat = Cat.find(params[:id])
      @cat.delete if @cat.user == current_user(session)
      flash[:message] = 'Cat deleted :('
      redirect to '/cats'
    end
  end

  get '/cats/:id' do
    if @cat = params[:id]
    erb :'cats/catid'
    redirect to '/'
  end
end

  get '/cats/:id/feed' do
    @cat = Cat.find(params[:id])

    if @cat.counter == 10 && (@cat.last_update <= 1.day.ago && @cat.last_update <= Time.now)
         @cat.counter = 0
         @cat.last_update = DateTime.now
         flash[:message] = "Time to feed gato again."
    elsif @cat.counter < 10
        @cat.update_attributes(counter: @cat.counter + 1)
        @cat.update_attributes(last_update: DateTime.now)
    else
        flash[:message] = "#{@cat.name} has been fed #{@cat.counter} times!"
      end
      @cat.save
    erb :'cats/feed'
  end
end
