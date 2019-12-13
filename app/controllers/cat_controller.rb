class CatController < ApplicationController

  get '/create' do
    erb :'cats/create'
  end

  get '/allcats/' do
    @cats = Cat.all
    erb :'cats/all'
  end

  # post '/create' do
   # user = Helpers.current_user(session)
   # if user.nil?
   #   redirect to '/login'
   # elsif params[:cat][:name].empty?
     # flash[:error] = 'Book title field must be filled'
     # redirect to '/allcats'
   # else
   #   @cats = Cat.create(params[:name])
   #   # @cats[:name] = name
   #   @cats.save
   # end

 #   redirect to "/allcats/#{@cats.id}"
 # end

 post '/create' do
    @cats = Cat.create(params)

    # if !params["name"].empty?
    #  @cat.user = User.create(name: params["username"]["name"])
    # end

    @cats.save

    redirect to "allcats/#{params[:name]}"
  end

  get '/allcats/:name' do
    "meow"
  end


end
