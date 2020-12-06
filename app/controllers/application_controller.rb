class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipe = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do 
    #binding.pry
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
  #binding.pry
    @recipe = Recipe.find(params[:id])
    hash = params[:recipe]
    @recipe.name = hash[:name]
    @recipe.ingredients = hash[:ingredients]
    @recipe.cook_time = hash[:cook_time]
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect '/recipes'
  end
end
