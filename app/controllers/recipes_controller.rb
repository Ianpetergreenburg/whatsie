

class RecipesController < ApplicationController
  def index
    JobLoaderStarterJob.perform_later
    @recipes = Recipe.order("id desc").limit(20)
  end

  def random
    JobLoaderScraperJob.perform_later
    @recipes = Recipe.order("Random()").limit(20)
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end

  def create
  	@recipe = Recipe.where(url: recipe_params[:url]).first_or_create(recipe_params)
    respond_to do |format|
      if @recipe.valid?
        if helpers.current_user.recipes.include? @recipe
          @recipe_book = RecipeBook.find_by(recipe_id: @recipe.id, user_id: current_user_id).destroy
          format.json { render json: { message: 'Removed!'} }
        else
          RecipeBook.create(recipe_id: @recipe.id, user_id: current_user_id)
          format.json { render json: { message: 'Added!'} }
        end
    	else
          format.json { render json: { message: 'Invalid Recipe!'} }
      end
    end
  end

  private
  def recipe_params
  	params.require(:recipe).permit(:url, :image_url, :instructions, :ingredients, :name)
  end
end
