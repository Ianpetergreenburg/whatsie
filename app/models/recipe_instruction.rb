class RecipeInstruction < ActiveRecord::Base
  belongs_to :recipe

   validates_uniqueness_of :order, scope: :recipe_id
end
