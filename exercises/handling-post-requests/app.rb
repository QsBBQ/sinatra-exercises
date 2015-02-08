require 'sinatra'

require_relative 'db'



get '/' do
  @recipes = Recipe.all
  erb :recipes
end

post '/recipes' do
  #params.inspect This is just for a reminder for me.

  recipe = Recipe.new
  recipe.attributes = ({
                  :created_by => params[:created_by],
                  :title => params[:title],
                  :description => params[:description],
                  :instructions => params[:instructions]
                })
  recipe.save
  redirect("/")
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

get '/recipes/:recipe_id/edit' do
  id = params[:recipe_id]
  @recipe = Recipe.get(id)
  erb :edit_recipe
end

post "/recipes/:recipe_id/update" do
  id = params[:recipe_id]
  #
  recipe = Recipe.get(id)
  #
  recipe.created_by = params[:created_by]
  recipe.title = params[:title]
  recipe.description = params[:description]
  recipe.instructions = params[:instructions]

  recipe.save
  redirect "/recipes/#{id}"
end

post '/recipes/:recipe_id/destroy' do
  id = params[:recipe_id]
  recipe = Recipe.get(id)
  recipe.destroy

  redirect "/"
end
