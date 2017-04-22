require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'deep_cloneable'

class Recipe < ActiveRecord::Base
  has_many :recipe_books
  has_many :users, through: :recipe_books
  has_many :recipe_ingredients
  has_many :recipe_instructions
  belongs_to :chef, class_name: 'User', optional: true

  validates_presence_of :name
  validates_presence_of :url

  def ingredients
    recipe_ingredients.sort_by do |recipe_ingredients|
      recipe_ingredients.order
    end
  end

  def instructions
    recipe_instructions.sort_by{|ri| ri.order }
  end

  def clone(user)
    new_copy = self.deep_clone include: [:recipe_ingredients, :recipe_instructions]
    new_copy.chef = user
    new_copy.name = "#{user.username}'s #{new_copy.name}"
    new_copy.save
    new_copy
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
  def dump_instructions
    self.recipe_instructions.destroy_all
  end
  def dump_ingredients
    self.recipe_ingredients.destroy_all
  end
  def load_instructions(instructions_to_load)
    instructions_to_load.each_with_index do |instruction, order|
      RecipeInstruction.create(recipe_id: id, instruction: instruction, order: order)
    end
  end
end
