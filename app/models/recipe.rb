require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'

class Recipe < ActiveRecord::Base
  has_many :recipe_books
  has_many :users, through: :recipe_books
  has_many :recipe_ingredients
  has_many :recipe_instructions

  validates_presence_of :name
  validates_presence_of :url

  def ingredients
    recipe_ingredients
  end

  def instructions
    recipe_instructions.sort_by{|ri| ri.order }.map do |recipe_instruction|
      recipe_instruction
    end
  end

  def load_ingredients(ingredients_to_load)
    ingredients_to_load.each_with_index do |ingredient, order|
      if ingredient.class ==  Ingreedy::Parser::Result
        ingredient.amount = '' if ingredient.amount == 0
        ingredient.unit = 'to taste' if ingredient.unit == :to_taste
        ing = Ingredient.find_or_create_by(name: ingredient.ingredient)

        RecipeIngredient.create(
            recipe_id: id,
            ingredient_id: ing.id,
            amount: ingredient.amount.to_s,
            unit: ingredient.unit.to_s,
            order: order
          )
      else
        ing = Ingredient.find_or_create_by(name: ingredient)
        RecipeIngredient.create(recipe_id: id, ingredient_id: ing.id, order: order)
      end
    end
  end

  def load_instructions(instructions_to_load)
    instructions_to_load.each_with_index do |instruction, order|
      RecipeInstruction.create(recipe_id: id, instruction: instruction, order: order)
    end
  end
end
