class RecipesController < ApplicationController
  def show
    @recipes = Recipe.newyorktimes(rand(119).to_s)
  end
end
