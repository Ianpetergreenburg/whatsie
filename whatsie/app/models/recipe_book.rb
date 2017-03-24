class RecipeBook < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates_presence_of :user_id, :recipe_id
  validates_uniqueness_of :user_id, scope: :recipe_id
end
