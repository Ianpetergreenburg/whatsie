

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

  def edit
    @recipe = Recipe.find_by_id(params[:id])
    if current_user && current_user_admin || current_user && current_user == @recipe.chef
      render 'edit'
    else
      redirect_to '/'
    end
  end


  def update
    @recipe = Recipe.find_by(id: params[:id])
    if recipe_params['instructions']
      instructions = JSON.parse(recipe_params['instructions'])
      ins = []
      instructions['length'].times do |i|
        ins << instructions[i.to_s]
      end
      @recipe.dump_instructions
      @recipe.load_instructions(ins)
    end
    if recipe_params['ingredients']
      ingredients = JSON.parse(recipe_params['ingredients'])
      ing = []
      ingredients['length'].times do |i|
        ing << ingredients[i.to_s]
      end
      @recipe.dump_ingredients
      @recipe.load_ingredients(ing)
    end
    if recipe_params['name']
      @recipe.update(name: recipe_params['name'])
    end
  end

  def new
    if current_user
      @recipe = Recipe.new
    else
      redirect_to '/'
    end
  end

  def create
    if current_user && current_user_admin || current_user && current_user == @recipe.chef
      render 'edit'
    else
      redirect_to '/'
    end
    recipe_params
  end

  private
  def recipe_params
  	params.require(:recipe).permit(:url, :image_url, :instructions, :ingredients, :name)
  end
end
