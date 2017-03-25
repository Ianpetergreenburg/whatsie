get '/recipes/random' do
  if session_user
    @recipes = Recipe.newyorktimes(rand(119).to_s)
    erb :'/recipes/show'
  else
    erb :'404', locals: {message: 'Please Login To Look For New Recipes'}
  end
end

post '/recipes' do
  @recipe = Recipe.find_or_create_by(params[:recipe])
  p params[:recipe][:image_url]
  if session_user
    if @recipe.persisted?
        recipe_book = RecipeBook.create(user_id: session_user_id, recipe_id: @recipe.id)
        if request.xhr?
          if recipe_book.persisted?
            return json message: 'recipe saved!'
          else
            return json message: 'something went wrong, you already have this recipe in your collection'
          end
        end
    end
    redirect '/users/' + session_user_id.to_s
  else
    erb :'404', locals: { message: 'You must be logged in to save a recipe to your recipe book'}
  end
end
