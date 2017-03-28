class AddingUniquenessToRecipeBooks < ActiveRecord::Migration[5.0]
  def change
    add_index :recipe_books, [ :user_id, :recipe_id ], :unique => true
  end
end
