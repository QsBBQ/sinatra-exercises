require 'sinatra'
require_relative 'db'

get '/' do
  @recipes = Recipe.all
  erb :recipes
end

get '/recipes/:recipe_id' do
  if @recipe = Recipe.get(params[:recipe_id])
    erb :show_recipe
  else
    404
    # WHAT IS THIS MADNESS?!
    # https://en.wikipedia.org/wiki/404_Error
    # http://www.sinatrarb.com/intro.html#Return%20Values
  end
end

post '/recipes' do
  "Here is the recipe #{params[:recipe]}"
  @recipe = Recipe.new
  @recipe.attributes = (:id => 1, created_by => "Frank", :title => "Test title", :description => "test", :instructions => "instruct me", :created_at => Time.now)
  @recipe.save
end

