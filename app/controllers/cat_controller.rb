class CatController < ApplicationController

  get '/create' do
    "salami is a treat"
    erb :'cats/create'
  end


  get '/allcats' do
    @cats = Cat.all
  end

end
