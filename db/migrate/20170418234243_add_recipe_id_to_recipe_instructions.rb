class AddRecipeIdToRecipeInstructions < ActiveRecord::Migration[5.0]
  def change
    add_column :recipe_instructions, :recipe_id, :integer, null: false
  end
end
