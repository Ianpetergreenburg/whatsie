class RecipesController < ApplicationController
  def show
    @recipes = Recipe.newyorktimes(rand(119).to_s)
  end

  def create 
  	@recipe = Recipe.create(recipe_params)
  	if @recipe.valid?

  	else

  	end
  end

  private
  def recipe_params
  	params.require(:recipe).permit(:url, :image_url, :instructions, :ingredients, :name)
  end
end
