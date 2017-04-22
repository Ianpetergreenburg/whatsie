

class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]

  def index
    JobLoaderStarterJob.perform_later
    @recipes = Recipe.order("id desc").limit(20)
  end

  def random
    JobLoaderScraperJob.perform_later
    @recipes = Recipe.order("Random()").limit(20)
  end

  def show
  end

  def edit
    if can_edit? @recipe
      render 'edit'
    elsif current_user
      @recipe = @recipe.clone(current_user)
      redirect_to "/recipes/#{@recipe.id}/edit"
    else
      redirect_to '/'
    end
  end


  def update
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
    if current_user
      instructions = JSON.parse(recipe_params['instructions'])
      ins = []
      instructions['length'].times do |i|
        ins << instructions[i.to_s]
      end
      ingredients = JSON.parse(recipe_params['ingredients'])
      ing = []
      ingredients['length'].times do |i|
        ing << ingredients[i.to_s]
      end

      @recipe.create(recipe_params.except('ingredients', 'instructions'))
      if @recipe.save
        @recipe.chef = current_user
        @recipe.load_instructions(ins)
        @recipe.load_ingredients(ing)
        redirect_to "/recipes/#{@recipe.id}"
      else
        render :new
      end
    end
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    if can_delete? @recipe
      @recipe.destroy
      redirect_to user_path current_user
    else
      redirect_to '/'
    end
  end

  private
  def find_recipe
    @recipe = Recipe.find_by_id(params[:id])
    unless @recipe
      not_found
    end
  end

  def recipe_params
  	params.require(:recipe).permit(:url, :image_url, :instructions, :ingredients, :name)
  end
end
