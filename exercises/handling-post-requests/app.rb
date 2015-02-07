require 'sinatra'

require 'sinatra/flash'
require_relative 'db'

# require 'rack-flash'
# require 'sinatra/redirect_with_flash'

#need to understand what this does.
enable :sessions
#use Rack::Flash, :sweep => true

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

post '/recipes/:recipe_id' do
  #params.inspect
  recipe = Recipe.find(params[:id])
  recipe.update({
                   :created_by => params[:created_by],
                   :title => params[:title],
                   :description => params[:description],
                   :instructions => params[:instructions]
                 })
  redirect "/"
end

get '/recipes/:recipe_id/edit' do
  @recipe = Recipe.get(params[:recipe_id])

  erb :edit_recipe
end

post '/recipes/<%=@recipe.id%>' do
  #Lots of guessing not sure why this was needed?
end

post '/recipes' do
  #randomly got it working by just guessing :)
  #randomly guessing and searching
  #Or the session last night was great I think I finally connected the dots with great teaching and examples!
  #The code feedback and sessions have been great and the most valuable for me. Slack is mixed in my opinion and have been more causes for confusion for me.
  #But probably because when I get stuck I have a hard time articulating. I hope to get better at this.
  #Overall Love the course so far.

  #params.inspect This is just for a reminder for me.

  #Ok option 1 on the Recipe class built for datamapper use the create class method which is a an alias for .new and .save
  # Recipe.create({
  #                 :created_by => params[:created_by],
  #                 :title => params[:title],
  #                 :description => params[:description],
  #                 :instructions => params[:instructions]
  #               })
  #or option 2 with the Recipe class use the methods .new and .save
  # recipe = Recipe.new({
  #                 :created_by => params[:created_by],
  #                 :title => params[:title],
  #                 :description => params[:description],
  #                 :instructions => params[:instructions]
  #               })
  # recipe.save

  #option 3 using a attributes and added flash messages.
  recipe = Recipe.new
  #I still need to follow up on what magic makes the create time or if this is just built into data mapper.
  recipe.attributes = ({
                  :created_by => params[:created_by],
                  :title => params[:title],
                  :description => params[:description],
                  :instructions => params[:instructions]
                })
  #Tried to add some save messages tried a couple ways without success.
  if recipe.save
    @success = 'Recipe saved successfully! Enjoy your meal!'
    puts @success
    redirect '/'
  else
    @error = 'Failed to save! Turn off the oven.'
    redirect '/'
  end
  redirect("/")
end

