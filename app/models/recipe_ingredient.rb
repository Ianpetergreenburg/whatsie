class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  def to_s
    "#{amount} #{unit} #{ingredient.name}".strip
  end
end
