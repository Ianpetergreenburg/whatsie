require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'

class Recipe < ActiveRecord::Base
  has_many :recipe_books
  has_many :users, through: :recipe_books
  has_many :recipe_ingredients

  validates_presence_of :name
  validates_presence_of :instructions
  validates_presence_of :url

  def ingredients
    recipe_ingredients.map do |recipe_ingredient|
      recipe_ingredient.to_s
    end
  end

  def load_ingredients(ingredients)
    ingredients.each do |ingredient|
      if ingredient.class ==  Ingreedy::Parser::Result
        ingredient.amount = '' if amount == 0
        ingredient.unit = 'to_taste' if ingredient.unit = :to_taste
        ing = Ingredient.find_or_create_by(name: ingredient.ingredient)
        RecipeIngredient.create(recipe_id: id, ingredient_id: ing.id, amount: ingredient.amount.to_i, unit: ingredient.unit.to_s)
      else
        ing = Ingredient.find_or_create_by(name: ingredient)
        RecipeIngredient.create(recipe_id: id, ingredient_id: ing.id)
      end
    end
  end
end
