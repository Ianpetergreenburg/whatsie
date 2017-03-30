

class RecipesController < ApplicationController
  def index
    100.times do |i|
      UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + i.to_s, 'nyt', i)
    end
  end

  def random
    RecipeUrl.next_to_scrape(100).each do |recipe_url|
      NytScraperJob.perform_later(recipe_url)
    end
    @recipes = Recipe.newyorktimes(rand(119).to_s)
    @recipe = Recipe.new
  end

  def create
  	@recipe = Recipe.where(url: recipe_params[:url]).first_or_create(recipe_params)
  	if @recipe.valid?
      if helpers.current_user.recipes.include? @recipe
        @recipe_book = RecipeBook.find_by(recipe_id: @recipe.id, user_id: current_user_id).destroy
        respond_to do |format|
          format.json { render json: { message: 'Removed!'} }
        end
      else
        RecipeBook.create(recipe_id: @recipe.id, user_id: current_user_id)
        respond_to do |format|
          format.json { render json: { message: 'Added!'} }
        end
      end
  	else
      respond_to do |format|
        format.json { render json: { message: 'Something Went Wrong!'} }
      end
  	end
  end

  private
  def recipe_params
  	params.require(:recipe).permit(:url, :image_url, :instructions, :ingredients, :name)
  end
end
